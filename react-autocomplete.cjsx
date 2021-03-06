autoitems = new Mongo.Collection null

validateAutocomplete = new ReactiveDict()

RAC = {}

RAC.getValidationAutocomplete = (attr) -> validateAutocomplete.get(attr)

RAC.stateMx = {
    setStateById: (id) ->
        for v in (@autocompleteTags or [])
            validateAutocomplete.set(v, true)
        @replaceState @collection.findOne(id)

    replaceStateByObject: (obj) ->
        if _.isEmpty(id)
            for v in (@autocompleteTags or [])
                validateAutocomplete.set(v, false)
            @replaceState {}
        else
            for v in (@autocompleteTags or [])
                validateAutocomplete.set(v, true)
            @replaceState obj
}

#RAC.validationMx = {
#    isValidAutocomplete: (attr) ->
#        c.get(attr)
#}

RAC.changeDataMx = {
    changeDataAutocomplete: (attr) ->
            (value) =>
                dct = {}
                dct[attr] = value
                @setState dct
}

Item = React.createClass
    mixins: [ReactMeteorData]
    getMeteorData: ->
        item = autoitems.findOne({selected:true})
        if item and item.index == @props.index
            classes = 'item selected'
        else
            classes = 'item'
        klass: classes
    onclick: (e) ->
        @props.changeData @props.value
        autoitems.remove(tag:@props.tag)
        validateAutocomplete.set(@props.tag, true)
    render: ->
        <div onClick=@onclick className=@data.klass>
            {if @props.renderTemplate
                React.createElement(@props.renderTemplate, value:@props.value)
            else
                @props.value}
        </div>

#

RAC.Autocomplete = React.createClass
    mixins: [ReactMeteorData]
    keyup: (e) ->
        if e.keyCode == 38 #up
            index = autoitems.findOne({selected:true}).index
            index = index - 1
            if index < 0
                index = 0
            autoitems.update({ag: @props.tag}, {$set: {selected: false}}, {multi: true})
            autoitems.update({index: index}, {$set: {selected: true}})
        else if e.keyCode == 40
            index = autoitems.findOne({selected:true}).index
            index = index + 1

            if index == autoitems.find({}).count()
                index = 0
            autoitems.update({}, {$set: {selected: false}}, {multi:true})
            autoitems.update({index: index}, {$set: {selected: true}})
        else if e.keyCode == 13
            @props.changeData autoitems.findOne({selected:true})[@props.reference]
            autoitems.remove({})
            validateAutocomplete.set(@props.tag, true)

    focusout: (e) ->
        if not $(e.relatedTarget).hasClass('popover')
            autoitems.remove({})
    change: (e) ->
        query = e.target.value
        @props.changeData query
        Meteor.call @props.call, query, (err, result) =>
            autoitems.remove({})
            if query in (r[@props.reference] for r in result)
                validateAutocomplete.set([@props.tag], true)
            else
                validateAutocomplete.set([@props.tag], false)
            for r, i in result
                r.tag = @props.tag
                r.index = i
                if i == 0
                    r.selected = true
                autoitems.insert r

    getMeteorData: ->
        autoitems: autoitems.find(tag:@.props.tag).fetch()
    render: ->
        <span className='widget'>
            <input type='text' value=@props.value onChange=@change onBlur=@focusout onKeyUp=@keyup />
            <div className='popover' tabIndex='100'>
                {<Item key={item._id} value={item[@props.reference]} renderTemplate=@props.renderTemplate index={i} changeData=@props.changeData tag=@props.tag /> for item, i in @data.autoitems}
            </div>
        </span>

