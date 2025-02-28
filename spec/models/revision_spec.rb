# frozen_string_literal: true

require "spec_helper"

RSpec.describe Revix::Revision do
  let(:revision_data) do
    date = [
      Revix::DateInfo.new(type: "published", value: "2012-04")
    ]
    name = Revix::Name.new(abbreviation: "JMS", completename: "J. Michael Straczynski")
    person = Revix::Person.new(name: name)
    contributor = Revix::Contributor.new(person: person)
    amendment = Revix::Amendment.new(description: "Approved edition of S-102")

    Revix::Revision.new(
      date: date,
      edition: "1.0.0",
      contributor: [contributor],
      amend: [amendment]
    )
  end

  describe ".new" do
    it "creates a new Revision object" do
      revision = revision_data
      expect(revision).to be_a(Revix::Revision)
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
      parsed = Revix::Revision.from_xml(xml1)
      xml2 = parsed.to_xml

      # Canonicalize both XMLs and compare using xml-c14n
      c14n1 = Xml::C14n.format(xml1)
      c14n2 = Xml::C14n.format(xml2)

      expect(c14n2).to eq(c14n1)
      expect(c14n2).to be_analogous_with(c14n1)
    end
  end
end
