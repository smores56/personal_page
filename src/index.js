import "./main.css";
import { Elm } from "./Main.elm";
import * as serviceWorker from "./serviceWorker";
import * as Tone from "./Tone";

const app = Elm.Main.init({
  node: document.getElementById("root"),
  flags: new Date().getTime(),
});

const synth = new Tone.PolySynth(12, Tone.Synth, {
  harmonicity: 3.999,
  oscillator: {
    type: "sine",
  },
  envelope: {
    attack: 0.03,
    decay: 0.3,
    sustain: 0.7,
    release: 0.8,
  },
  modulation: {
    volume: 4,
    type: "square6",
  },
  modulationEnvelope: {
    attack: 2,
    decay: 3,
    sustain: 0.8,
    release: 0.1,
  },
}).toMaster();
synth.volume.value = -15;

const monoSynth = new Tone.MonoSynth({
  oscillator: {
    type: "square",
  },
  filter: {
    Q: 2,
    type: "lowpass",
    rolloff: -12,
  },
  envelope: {
    attack: 0.005,
    decay: 3,
    sustain: 0,
    release: 0.45,
  },
  filterEnvelope: {
    attack: 0.001,
    decay: 0.32,
    sustain: 0.9,
    release: 3,
    baseFrequency: 700,
    octaves: 2.3,
  },
}).toMaster();
monoSynth.volume.value = -10;

Tone.Transport.start();
Tone.Transport.bpm.value = 140;

app.ports.playChord.subscribe((notes) => {
  synth.releaseAll();
  synth.triggerAttackRelease(notes, "1n");
});

app.ports.playTheLick.subscribe(function () {
  const notes = ["D4", "E4", "F4", "G4", "E4", null, "C4", "D4"];

  const sequence = new Tone.Sequence(
    (time, note) => {
      monoSynth.triggerAttackRelease(note, time);
    },
    notes,
    "8n"
  );

  sequence.loop = false;
  sequence.start();
});

// If you want your app to work offline and load faster, you can change
// unregister() to register() below. Note this comes with some pitfalls.
// Learn more about service workers: https://bit.ly/CRA-PWA
serviceWorker.unregister();
