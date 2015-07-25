react-autocomplete
==================

An autocomplete widget for React.

Example
-------

(RAC = React Autocomplete; RMMx = React Model Mixins)

```coffee
renT = ReactMeteor.createClass
    render: ->
        <span>author: <b>{@props.value}</b></span>

A = ReactMeteor.createClass
    mixins: [RAC.autocompleteMx, RAC.stateMx, RMMx.saveMx, RMMx.validationMx, RMMx.integerMx]
    autocompleteIds: ['myTag', 'myTag2']
    collection: myCollection
    validations: -> AValidations(this)
    getInitialState: ->
        text1: ''
        text2: ''
        x: 0
    getMeteorState: ->
        error_text1: => if not @isValidAttr('text1') then 'error autocomplete' else ''
    error_x: -> if not @isValidAttr('x') then 'x>=5' else ''
    random: -> Math.random()
    render: ->
        <div>
            <RAC.Autocomplete value=@state.text1 call='autocomplete' reference='value' renderTemplate=renT tag='myTag' changeData=@changeDataAutocomplete('text1') />
            <span className='red'>{@state.error_text1()}</span>
            <RAC.Autocomplete value=@state.text2 call='autocomplete' reference='value' tag='myTag2' changeData=@changeDataAutocomplete('text2') />
            <input type='text' value=@state.x onChange=@changeDataInteger('x')  />
            <span className='red'>{@error_x()}</span>
            <button disabled=@isNotValid() onClick=@save >save</button>
            <span>{@random()}</span>
        </div>

Main = ReactMeteor.createClass
    templateName: 'main'
    reset: ->
        @refs.ref1.setStateByObjectOrId({})
    render: ->
        <div>
            <A ref='ref1' />
            <button onClick=@reset>reset</button>
        </div>
```

Server side:

```cooffee
Meteor.methods
  autocomplete: (query) -> 
    authors.find(value: {$regex: '.*'+query+'.*'}).fetch()

```