# activerecord-internals (aka EmpanadaRecord)
ActiveRecord Internals talk. Code and Resources

Talk slides [here](https://speakerdeck.com/orendon/activerecord-internals-empanadarecord-medellin-dot-rb)

## EmpanadaRecord
Our *just-for-fun* implementation of [Active Record pattern](http://www.martinfowler.com/eaaCatalog/activeRecord.html)

Our rails inspired API:

```ruby
class Product < EmpanadaRecord::Base
  attr_accessor :id, :name

  #...
end

Product.all             # retrieves all products in DB
Product.find(99)        # retrieve a product with ID=99

```

### Today Kata
Fork and grow `EmpanadaRecord`. Pull Requests are welcome

Some ideas:

* Implement `all, count, first, last, where, etc`
* Implement `find_by_attribute` (dynamic attributes)
* Add support for multiple DB adapters (see [Adapter pattern](http://en.wikipedia.org/wiki/Adapter_pattern))
* Improve DB setup/teardown in tests
