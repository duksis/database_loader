require File.join(File.dirname(__FILE__), '../spec_helper')

module DatabaseLoader
  describe SqlStatement do

    shared_examples 'statment' do |statment, name, type|
      s = SqlStatement.new statment
      it 'should recognize name' do
        s.name.should == name
      end
      it 'should recognize type' do
        s.type.should == type
      end
      it 'should have content' do
        s.to_s.should_not be_nil
      end
    end

    shared_examples 'statments' do |statments, static, name, type|
      statments.each do |statment|
        context "with #{statment}" do
          if static.respond_to? :call
            include_examples 'statment', static.call(statment), name, type
          else
            include_examples 'statment', "#{statment} #{static}", name, type
          end
        end
      end
    end

    describe 'View' do
      statments = ['DROP','CREATE','CREATE OR REPLACE','CREATE OR REPLACE FORCE']
      fixed_part, name, type = 'VIEW xx_example_v AS SELECT * FROM dual;', 'xx_example_v', 'view'
      include_examples 'statments', statments, fixed_part, name, type
    end

    describe 'Materialized view' do
      include_examples 'statments', ['ALTER','CREATE','DROP'], 'MATERIALIZED VIEW xx_example_mv;', 'xx_example_mv', 'materialized view'
    end

    ['Package','Package body'].each do |package|
      describe package do
        fixed_part = "#{package.upcase} xx_example_pkg IS PROCEDURE DO_SOMETHING ( ... ); END xx_example_pkg;"
        include_examples 'statments', ['DROP','CREATE','CREATE OR REPLACE'], fixed_part, 'xx_example_pkg', package.downcase
      end
    end

    describe 'Grant' do
      statments = ['SELECT', 'EXECUTE', 'SELECT, EXECUTE']
      fixed_part, name, type = lambda{|statment|"GRANT #{statment} ON xx_example TO xxtest;"}, 'xx_example', 'grant'
      context 'name without schema' do
        include_examples 'statments', statments, fixed_part, name, type
      end
      context 'name with schema' do
        fixed_part = lambda{|statment|"GRANT #{statment} ON xx.xx_example TO xxtest;"}
        include_examples 'statments', statments, fixed_part, name, type
      end
    end

    describe 'Index' do
      statments = ['ALTER','CREATE','CREATE UNIQUE']
      fixed_part, name, type = 'INDEX index_name ON table_name (function1, function2, . function_n)', 'index_name', 'index'
      include_examples 'statments', statments, fixed_part, name, type
    end

  end
end