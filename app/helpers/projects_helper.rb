module ProjectsHelper
  def customers_for_select
      Customer.all.collect { |c| [c.name, c.id] }
  end
end
