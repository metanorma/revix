# frozen_string_literal: true

require "spec_helper"

RSpec.describe Revix::RevisionHistory do
  fixture_path = File.join(__dir__, "..", "fixtures")
  let(:yaml_content) { File.read(File.join(fixture_path, "sample.yaml")) }
  let(:xml_content) { File.read(File.join(fixture_path, "sample.xml")) }
  let(:iho_yaml_content) { File.read(File.join(fixture_path, "iho_sample.yaml")) }
  let(:ogc_yaml_content) { File.read(File.join(fixture_path, "ogc_sample.yaml")) }

  describe ".from_yaml" do
    it "parses YAML content into a RevisionHistory object" do
      history = Revix::RevisionHistory.from_yaml(yaml_content)
      expect(history).to be_a(Revix::RevisionHistory)
      expect(history.revisions.size).to eq(2)
    end

    it "parses IHO YAML content into a RevisionHistory object" do
      history = Revix::RevisionHistory.from_yaml(iho_yaml_content)
      expect(history).to be_a(Revix::RevisionHistory)
      expect(history.revisions.size).to eq(4)
    end

    it "parses OGC YAML content into a RevisionHistory object" do
      history = Revix::RevisionHistory.from_yaml(ogc_yaml_content)
      expect(history).to be_a(Revix::RevisionHistory)
      expect(history.revisions.size).to eq(2)
    end
  end

  describe ".from_xml" do
    it "parses XML content into a RevisionHistory object" do
      history = Revix::RevisionHistory.from_xml(xml_content)
      expect(history).to be_a(Revix::RevisionHistory)
      expect(history.revisions.size).to eq(2)
    end
  end

  describe "#to_yaml" do
    it "converts a RevisionHistory object to YAML" do
      history = Revix::RevisionHistory.from_yaml(yaml_content)
      yaml = history.to_yaml
      expect(yaml).to be_a(String)
    end
  end

  describe "#to_xml" do
    it "converts a RevisionHistory object to XML" do
      history = Revix::RevisionHistory.from_yaml(yaml_content)
      xml = history.to_xml
      expect(xml).to be_a(String)
      expect(xml).to include("<revision-history>")
      expect(xml).to include("<revision>")
    end

    it "performs round-trip conversion from XML to object and back" do
      # Start with the static XML sample
      original_xml = xml_content

      # Parse to object
      history = Revix::RevisionHistory.from_xml(original_xml)

      # Convert back to XML
      generated_xml = history.to_xml

      # Canonicalize both XMLs and compare using xml-c14n
      c14n_original = Xml::C14n.format(original_xml)
      c14n_generated = Xml::C14n.format(generated_xml)

      expect(c14n_generated).to eq(c14n_original)
      expect(c14n_generated).to be_analogous_with(c14n_original)
    end
  end
end
