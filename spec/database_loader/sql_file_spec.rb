require File.join(File.dirname(__FILE__), '../spec_helper')

module DatabaseLoader
  describe SqlFile do
    file,dependency = SqlFile.new(''), SqlFile.new('')

    it 'should depend' do
      file.stub(:statements => [double('statement',:name => 'xx_dependent_v')],
                :render => 'CREATE VIEW xx_dependent_v AS SELECT * FROM xx_dependency_v;')
      dependency.stub(:statements => [double('statement',:name => 'xx_dependency_v')])

      file.dependencies([file, dependency])[0].object_id.should == dependency.object_id
    end

    it 'should be sorted by dependencies' do
      file.stub(:dependencies => [dependency])
      [file,dependency].sort[0].object_id.should == dependency.object_id
    end

  end
end