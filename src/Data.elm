module Data exposing (Job, Project, Tool, allJobs, allProjects, personalLanguages, proficientLanguages)


type alias Job =
    { company : String
    , location : String
    , position : String
    , startedAt : String
    , left : String
    , description : String
    , accomplishments : List String
    , responsibilities : List String
    , tools : List Tool
    }


type alias Tool =
    { name : String
    , url : String
    }


abbTools : List Tool
abbTools =
    [ { name = "Rust", url = "https://www.rust-lang.org/" }
    , { name = "Docker", url = "https://www.docker.com/" }
    , { name = "Kubernetes", url = "https://kubernetes.io/" }
    , { name = "Cap'n Proto", url = "https://capnproto.org/" }
    , { name = "gRPC", url = "https://grpc.io/" }
    , { name = "JSON Schema", url = "https://json-schema.org/" }
    , { name = "Apache Kafka", url = "https://kafka.apache.org/" }
    ]


ncrTools : List Tool
ncrTools =
    [ { name = "TypeScript", url = "https://www.typescriptlang.org/" }
    , { name = "Angular", url = "https://angular.io/" }
    , { name = "RxJS", url = "https://rxjs-dev.firebaseapp.com/" }
    , { name = "jasmine", url = "https://jasmine.github.io/" }
    , { name = "cypress", url = "https://www.cypress.io/" }
    , { name = "Java", url = "https://www.java.com/en/" }
    , { name = "Spring Boot", url = "https://spring.io/projects/spring-boot" }
    , { name = "Hibernate ORM", url = "https://hibernate.org/orm/" }
    ]


aceTools : List Tool
aceTools =
    [ { name = "TypeScript", url = "https://www.typescriptlang.org/" }
    , { name = "React Native", url = "https://reactnative.dev/" }
    , { name = "Redux (Offline)", url = "https://redux.js.org/" }
    , { name = "Python", url = "https://www.python.org/" }
    , { name = "Django", url = "https://www.djangoproject.com/" }
    , { name = "AWS", url = "https://aws.amazon.com/" }
    ]


allJobs : List Job
allJobs =
    [ { company = "ABB"
      , location = "Atlanta, GA"
      , position = "Rust Developer"
      , startedAt = "March 2020"
      , left = "Present"
      , description =
            "I am currently working to both research and design new systems, as well as upgrade existing "
                ++ "systems using modern tools (primarily Rust). I can't give specific details, as most of my "
                ++ "work is done on private projects, but I have been solving problems with the following "
                ++ "general approach:"
      , accomplishments =
            []
      , responsibilities =
            [ "Research best options for designing systems"
            , "Write, test, and deploy Rust code"
            , "Benchmark and optimize applications to maximize performance"
            ]
      , tools = abbTools
      }
    , { company = "NCR"
      , location = "Atlanta, GA"
      , position = "Full-Stack Developer"
      , startedAt = "July 2019"
      , left = "March 2020"
      , description =
            "I worked as a full-stack developer on NCR's Menu Service, an application for building and serving menus "
                ++ "to restaurants at a high scale. The service comprised a website (Menu Maker) made with Angular 8 written "
                ++ "in TypeScript and a JSON API (Menu API) using Spring Boot written in Java. I was on one of three "
                ++ "teams working on the same project (~20 people)."
      , accomplishments =
            [ "Add state management to frontend with no centralized state management"
            , "Taught best practices to multiple teams for state management in websites"
            ]
      , responsibilities =
            [ "Develop best approaches to problems in team discussions"
            , "Add new features on frontend + backend"
            , "Write unit and integration tests"
            ]
      , tools = ncrTools
      }
    , { company = "Ace Industries"
      , location = "Atlanta, GA"
      , position = "Part-Time App Developer"
      , startedAt = "January"
      , left = "May 2019"
      , description =
            "I worked between classes to help a startup migrate complex, outdated systems for an entire manufacturing "
                ++ "company to a unified set of applications. I primarily helped with development of features on the React "
                ++ "Native app. The service ran on top of a Django JSON API in Python 3 that coordinated Amazon S3 data "
                ++ "and a 50+ table database."
      , accomplishments =
            [ "Leveraged Redux Offline to allow users to work without internet"
            , "Added type safety to codebase for safety and readability"
            , "Moved to Material UI framework for cohesiveness of user experience"
            ]
      , responsibilities =
            [ "Write and test React Native components"
            , "Design app pages for ergonomics and aesthetic needs"
            , "Refactor existing code to provide similar behavior for existing userbase"
            ]
      , tools = aceTools
      }
    ]


type alias Project =
    { name : String
    , github : String
    , description : String
    , toolsUsed : List Tool
    }


sitchTools : List Tool
sitchTools =
    [ { name = "Rust", url = "https://www.rust-lang.org/" }
    , { name = "StructOpt", url = "https://github.com/TeXitoi/structopt" }
    , { name = "reqwest", url = "https://github.com/seanmonstar/reqwest" }
    , { name = "select.rs", url = "https://github.com/utkarshkukreti/select.rs" }
    , { name = "Serde JSON", url = "https://github.com/serde-rs/json" }
    ]


chesskerTools : List Tool
chesskerTools =
    [ { name = "Zig", url = "https://ziglang.org/" }
    , { name = "mecha (parser combinator)", url = "https://github.com/Hejsil/mecha" }
    , { name = "Wikipedia", url = "https://en.wikipedia.org/wiki/Rules_of_chess" }
    ]


thisSiteTools : List Tool
thisSiteTools =
    [ { name = "Elm", url = "https://elm-lang.org/" }
    , { name = "Skeleton CSS", url = "http://getskeleton.com/" }
    , { name = "Tone.js", url = "https://tonejs.github.io/" }
    ]


allProjects : List Project
allProjects =
    [ { name = "Sitch"
      , github = "https://github.com/smores56/sitch"
      , description =
            "A CLI written in Rust that notifies you of new content that you follow, like on YouTube or RSS feeds, "
                ++ "and conveniently sends notifications to your desktop. It's blazing fast thanks to Rust's performance and the "
                ++ "fantastic Rayon library, which easily parallelized network requests and boosted performance about 6 times."
      , toolsUsed = sitchTools
      }
    , { name = "Chessker"
      , github = "https://github.com/smores56/chessker"
      , description =
            "A terminal app to verify a sequence of chess moves and display the state of the game in your console. "
                ++ "Born as a marriage between a newfound interest in playing chess with friends online and learning the Zig "
                ++ "programming language, I have had great success implementing the complex rules chess prescribes with Zig's "
                ++ "combination of high-level abstractions (generics via compile time evaluation, strict null checks, enum-based "
                ++ "error handling), and look forward to seeing it rise to popularity."
      , toolsUsed = chesskerTools
      }
    , { name = "This Website"
      , github = "https://github.com/smores56/personal_page"
      , description =
            "My personal page is a testament to my love for the Elm language, and what it affords its users. This website loads "
                ++ "very quickly with help from Elm's ability to easily eliminate dead code. In addition, Elm's declarative style "
                ++ "made writing Sudoku a breeze, and the source is extremely simple."
      , toolsUsed = thisSiteTools
      }
    ]


proficientLanguages : List Tool
proficientLanguages =
    [ { name = "Rust"
      , url = "https://www.rust-lang.org/"
      }
    , { name = "Python"
      , url = "https://www.python.org/"
      }
    , { name = "TypeScript"
      , url = "https://www.typescriptlang.org/"
      }
    , { name = "Elm"
      , url = "https://elm-lang.org/"
      }
    , { name = "Crystal"
      , url = "https://crystal-lang.org/"
      }
    , { name = "Zig"
      , url = "https://ziglang.org/"
      }
    , { name = "C"
      , url = "https://en.wikipedia.org/wiki/C_(programming_language)"
      }
    , { name = "Java"
      , url = "https://docs.oracle.com/javase/8/docs/technotes/guides/language/index.html"
      }
    ]


personalLanguages : List Tool
personalLanguages =
    [ { name = "Pony"
      , url = "https://www.ponylang.io/"
      }
    , { name = "Haskell"
      , url = "https://www.haskell.org/"
      }
    , { name = "Kotlin"
      , url = "https://kotlinlang.org/"
      }
    , { name = "Mint"
      , url = "https://www.mint-lang.com/"
      }
    , { name = "Unison"
      , url = "https://www.unisonweb.org/"
      }
    , { name = "Formality"
      , url = "https://github.com/moonad/Formality"
      }
    ]
