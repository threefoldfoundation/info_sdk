# Introduction

TODO: explain what our service is like 



<!-- | Column 1 Header | Column 2 Header | Column 3 Header |
| --------------- | :-- | --:|
| Row 1 Column 1 | Row 1 Column 2 | Row 1 Column 3 |
| Row 2 Column 1 | Row 2 Column 2 | Row 2 Column 3 |
| Row 3 Column 1 | Row 3 Column 2 | Row 3 Column 3 | -->


<!-- <iframe src="demo_iframe.htm" height="500" width="900">

</iframe> -->


<link rel="stylesheet" href="//cdn.webix.com/edge/webix.css" type="text/css">
<script src="//cdn.webix.com/edge/webix.js" type="text/javascript"></script>

<div id="testB"></div>

<script type="text/javascript" charset="utf-8">
webix.ui({
 container:"content",
 id:"testB",
 width:700,
 height: 700,
 rows:[{ view:"toolbar",
   css:"webix_dark",
   paddingX:17,
   elements:[
    {view:"label", label:"A form"},
    {},
    {view:"icon", icon:"mdi mdi-help-circle-outline"}
   ]},
   { view:"form",
    elementsConfig:{
     labelWidth:130
    },
    elements:[
     { view:"text", label:"Username", value:"John Doe" },
     { view:"datepicker", label:"Date of birth", value:new Date(1985, 0, 31) },
     { view:"combo", label:"Country", placeholder:"Type to search...",
     // options:"//docs.webix.com/samples/server/countries" 
     },
     { view:"switch", labelRight:"Keep this data private", labelWidth:0, value:1 },
     { view:"colorpicker", label:"Main theme color", value:"#6E00DD" },
     { cols:[
     { view:"label", label:"Select language", width:130 },
     { view:"segmented", options:[
      {id:"en", value:"English"},
      {id:"fr", value:"Français"},
      {id:"de", value:"Deutsch"},
     ]}
     ]},
     { view:"checkbox", labelRight:"I agree with the terms of <b>Privacy Policy</b>", labelWidth:0, value:0 },
     { cols:[
     {},
     { view:"button", css:"webix_danger", value:"couldcel", width:150 },
     { view:"button", css:"webix_primary", value:"Submit", width:150 }
     ]}
    ]
   },
   { view:"datatable",
    autoConfig:true,
    editable:false,
    data:[{
    title:"My Fair Lady", year:1964, votes:533848, rating:8.9, rank:5
    },{title:"My FrLady", year:1964, votes:533848, rating:2, rank:5}]
   }
  ]
})
</script>

#TODO: how do we need to integrate this so it shows next to navigation?