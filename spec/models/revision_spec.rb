# frozen_string_literal: true

require "spec_helper"

RSpec.describe Revix::Revision do
  let(:revision_data) do
    date = [
      Revix::DateInfo.new(type: "published", value: "2012-04"),
    ]
    name = Revix::Name.new(abbreviation: "JMS",
                           completename: "J. Michael Straczynski")
    person = Revix::Person.new(name: name)
    contributor = Revix::Contributor.new(person: person)
    amendment = Revix::Amendment.new(description: "Approved edition of S-102")

    described_class.new(
      date: date,
      edition: "1.0.0",
      contributor: [contributor],
      amend: [amendment],
    )
  end

  describe ".new" do
    it "creates a new Revision object" do
      revision = revision_data
      expect(revision).to be_a(described_class)
      expect(revision.edition).to eq("1.0.0")
      expect(revision.date.size).to eq(1)
      expect(revision.date.first.type).to eq("published")
      expect(revision.date.first.value).to eq("2012-04")
      expect(revision.contributor.size).to eq(1)
      expect(revision.contributor.first.person).not_to be_nil
      expect(revision.contributor.first.person.name.abbreviation).to eq("JMS")
      expect(revision.contributor.first.person.name.completename).to eq("J. Michael Straczynski")
      expect(revision.amend.size).to eq(1)
      expect(revision.amend.first.description).to eq("Approved edition of S-102")
    end
  end

  describe "#to_xml" do
    it "converts a Revision object to XML and back" do
      original = revision_data
      xml1 = original.to_xml

      # Parse back to object and generate XML again
      parsed = described_class.from_xml(xml1)
      xml2 = parsed.to_xml

      # Compare the original and generated XML
      expect(xml2).to be_xml_equivalent_to(xml1)
    end
  end
end
