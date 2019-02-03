# EF GUD Elm Components

This is a representation of the EF design system implemented using Elm 0.19. 

It also includes a set of "Stories" a la _Storybook_ to explain and demonstrate
example usage (probably this should be split into two projects in the end).

The project is bootstrapped using [Create Elm App](https://github.com/halfzebra/create-elm-app).

To gets things up and running locally you will need to clone the repo and make
sure that you have create-elm-app installed globally:

```
npm install -g create-elm-app
```

To run a local development server run:

```
elm-app start
```

This will launch the app on [http://localhost:3000](http://localhost:3000) with hot reloading enabled.

To create a release build run:

```
elm-app build
```

### Design Principles

These components try to offer a very thin wrapper around straight html. The
intention is to make use of the GUD css as-is in order to stay in line with
future updates more easily and to reduce the complexity of the implementation.

Furthermore the dsl used is designed to mirror the dsl for standard html creation within
Elm. This means that in general we use the same form: a function with the name
of the component we are creating which accepts a list of properties and then a
list of child components (where appropriate). We add value by adding a layer of type safety to ensure that only valid properties can be added to each component and by adding types to constrain simple values within the ranges dictated by the GUD. 

There are pros and cons to this approach. On the plus side it results in a very familiar pattern of usage which is very similar to the generation of standard html in Elm. On the downside it is not as type safe as it could possibly be since the properties are represented as a list rather than an algebraic type (which would allow us to exclude *all* invalid combinations. This seemed like a good compromise as the ADT approach does make the library less convenient to use.

### Contribution

With the design considerations given above, contributions are welcome via PR. If
you add a component, please also add a story and wire it up in the Main.elm
module. For a roadmap of what needs doing, have a look at [http://code.ef.design](http://code.ef.design). If you want to add something that is not part of the GUD or you feel like it makes sense to deviate from the design principles adopted so far then it's probably worth a discussion before you begin.

