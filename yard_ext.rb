require 'yard'
class FattrHandler < YARD::Handlers::Ruby::AttributeHandler
  handles method_call(:fattr)
  namespace_only

  def process
    name = statement.parameters.first.jump(:tstring_content, :ident).source
    object = YARD::CodeObjects::MethodObject.new(namespace, name)
    register(object)
    parse_block(statement.last.last, :owner => object)

    # modify the object 
    object.dynamic = true 

    # add custom metadata to the object
    object['custom_field'] = 'Generated by Fattr'
  end
end