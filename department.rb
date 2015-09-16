require 'active_record'

ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: 'db.sqlite3'
)

class Department < ActiveRecord::Base
  has_many :employees



  def add_employee(e)
    e.update(department_id: self.id)
  end

  def total_salary
    employees.sum(:salary)
  end

  def give_raise(total_amount)
    getting_raise = self.employees.where(satisfactory: true)
    getting_raise.each {|e| e.give_raise(total_amount / getting_raise.length)}

  end
end
