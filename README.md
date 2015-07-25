react-autocomplete
==================

An autocomplete widget for React.

Example
-------

In the *lib* folder:

```coffee
@AValidations = (self) ->
  text1: (x) ->
    if Meteor.isClient
      self.isValidAutocomplete('myTag')
    else
      authors.findOne(value:x)
  text2: (x) ->
    if Meteor.isClient
      self.isValidAutocomplete('myTag2')
    else
      authors.findOne(value:x)
  x: (x) -> x >= 5
```  

```coffee
renT = ReactMeteor.createClass
    render: ->
        <span>author: <b>{@props.value}</b></span>
```

```coffee
getMeteorState: ->
    error_text1: => if not @isValidAttr('text1') then 'error autocomplete' else ''
render: ->
    <RAC.Autocomplete value=@state.text1 call='autocomplete' reference='value' renderTemplate=renT tag='myTag' changeData=@changeDataAutocomplete('text1') />
    <span className='red'>{@state.error_text1()}</span>
```

Server side:

```cooffee
Meteor.methods
  autocomplete: (query) -> 
    authors.find(value: {$regex: '.*'+query+'.*'}).fetch()

```

API
---

* stateMx
    * setStateByObjectOrId
      replace the state by the object given. If it's passed an id string, then the state is replaced with the object obtained by the findOne. It resets the validation of the field.
* validationMx
    * isValidAutocomplete
* changeDataMx
    * changeDataAutocomplete
* Autocomplete (component)