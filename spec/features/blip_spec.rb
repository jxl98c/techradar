require "rails_helper"

feature "Blips" do
  let(:user) { create(:user) }
  let(:radar) { create(:radar, owner: user) }

  before do
    login_as(user)
  end

  scenario "Radar has no blips" do
    visit radar_path(radar)
    expect(page).to have_css(".blip", count: 0)
  end

  scenario "Adding a blip" do
    topic = create(:topic, name: "Purple")
    create(:blip, topic: topic)
    visit radar_path(radar)
    click_link "New Blip"
    select "Purple", from: "Topic"
    select "Tools", from: "Quadrant"
    select "Adopt", from: "Ring"
    fill_in "Notes", with: "My Notes"
    click_button "Create Blip"
    expect(page).to have_css(".tools .adopt", text: "Purple")
    purple = page.find(".blip", text: "Purple")
    expect(purple[:title]).to eq "My Notes"
  end

  scenario "Blip details" do
    java = create(:topic, name: "Java")
    radar = create(:radar, owner: user)
    blip = create(:blip, topic: java, radar: radar, notes: "My Notes")
    visit radar_path(radar)
    click_link blip.name
    expect(page).to have_content("My Notes")
  end

  scenario "Delete blip" do
    java = create(:topic, name: "Java")
    radar = create(:radar, owner: user)
    blip = create(:blip, topic: java, radar: radar, notes: "My Notes")
    visit radar_blip_path(radar, blip)
    click_button "Delete Blip"
    expect(current_path).to eq radar_path(radar)
    expect(page).to have_no_content("Java")
  end

  scenario "Edit blip" do
    java = create(:topic, name: "Java")
    radar = create(:radar, owner: user)
    blip = create(:blip, topic: java, radar: radar, ring: "hold")
    visit radar_blip_path(radar, blip)
    click_link "Edit Blip"
    select "Adopt", from: "Ring"
    click_button "Update Blip"
    expect(current_path).to eq radar_path(radar)
    expect(page).to have_css(".tools .adopt", text: "Java")
  end
end
