describe '.merge' do
  let(:result) do
    template = YAML.load_file("spec/fixtures/template.yml")
    stub = YAML.load_file("spec/fixtures/stub.yml")

    mason = Mason.new(template: template, stub: stub)
    mason.merge!
    mason.merged_result
  end

  it 'should maintain properties from the template when not specified in the stub' do
    expect(result["properties"]["only_in_template"]).to eq "true"
  end

  it 'should add new properties from the stub' do
    expect(result["properties"]["only_in_stub"]).to eq "true"
  end

  it 'should override template properties with stub properties' do
    expect(result["properties"]["override_with_stub"]).to eq "true"
  end

  it 'should not merge properties that are blank from stubs' do
    expect(result["properties"]["do_edit"].keys).to_not include "blank"
  end

  context 'nested one level' do
    it 'should maintain values from the template when not specified in the stub' do
      expect(result["properties"]["do_not_edit"]["only_in_template"]).to eq "true"
    end

    it 'should add new properties from the stub' do
      expect(result["properties"]["do_not_edit"]["only_in_stub"]).to eq "true"
    end

    it 'should add new properties from the stub that has unique keys from template' do
      expect(result["properties"]["nested_stub"]["only_in_stub"]).to eq "true"
    end

    it 'should override template properties with stub properties' do
      expect(result["properties"]["do_edit"]["override_with_stub"]).to eq "true"
    end
  end

  context 'nested n levels' do
    it 'should maintain values from the template when not specified in the stub' do
      expect(result["properties"]["one"]["two"]["three"]["four"]["only_in_template"])
        .to eq "true"
    end

    it 'should add new properties from the stub' do
      expect(result["properties"]["one"]["two"]["three"]["four"]["only_in_stub"])
        .to eq "true"
    end

    it 'should override template properties with stub properties' do
      expect(result["properties"]["one"]["two"]["three"]["override_with_stub"])
        .to eq "true"
    end
  end
end

describe '.prune' do
  it 'should remove blank properties from the stubs' do
    # Mason.prune
  end
end


#TODO Make examples for nested array objects
#i.e. {"a" => [{"b" => "c"}, {"d" => "e"}]}
