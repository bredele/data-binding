# binding

  > Attribute binding and data binding for modern browsers...and IE8 >

`binding` is an automatic way of updating your HTML whenever the underlying data changes. It does one thing and do it right! It works well with your favorite framework and has been built to suit your development needs.

gif

`binding` is [highly extensible](https://github.com/bredele/binding#plugins), like jQuery you can create your own plugins or reuse some others. The possibilities are limitless and the barrier is so low that you'll want to do it straight away. 

Here's a list of available plugins:
  - [list](https://github.com/bredele/list) create a list by instantiating a template once per item from a collection
  - [event](https://github.com/bredele/event-plugin) listen or delegate events with automatic touch support
  - [control](https://github.com/bredele/control-plugin) toggle or radio elements has never been so easy
  - [stack](https://github.com/bredele/stack-plugin) create a stack of DOM elements for tab-based navigation
  - [bind](https://github.com/bredele/bind-plugin) attribute double way binding
  - [hidden](https://github.com/bredele/hidden-plugin) hide you dom element when the data changes
  - [html](https://github.com/bredele/html-plugin) bind inner html to data
  - [text](https://github.com/bredele/text-plugin) bind inner text to data

## Installation

    $ component install bredele/binding

## Basics

An [example](https://github.com/bredele/binding/blob/master/examples/basics.html) is worth a thousand words.

```html
<span id="card">My github is {github}</span>
```
By default, `binding` applies variable substitution (`{variable}`) from the data model.

```js
var binding = require('binding'),
    el = document.getElementById('card');

binding({
  github: 'bredele'
}).apply(el);
```
You can use variable substitution in every possible HTML and SVG attribute. Here's an other example:

```html
<span id="card" class="{github}">My github is <a href="http://github.com/{github}">{github}</a></span>
```
  > `binding` is a factory but you can use the `new` operator as well.


## Plugins

A `binding` plugin is simply a function or an object that we use to extend the HTML capabilities. It becomes more **expressive, configurable and dynamic**.

```js
binding()
  .add('list', list)
  .apply(el);
```
You choose what plugin you want to use: **your application does just what you need and nothing more**.

```html
<ul list>
  <li></li>
</ul>
```
 > By given a name to your plugins, you avoid scope conflicts and you can reuse a plugin multiple times.


### function plugin

Writing a plugin is as **simple as writing a JavaScript function**.

```js
binding({
    github: 'bredele'
  })
  .add('data-nickname', function(node, str) {
    node.innerHTML = "I am " + this[str];
  })
  .apply(el);
```
A function plugin always has the dom element as first argument and its scope (`this`) is the data model you passed in the constructor.

```html
<span data-nickname="github"></span>
```

In the example above, we define a plugin called `data-nickname` that set the content of the dom element with the value of the attribute `data-nickname`. The result is:

```html
<span data-nickname="github">I am bredele</span>
```

### object binding

Associate a binding to an object. Every function inside this object can be called by the binding.

```html
<!-- el -->
<a data-model="bind:innerHTML,prop"></a>'
```


```js
  var binding = new Binding();
  var Plugin = function(model){
    this.bind = function(el, attr, prop){
      el[attr] = model.prop;
    };
  };

  binding.add('data-model', new Plugin({
    prop : 'http://github.com'
  }));

  binding.apply(el);
```

result:

```html
<a data-model="bind:innerHTML,prop">http://github.com</a>
```

**Note:** 
  - the first argument of the function is the DOM node associated to the binding.
  - Object binding are more flexible and doesn't necessary need a model object.
  - the binding are parsed according the following format (method:arg,arg,...)

## API

### Binding#(model)

  initialize a binding with a model object (right now a simple Object)

### .add(name, binding) 

  add attribute bindings (functions or objects) by name

### .apply(node)

  apply bindings on a give node


## License

  MIT
