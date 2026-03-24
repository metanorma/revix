# frozen_string_literal: true

require "spec_helper"

RSpec.describe Revix::RevisionHistory do
  fixture_path = File.join(__dir__, "..", "fixtures")
  let(:yaml_content) { File.read(File.join(fixture_path, "sample.yaml")) }
  let(:xml_content) { File.read(File.join(fixture_path, "sample.xml")) }
  let(:iho_yaml_content) do
    File.read(File.join(fixture_path, "iho_sample.yaml"))
  end
  let(:ogc_yaml_content) do
    File.read(File.join(fixture_path, "ogc_sample.yaml"))
  end

  describe ".from_yaml" do
    it "parses YAML content into a RevisionHistory object" do
      history = described_class.from_yaml(yaml_content)
      expect(history).to be_a(described_class)
      expect(history.revisions.size).to eq(2)
    end

    it "parses IHO YAML content into a RevisionHistory object" do
      history = described_class.from_yaml(iho_yaml_content)
      expect(history).to be_a(described_class)
      expect(history.revisions.size).to eq(4)
    end

    it "parses OGC YAML content into a RevisionHistory object" do
      history = described_class.from_yaml(ogc_yaml_content)
      expect(history).to be_a(described_class)
      expect(history.revisions.size).to eq(2)
    end
  end

  describe ".from_xml" do
    it "parses XML content into a RevisionHistory object" do
      history = described_class.from_xml(xml_content)
      expect(history).to be_a(described_class)
      expect(history.revisions.size).to eq(2)
    end
  end

  describe "#to_yaml" do
    it "converts a RevisionHistory object to YAML" do
      history = described_class.from_yaml(yaml_content)
      yaml = history.to_yaml
      expect(yaml).to be_a(String)
    end
  end

  describe "#to_xml" do
    it "converts a RevisionHistory object to XML" do
      history = described_class.from_yaml(yaml_content)
      xml = history.to_xml
      expect(xml).to be_a(String)
      expect(xml).to include("<revision-history>")
      expect(xml).to include("<revision>")
    end

    it "performs round-trip conversion from XML to object and back" do
      # Start with the static XML sample
      original_xml = xml_content

      # Parse to object
      history = described_class.from_xml(original_xml)

      # Convert back to XML
      generated_xml = history.to_xml

      # Compare the original and generated XML
      expect(generated_xml).to be_xml_equivalent_to(original_xml)
    end
  end
end
