require File.join(File.dirname(__FILE__), '../spec_helper')
require 'database_loader/template'

module DatabaseLoader
  describe SqlFile do
    it 'should depend' do
      file,dependency = SqlFile.new(''), SqlFile.new('')
      file.stub(:statements => [double('statement',:name => 'xx_dependent_v')],
                :render => 'CREATE VIEW xx_dependent_v AS SELECT * FROM xx_dependency_v;')
      dependency.stub(:statements => [double('statement',:name => 'xx_dependency_v')])

      file.dependencies([file, dependency])[0].object_id.should == dependency.object_id
    end
  end
end