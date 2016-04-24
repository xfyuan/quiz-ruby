FactoryGirl.define do
  factory :track do
    planned_talks { {} }
    talks {
      [
        Talk.new('Writing Fast Tests Against Enterprise Rails 60min'),
        Talk.new('Overdoing it in Python 45min'),
        Talk.new('Lua for the Masses 30min'),
        Talk.new('Ruby Errors from Mismatched Gem Versions 45min'),
        Talk.new('Ruby on Rails: Why We Should Move On 60min')
      ]
    }
  end
end
