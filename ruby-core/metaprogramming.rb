#!/usr/bin/env ruby -wKU

# HW 1-5: Advanced OOP, Metaprogramming, Open Classes and Duck Typing
# metaprograming programacion dinamica
class Class
    def attr_accessor_with_history(*args)
      # recorrer los parámetros para crear sus respectivos métodos y arreglos
      args.each do |attr_name|
        # para cada symbol crear su respectivo getter
        attr_reader attr_name
        # volver el symbol un String para usarlo como nombre de metodo y como
        # nombre de variable i.e ( bar=(args), bar_history )
        method_name = attr_name.to_s
        # al nivel de la clase que invoca este método se ejecutara el siguiente
        # código en tiempo de ejecución, otorgándole nuevos métodos y atributos
        # %Q es para crear un String multilinea
        class_eval %Q(
          def #{method_name}=(args)
            @#{method_name} = args
            @#{method_name}_array ||= [nil]
            @#{method_name}_array << args
          end

          def #{method_name}_history
            @#{method_name}_array
          end
        )
      end
    end

end

class Foo
    attr_accessor_with_history :bar
end

f = Foo.new     # => #<Foo:0x127e678>
f.bar = 3       # => 3
f.bar = :wowzo  # => :wowzo
f.bar = 'boo!'  # => 'boo!'
f.bar_history   # => [nil, 3, :wowzo, 'boo!']
