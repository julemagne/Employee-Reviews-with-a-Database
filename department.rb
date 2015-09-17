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

  def find_smallest_salary
    salary_array = []
    self.employees.each do |e|
    salary_array << e.salary
      end
    salary_array.sort!
    salary_array[0]
    #Returns smallest salary in department...not employee.
  end

  def find_employee_with_smallest_salary
    sorted = self.employees.sort_by { |e| e.salary}
    sorted[0]
  end

  def find_employees_with_above_average_salary
    average_salary = (self.employees.sum(:salary)/self.employees.count)
    sorted = self.employees.sort_by { |e| e.salary}
    sorted.delete_if{|e| e.salary<=average_salary}
    sorted
  end

  def collect_the_palindromes
    p_array = self.employees.each{ |e| e.palindrome_check}
    p_array.delete_if{|e| e.palindrome==false}
    p_array
  end

end
