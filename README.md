react-autocomplete
==================

An autocomplete widget for React.

Example
-------

```coffee
renT = ReactMeteor.createClass
    render: ->
        <span>author: <b>{@props.value}</b></span>

A = ReactMeteor.createClass
    mixins: [autocompleteMx, modelMx]
    autocompleteIds: ['myTag', 'myTag2']
    #collection: myCollection
    getInitialState: ->
        text1: ''
        text2: ''
    getMeteorState: ->
        texto = if not @isValidAutocomplete('myTag') then 'error ' else ''
        error_text1: texto
    render: ->
        <div>
            hola: <Autocomplete value=@state.text1 call='autocomplete' reference='value' renderTemplate=renT tag='myTag' changeData=@changeDataAutocomplete('text1') />
            {@state.error_text1}
            mundo: <Autocomplete value=@state.text2 call='autocomplete' reference='value' tag='myTag2' changeData=@changeDataAutocomplete('text2') />
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
