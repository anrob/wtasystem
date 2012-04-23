object false
node(:data) do
  @contracts.map { |o| { :name => o.first_name } }
end


