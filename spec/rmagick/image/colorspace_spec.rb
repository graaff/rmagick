RSpec.describe Magick::Image, '#colorspace' do
  before do
    @img = Magick::Image.new(100, 100)
    gc = Magick::Draw.new

    gc.stroke_width(5)
    gc.circle(50, 50, 80, 80)
    gc.draw(@img)

    @hat = Magick::Image.read(FLOWER_HAT).first
    @p = Magick::Image.read(IMAGE_WITH_PROFILE).first.color_profile
  end

  it 'works' do
    expect { @img.colorspace }.not_to raise_error
    expect(@img.colorspace).to be_instance_of(Magick::ColorspaceType)
    expect(@img.colorspace).to eq(Magick::SRGBColorspace)
    img = @img.copy

    Magick::ColorspaceType.values do |colorspace|
      expect { img.colorspace = colorspace }.not_to raise_error
    end
    expect { @img.colorspace = 2 }.to raise_error(TypeError)
    Magick::ColorspaceType.values.each do |cs|
      expect { img.colorspace = cs }.not_to raise_error
    end
  end
end