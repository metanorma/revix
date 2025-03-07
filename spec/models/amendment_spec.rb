# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Revix::Amendment do
  let(:simple_amendment_data) do
    Revix::Amendment.new(description: 'Approved edition of S-102')
  end

  let(:complex_amendment_data) do
    locations = [
      Revix::Location.new(type: 'clause', value: '4.0'),
      Revix::Location.new(type: 'clause', value: '12.0'),
      Revix::Location.new(type: 'clause', value: '9.0'),
      Revix::Location.new(type: 'whole', value: nil)
    ]

    classifications = [
      Revix::Classification.new(tag: 'severity', value: 'major'),
      Revix::Classification.new(tag: 'type', value: 'editorial')
    ]

    Revix::Amendment.new(
      description: "Updated clause 4.0 and 12.0.\n\nPopulated clause 9.0.",
      location: locations,
      classification: classifications,
      change: 'modify'
    )
  end

  describe '.new' do
    it 'creates a simple Amendment object' do
      amendment = simple_amendment_data
      expect(amendment).to be_a(Revix::Amendment)
      expect(amendment.description).to eq('Approved edition of S-102')
      expect(amendment.location).to be_nil
      expect(amendment.classification).to be_nil
      expect(amendment.change).to eq('modify') # Default value
    end

    it 'creates a complex Amendment object' do
      amendment = complex_amendment_data
      expect(amendment).to be_a(Revix::Amendment)
      expect(amendment.description).to eq("Updated clause 4.0 and 12.0.\n\nPopulated clause 9.0.")
      expect(amendment.location.size).to eq(4)
      expect(amendment.location.first.type).to eq('clause')
      expect(amendment.location.first.value).to eq('4.0')
      expect(amendment.location.last.type).to eq('whole')
      expect(amendment.location.last.value).to be_nil
      expect(amendment.classification.size).to eq(2)
      expect(amendment.classification.first.tag).to eq('severity')
      expect(amendment.classification.first.value).to eq('major')
      expect(amendment.change).to eq('modify')
    end
  end

  describe '#to_xml' do
    it 'converts a complex Amendment object to XML' do
      amendment = complex_amendment_data
      xml = amendment.to_xml
      expect(xml).to be_a(String)
      expect(xml).to include('<amend>')
      expect(xml).to include("<description>Updated clause 4.0 and 12.0.\n\nPopulated clause 9.0.</description>")
      expect(xml).to include('<location type="clause">4.0</location>')
      expect(xml).to include('<location type="clause">12.0</location>')
      expect(xml).to include('<location type="clause">9.0</location>')
      expect(xml).to include('<location type="whole"></location>')
      expect(xml).to include('<tag>severity</tag>')
      expect(xml).to include('<value>major</value>')
      expect(xml).to include('<tag>type</tag>')
      expect(xml).to include('<value>editorial</value>')
      expect(xml).to include('<change>modify</change>')
    end

    it 'performs round-trip conversion from XML to object and back' do
      original = complex_amendment_data
      xml1 = original.to_xml

      # Parse back to object and generate XML again
      parsed = Revix::Amendment.from_xml(xml1)
      xml2 = parsed.to_xml

      # Canonicalize both XMLs and compare using xml-c14n
      c14n1 = Xml::C14n.format(xml1)
      c14n2 = Xml::C14n.format(xml2)

      expect(c14n2).to eq(c14n1)
      expect(c14n2).to be_analogous_with(c14n1)
    end
  end
end
