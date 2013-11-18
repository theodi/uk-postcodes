Before('@postcode') do
  Postcode.create(
    :postcode        => "AB1 0AA",
    :eastingnorthing => "POINT(385386 801193)",
    :latlng          => "POINT(57.10147801540051 -2.2428351220462)",
    :county          => "S99999999",
    :council         => "S12000033",
    :ward            => "S13002484",
    :constituency    => "S14000002",
    :country         => "S92000003"
  )
  
  Code.create(name: "Aberdeen City", snac: nil, os: "7000000000030421", gss: "S12000033", kind: "UnitaryAuthority")
  Code.create(name: "Lower Deeside", snac: nil, os: "7000000000043300", gss: "S13002484", kind: "UnitaryAuthorityWard")
  Code.create(name: "Aberdeen South", snac: nil, os: "7000000000033487", gss: "S14000002", kind: "WestminsterConstituency")
end