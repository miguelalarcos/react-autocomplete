react-autocomplete
==================

An autocomplete widget for React.

Example
-------

```coffee
validationMx = {
    isValid: ->
        for attr, func of @validations()
            if not func @state[attr]
                return false
        true
}

saveMx = {
    save: ->
        if @state._id
            @collection.update @state._id, $set:@state
        else
            id = @collection.insert @state
            @setState _id: id
}

renT = ReactMeteor.createClass
    render: ->
        <span>author: <b>{@props.value}</b></span>

A = ReactMeteor.createClass
    mixins: [autocompleteMx, stateMx, saveMx, validationMx]
    autocompleteIds: ['myTag', 'myTag2']
    collection: myCollection
    validations: ->
        self=this
        text1: (x) -> self.isValidAutocomplete('myTag')
        text2: (x) -> self.isValidAutocomplete('myTag2')
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
            <button disabled={not @isValid()} onClick=@save >save</button>
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
