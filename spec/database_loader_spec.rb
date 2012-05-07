require File.join(File.dirname(__FILE__), 'spec_helper')

describe DatabaseLoader do
  shared_examples 'have files' do
    DatabaseLoader.schemas.each do |schema|
      it "should have files for #{schema}" do
        DatabaseLoader.files(schema).size.should >= 1
      end
    end
  end

  context 'with dependencies' do
    before(:all) do
      DatabaseLoader.gather_dependencies = true
    end
    include_examples 'have files'
    it 'should be ordered by dependencies' do
      DatabaseLoader.files('apps').first.statements.first.name.should == 'xx_products_v'
    end
  end

  context 'without dependencies' do
    before(:all) do
      DatabaseLoader.gather_dependencies = false
    end
    include_examples 'have files'
    it 'should be ordered alphabetically' do
      DatabaseLoader.files('apps').first.statements.first.name.should == 'xx_cars_v'
    end
  end
end
