import 'package:cloud_firestore/cloud_firestore.dart';

List<Map<String , dynamic>> allProduct = [
  {
    "brand" :"Asus",
    "catId":1,
    "dis":"""Asus ROG Swift Pro PG248QP 24.1-inch FHD 540Hz Gaming Monitor | 90LM08T0-B013B0
    24.1" 16:9 TN Panel
    HDMI | DisplayPort
    Full HD 1920 x 1080 at 540 Hz
    G-Sync
    0.2 ms GtG Response Time
    1000:1 Static Contrast Ratio
    400 nits Brightness
    16.7 Million Colors
    HDR10 Support
    125% sRGB Color Gamut""",
    "ex":true,
    "id":3,
    "image":"https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/screens%2Fasus%2FPG248%2F1.jpg?alt=media&token=d222d0d4-9f80-4725-a5a0-a45333b2938a",
    "images":["https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/screens%2Fasus%2FPG248%2F1.jpg?alt=media&token=d222d0d4-9f80-4725-a5a0-a45333b2938a",
      "https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/screens%2Fasus%2FPG248%2F2.jpg?alt=media&token=9c370c8a-bbf4-4501-9963-4cf8d11ad751",
      "https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/screens%2Fasus%2FPG248%2F3.jpg?alt=media&token=9e7f3e9f-8aea-4f48-a598-b9a6703cb5e4",
      "https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/screens%2Fasus%2FPG248%2F4.jpg?alt=media&token=f42540b7-c74b-4381-81d3-83c75b3eec3c",
      "https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/screens%2Fasus%2FPG248%2F5.jpg?alt=media&token=11b40865-804d-4312-bdee-6d17a6540ee4",
      "https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/screens%2Fasus%2FPG248%2F6.jpg?alt=media&token=53fdcf4c-31c3-460a-970b-ab719b50ca33",
    ],
    "model":"PG248",
    "price":3500,
    "size":'24.1"',
  },
  {
    "brand" :"Asus",
    "catId":1,
    "dis":"""ASUS VA326H Curved Gaming Monitor, 31.5” FHD VA Display, 144Hz Frame Rate, 4ms (GtG) Response Time, 16:9 Aspect Ratio. 1800R Curavture, Built-In Speaker, Flicker Free, Low Blue Light, Black | VA326H
Screen Size: 31.5 "
Aspect Ratio: 16:9
Resolution: 1920 x 1080
Panel Type: VA
Response Time: 4 ms""",
    "ex":true,
    "id":4,
    "image":"https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/screens%2Fasus%2FVA326H%2F1.jpg?alt=media&token=3d0cb781-a718-4f1e-af3a-88e024b25908",
    "images":["https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/screens%2Fasus%2FVA326H%2F1.jpg?alt=media&token=3d0cb781-a718-4f1e-af3a-88e024b25908",
      "https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/screens%2Fasus%2FVA326H%2F2.jpg?alt=media&token=1b65edc2-8ba2-4dd8-875f-f394716cccee",
      "https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/screens%2Fasus%2FVA326H%2F2.jpg?alt=media&token=1b65edc2-8ba2-4dd8-875f-f394716cccee",
      "https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/screens%2Fasus%2FVA326H%2F4.jpg?alt=media&token=d7e9ffd8-d4fc-4729-ab5b-0a8cfddd404e",
      "https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/screens%2Fasus%2FVA326H%2F5.jpg?alt=media&token=2944d910-fdb9-4da8-a62d-3c5f8e317780",
      "https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/screens%2Fasus%2FVA326H%2F7.jpg?alt=media&token=7bf4fada-388c-4521-8d3c-de969dab9ff4",
    ],
    "model":"VA326H",
    "price":950,
    "size":'31.5"',
  },
  {
    "brand" :"Asus",
    "catId":1,
    "dis":"""ASUS VG248QG 24" G-SYNC Gaming Monitor 165Hz 1080p 0.5ms Eye Care with DP HDMI DVI,Black
Brand	ASUS
Screen size	24 Inches
Resolution	FHD 1080p
Aspect ratio	16:9
Screen surface description Flat""",
    "ex":true,
    "id":5,
    "image":"https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/screens%2Fasus%2FVG248%2F1.jpg?alt=media&token=8ebbea60-6cbb-461f-bcd8-2da634d8c408",
    "images":["https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/screens%2Fasus%2FVG248%2F1.jpg?alt=media&token=8ebbea60-6cbb-461f-bcd8-2da634d8c408",
      "https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/screens%2Fasus%2FVG248%2F2.jpg?alt=media&token=6933d25f-1a93-46ea-a359-55f8aa3b6579",
      "https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/screens%2Fasus%2FVG248%2F3.jpg?alt=media&token=b8134155-727f-4f48-a979-90b6fdab8e41",
      "https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/screens%2Fasus%2FVG248%2F4.jpg?alt=media&token=6e5df36c-06d7-41b4-ae75-bb96a99e87f3",
     ],
    "model":"VG248QG",
    "price":700,
    "size":'24"',
  },
  {
    "brand" :"Asus",
    "catId":1,
    "dis":"""ASUS VG278QR 27inch FHD 165Hz Gaming Monitor
27 inch Full HD gaming monitor with an ultra-fast 165Hz refresh rate and Adaptive-Sync technology to eliminate screen tearing and choppy frame rates
Certified as G-SYNC Compatible, FreeSync Premium technology delivering a seamless, tear-free gaming experience by enabling VRR (variable refresh rate) by default.
0.5ms* response time for smooth gameplay, and ASUS Extreme Low Motion Blur (ELMB) Technology to further reduce ghosting and motion blur
GameFast Input Technology minimizes input lag and provides much faster motion delivery from end devices to monitor
ASUS-exclusive GamePlus hotkey for in-game enhancements while GameVisual for optimized visuals
Supports both Adaptive-Sync with NVIDIA GeForce* graphics cards and FreeSync with AMD Radeon graphics cards *Compatible with NVIDIA GeForce GTX 10 series, GTX 16 series, RTX 20 series and newer graphics cards""",
    "ex":true,
    "id":6,
    "image":"https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/screens%2Fasus%2FVG278%2F1.png?alt=media&token=cb1db8dc-ba4a-4848-a3ad-636995b94a91",
    "images":["https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/screens%2Fasus%2FVG278%2F1.png?alt=media&token=cb1db8dc-ba4a-4848-a3ad-636995b94a91",
      "https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/screens%2Fasus%2FVG278%2F2.png?alt=media&token=9f5a8436-3637-45d3-9bf8-698d256bcdad",
      "https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/screens%2Fasus%2FVG278%2F3.png?alt=media&token=c941dddf-dc5d-427f-a33f-5f9d744217a1",
      "https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/screens%2Fasus%2FVG278%2F4.png?alt=media&token=4eeb108e-5f77-4327-802c-5aa0047ed293",
      "https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/screens%2Fasus%2FVG278%2F5.png?alt=media&token=4257bf12-3701-48df-b3a3-ef399c80cbc6",
    ],
    "model":"VG278QR",
    "price":1150,
    "size":'27"',
  },
  {
    "brand" :"Asus",
    "catId":1,
    "dis":"""ASUS ROG Strix XG258Q 24.5” Gaming Monitor Full HD 1080P 240Hz 1ms Eye Care G-Sync Compatible Adaptive Sync Exports with DP Dual HDMI
Brand	ASUS
Screen Size	24 Inches
Resolution	FHD 1080p
Aspect Ratio	16:9
Screen Surface Description	Glossy""",
    "ex":true,
    "id":7,
    "image":"https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/screens%2Fasus%2FXG258%2F1.png?alt=media&token=9e6e93f6-1ad4-4b04-9c43-e31b5c41451b",
    "images":["https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/screens%2Fasus%2FXG258%2F1.png?alt=media&token=9e6e93f6-1ad4-4b04-9c43-e31b5c41451b",
      "https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/screens%2Fasus%2FXG258%2F2.png?alt=media&token=a82c0bc6-2b96-4137-a461-fad37ba51345",
      "https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/screens%2Fasus%2FXG258%2F3.png?alt=media&token=aeab8587-3669-429a-9a67-571a9ab032c1",
      "https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/screens%2Fasus%2FXG258%2F4.png?alt=media&token=293e0bb1-7adc-4e71-b06f-c5fa4b612c46",
      "https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/screens%2Fasus%2FXG258%2F5.png?alt=media&token=2e06960e-c342-4e25-bb17-45ad3982303f",
    ],
    "model":"XG258Q",
    "price":200,
    "size":'24.5"',
  },
  {
    "brand" :"Asus",
    "catId":1,
    "dis":"""ASUS ROG Strix XG258Q 24.5” Gaming Monitor Full HD 1080P 240Hz 1ms Eye Care G-Sync Compatible Adaptive Sync Exports with DP Dual HDMI
Brand	ASUS
Screen Size	24 Inches
Resolution	FHD 1080p
Aspect Ratio	16:9
Screen Surface Description	Glossy""",
    "ex":true,
    "id":7,
    "image":"https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/screens%2Fasus%2FXG258%2F1.png?alt=media&token=9e6e93f6-1ad4-4b04-9c43-e31b5c41451b",
    "images":["https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/screens%2Fasus%2FXG258%2F1.png?alt=media&token=9e6e93f6-1ad4-4b04-9c43-e31b5c41451b",
      "https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/screens%2Fasus%2FXG258%2F2.png?alt=media&token=a82c0bc6-2b96-4137-a461-fad37ba51345",
      "https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/screens%2Fasus%2FXG258%2F3.png?alt=media&token=aeab8587-3669-429a-9a67-571a9ab032c1",
      "https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/screens%2Fasus%2FXG258%2F4.png?alt=media&token=293e0bb1-7adc-4e71-b06f-c5fa4b612c46",
      "https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/screens%2Fasus%2FXG258%2F5.png?alt=media&token=2e06960e-c342-4e25-bb17-45ad3982303f",
    ],
    "model":"XG258Q",
    "price":200,
    "size":'24.5"',
  },
  {
    "brand" :"BenQ",
    "catId":1,
    "dis":"""BenQ EX2780Q 27 Inch 2K QHD 2560x1440 | 144Hz Gaming Monitor | FreeSync Premium | IPS | USB Type-C, HDMI, DP | DCI-P3 | Built-in Speakers | Remote Control | Anti-glare, Flicker-free, Bezel-less
Brand	BenQ
Screen size	27 Inches
Resolution	QHD Wide 1440p
Aspect ratio	16:9
Screen surface description	Glossy""",
    "ex":true,
    "id":8,
    "image":"https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/screens%2Fbenq%2FEX2780Q%2F2.jpg?alt=media&token=61c96497-e34d-4601-a80f-0fe7b84300b7",
    "images":["https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/screens%2Fbenq%2FEX2780Q%2F2.jpg?alt=media&token=61c96497-e34d-4601-a80f-0fe7b84300b7",
      "https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/screens%2Fbenq%2FEX2780Q%2F1.jpg?alt=media&token=1e58bf86-f9bd-4e5f-b50f-41363c8609ac",
      "https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/screens%2Fbenq%2FEX2780Q%2F3.jpg?alt=media&token=29b1faee-5799-42e4-b1bd-eb0e7177a0c6",
      "https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/screens%2Fbenq%2FEX2780Q%2F4.jpg?alt=media&token=0df0a42a-b95a-4957-9982-0d04184e12b0",
      "https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/screens%2Fbenq%2FEX2780Q%2F6.jpg?alt=media&token=d628fd76-610c-4bff-962f-97576c2b79fe",
    ],
    "model":"EX2780Q",
    "price":1750,
    "size":'27"',
  },
  {
    "brand" :"BenQ",
    "catId":1,
    "dis":"""BenQ LED 31.5 Inch Curved Monitor - EX3200R
   Brand : BenQ
  Screen Size : 32 Inch
  Monitor Type : LED
  Model Number : EX3200R""",
    "ex":true,
    "id":9,
    "image":"https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/screens%2Fbenq%2FEX3200R%2F1.jpg?alt=media&token=609eed41-89a2-4b55-b755-51962a3cef75",
    "images":["https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/screens%2Fbenq%2FEX3200R%2F1.jpg?alt=media&token=609eed41-89a2-4b55-b755-51962a3cef75",
      "https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/screens%2Fbenq%2FEX3200R%2F2.jpg?alt=media&token=8d38593b-c353-4476-b273-08374a78d171",
      "https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/screens%2Fbenq%2FEX3200R%2F3.jpg?alt=media&token=3c72f722-3617-434e-abac-09b9f34c528d",
      "https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/screens%2Fbenq%2FEX3200R%2F4.jpg?alt=media&token=d0c119ca-bcb4-4e79-8f9d-438fc6f684ad",
    ],
    "model":"EX3200R",
    "price":1750,
    "size":'31.5"',
  },
  {
    "brand" :"BenQ",
    "catId":1,
    "dis":"""BenQ GW2480 24 Inch FHD 1080p Eye-Care LED Monitor, 1920x1080 Display, IPS Panel, 1Wx2 Speakers, Brightness Intelligence, Low Blue Light, Flicker-free, Ultra Slim Bezel, Cable Management System, HDMI
24 inch Full HD 1080P IPS panel: 23. 8” Full HD IPS widescreen with 1920x1080 resolution, 250 nits of brightness, built-in speakers
Wide viewing angle: 178° wide viewing angle for Clarity from any viewing angle
Edge to edge slim bezel design: ultra-slim bezel for virtually seamless multi-panel configurations for extended view, space-saving base, elegant design for home office
Patented Eye-Care for extended use: Proprietary brightness Intelligence Adaptive technology adjusts brightness for comfortable viewing, low Blue light and zeroflicker technology prevent headaches and eye strain. This eye Tech delivers optimized images that are easy on your eyes.
Integrated cable management system: neatly hides cables inside monitor stand; VESA wall mount: 100x100 (mm)
Connectivity Technology: vga. Voltage Rating - 100 - 240V, Response Time - 8ms, 5ms(GtG), Refresh Rate - 60Hz""",
    "ex":true,
    "id":10,
    "image":"https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/screens%2Fbenq%2FQW2480%2F1.jpg?alt=media&token=170fbde5-93eb-4cef-88bc-ce91125705c9",
    "images":["https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/screens%2Fbenq%2FQW2480%2F1.jpg?alt=media&token=170fbde5-93eb-4cef-88bc-ce91125705c9",
      "https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/screens%2Fbenq%2FQW2480%2F2.jpg?alt=media&token=1d4468b5-683c-4914-aa52-8df78468be01",
      "https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/screens%2Fbenq%2FQW2480%2F3.jpg?alt=media&token=3728a74b-a0a0-4ea0-8af7-5cbb355bc6cf",
      "https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/screens%2Fbenq%2FQW2480%2F4.jpg?alt=media&token=91ade24e-24f8-4022-8a20-4e38c5f88e47",
    ],
    "model":"GW2480",
    "price":350,
    "size":'24"',
  },
  {
    "brand" :"BenQ",
    "catId":1,
    "dis":"""BenQ ZOWIE RL2455S 24 inch 1080p Gaming Monitor | 1ms 75Hz | Black Equalizer & Color Vibrance for Competitive Edge
24" 1920 x 1080 (1080p) Full HD Display supporting up to 75 Hz (configure through GPU settings).
1ms Response Time (GTG) to eliminate ghosting and lag, providing you the optimal console gaming experience.
Exclusive Color Vibrance and Black eQualizer technology to enhance color representation and visual clarity, giving you the advantage on the battlefield.
Optimized display presets for RTS, FPS, and Fighting Game modes, along with Smart Scaling/Display Mode to create custom screen sizes, giving users a complete customized viewing experience.
Flicker free technology with a special bezel frame to minimize visual distractions and reduce eye strain, increasing your comfort for intensive gaming sessions.
Compatible with Console and PC platforms with a compact slip-resistant base that provides ideal space for controller storage paired with full tilt adjustment. Tilt (°)‎: -5~15 , Dual HDMI ports, VESA compatibility, and built-in speakers.
Manufacturer Limited Warranty: 3 Years""",
    "ex":true,
    "id":11,
    "image":"https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/screens%2Fbenq%2FRL2455s%2F1.jpg?alt=media&token=e4bad9cd-9d60-4b29-bd9e-c498df839f6a",
    "images":["https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/screens%2Fbenq%2FRL2455s%2F1.jpg?alt=media&token=e4bad9cd-9d60-4b29-bd9e-c498df839f6a",
      "https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/screens%2Fbenq%2FRL2455s%2F2.jpg?alt=media&token=e8e7fccc-58de-409d-8a72-99c124c9e3c2",
      "https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/screens%2Fbenq%2FRL2455s%2F3.jpg?alt=media&token=e81459ce-1489-47f1-b7d8-289ef321262c",
      "https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/screens%2Fbenq%2FRL2455s%2F4.jpg?alt=media&token=c05a9aed-1b79-406a-bfb6-4bfd873f25e7",
      "https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/screens%2Fbenq%2FRL2455s%2F5.jpg?alt=media&token=733e14a9-6998-40a7-9f3d-e37a1105e76f",
      "https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/screens%2Fbenq%2FRL2455s%2F6.jpg?alt=media&token=82645475-24be-41ca-81d2-34dcc0e4cf9c",
    ],
    "model":"RL2455S",
    "price":330,
    "size":'24"',
  },
  {
    "brand" :"BenQ",
    "catId":1,
    "dis":"""BenQ ZOWIE RL2755 27 inch 1080p Gaming Monitor | 1ms 75Hz | Black Equalizer & Color Vibrance for Competitive Edge
27" 1920 x 1080 (1080p) Full HD Display
1ms Response Time (GTG) to eliminate ghosting and lag, providing you the optimal console gaming experience.
Exclusive Color Vibrance and Black eQualizer technology to enhance color representation and visual clarity, giving you the advantage on the battlefield.
Optimized display presets for RTS, FPS, and Fighting Game modes, along with Smart Scaling/Display Mode to create custom screen sizes, giving users a complete customized viewing experience.
Flicker free technology with a special bezel frame to minimize visual distractions and reduce eye strain, increasing your comfort for intensive gaming sessions.
Compatible with Console and PC platforms with a compact slip-resistant base that provides ideal space for controller storage paired with full tilt adjustment, Dual HDMI ports, VESA compatibility, and built-in speakers.
Manufacturer Limited Warranty: 3 Years""",
    "ex":true,
    "id":12,
    "image":"https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/screens%2Fbenq%2FRL2755%2F1.jpg?alt=media&token=65a0bea0-ae65-48c6-8b72-595f564c47e2",
    "images":["https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/screens%2Fbenq%2FRL2755%2F1.jpg?alt=media&token=65a0bea0-ae65-48c6-8b72-595f564c47e2",
      "https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/screens%2Fbenq%2FRL2755%2F2.jpg?alt=media&token=e23d125d-e79c-4547-86e2-e33c4b9a4dfe",
      "https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/screens%2Fbenq%2FRL2755%2F3.jpg?alt=media&token=0f00cd4a-091b-4898-bc55-651b06d02039",
      "https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/screens%2Fbenq%2FRL2755%2F4.jpg?alt=media&token=c982a026-d982-4ccf-8aac-5016f2813d73",
      "https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/screens%2Fbenq%2FRL2755%2F5.jpg?alt=media&token=36f04cd9-5c6b-497b-b374-67ae1ca6c886",
      "https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/screens%2Fbenq%2FRL2755%2F6.jpg?alt=media&token=50bac092-7e77-4d69-88b6-5e6ed728bc2d",
    ],
    "model":"RL2755",
    "price":360,
    "size":'27"',
  },
  {
    "brand" :"BenQ",
    "catId":1,
    "dis":"""BenQ ZOWIE XL2731 27 inch 144Hz Esports Gaming Monitor |1ms| FHD (1080P) | Height Adjustable | FreeSync Premium |DP, HDMI| Black Equalizer & Color Vibrance | Xbox SeriesX & PS5 Ready @ 120fps
Brand	BenQ
Screen size	27 Inches
Resolution	FHD 1080p
Aspect ratio	16:9
Screen surface description	Glossy""",
    "ex":true,
    "id":13,
    "image":"https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/screens%2Fbenq%2FXL2731%2F1.jpg?alt=media&token=dd3f4c3c-46d2-4a5e-9bb0-61e189dd2ff6",
    "images":["https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/screens%2Fbenq%2FXL2731%2F1.jpg?alt=media&token=dd3f4c3c-46d2-4a5e-9bb0-61e189dd2ff6",
      "https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/screens%2Fbenq%2FXL2731%2F2.jpg?alt=media&token=ca00257b-390e-4f60-8bc4-3ee07bfaafec",
      "https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/screens%2Fbenq%2FXL2731%2F3.jpg?alt=media&token=561c199e-920e-4d13-92d5-a6e365e379b4",
     ],
    "model":"XL2731",
    "price":750,
    "size":'27"',
  },
  {
    "brand" :"BenQ",
    "catId":1,
    "dis":"""Benq BQ-XL2740 27 inch TN LCD Full HD Gaming Monitor With 240Hz, Nvidia G-Sync and DisplayPort HDMI Black
Looking for a high-performance gaming monitor with an ideal price? We offer you the professional gaming monitor from Benq with high-definition graphics and perfect color contrast to achieve the best possible performance experience.
Features:
27-inch suitable size
High-definition graphics 1080 × 1920 pixels
Response time up to 1 millisecond
Possibility to control the screen tilt and axis as desired
Supports Nvidia G-Sync technology
High refresh rate of 240Hz for better and smoother performance
Equipped with USB and HDMI ports
Possibility to adjust brightness, contrast, and screen dimensions settings
Specifications:
Color: Black""",
    "ex":true,
    "id":14,
    "image":"https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/screens%2Fbenq%2FXL2740%2F1.jpg?alt=media&token=e966d7cd-35a4-468d-890b-544961a06823",
    "images":["https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/screens%2Fbenq%2FXL2740%2F1.jpg?alt=media&token=e966d7cd-35a4-468d-890b-544961a06823",
      "https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/screens%2Fbenq%2FXL2740%2F2.jpg?alt=media&token=08ca304f-fa5b-4510-9c0f-fd576779e53a",
      "https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/screens%2Fbenq%2FXL2740%2F3.jpg?alt=media&token=97653ccd-83d5-4d0d-acbb-932278900f60",
      "https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/screens%2Fbenq%2FXL2740%2F4.jpg?alt=media&token=d349bded-7e85-43b7-b8ae-cd85b569f0e3",
    ],
    "model":"XL2740",
    "price":2000,
    "size":'27"',
  },
  {
    "brand" :"BenQ",
    "catId":1,
    "dis":"""BenQ XR3501 35" Ultra Wide LED Backlit Gaming Monitor
Weight: 11.1kg
Dimensions: 853 x 499 x 206 mm
Image Resolution: 2560 x 1080
Warranty: One Year Manufacturer""",
    "ex":true,
    "id":15,
    "image":"https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/screens%2Fbenq%2FXR3501%2F1.jpg?alt=media&token=01d588b7-201f-4053-9fee-d278c4e124cc",
    "images":["https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/screens%2Fbenq%2FXR3501%2F1.jpg?alt=media&token=01d588b7-201f-4053-9fee-d278c4e124cc",
      "https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/screens%2Fbenq%2FXR3501%2F2.jpg?alt=media&token=48437ac1-7493-4756-93e8-d5b46302d575",
      "https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/screens%2Fbenq%2FXR3501%2F3.jpg?alt=media&token=8a372e35-e298-4266-b9bd-a23548181d9a",
     ],
    "model":"XR3501",
    "price":2415,
    "size":'35"',
  },
  {
    "brand" :"Dell",
    "catId":1,
    "dis":"""Dell UltraSharp 27 USB-C Hub Monitor, 27" 4K UHD IPS Display, 60Hz Refresh Rate, 5ms Response Time, Arsenic free, 1.07B Color Display, HDMI, 2x DisplayPort, 3x USB-C, 5x USB 3.2 Gen2, Black | U2723QE""",
    "ex":true,
    "id":16,
    "image":"https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/screens%2FDell%2FUltraSharp%2027IN%2F1.jpg?alt=media&token=23d28292-9a9b-4f83-8d2c-7b4cd2d33659",
    "images":["https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/screens%2FDell%2FUltraSharp%2027IN%2F1.jpg?alt=media&token=23d28292-9a9b-4f83-8d2c-7b4cd2d33659",
      "https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/screens%2FDell%2FUltraSharp%2027IN%2F2.jpg?alt=media&token=17a14308-5088-4e82-8b2f-eefd30d08ef2",
      "https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/screens%2FDell%2FUltraSharp%2027IN%2F3.jpg?alt=media&token=5fc6b7ef-63ac-4d9b-a87e-8ba9f9024e02",
      "https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/screens%2FDell%2FUltraSharp%2027IN%2F4.jpg?alt=media&token=44b3ef06-d812-425c-8ec9-e9f7bcc2bc2d",
      "https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/screens%2FDell%2FUltraSharp%2027IN%2F5.jpg?alt=media&token=efb0eee3-4328-4b32-ae62-ce90e831938c",
    ],
    "model":"U2723QE",
    "price":2150,
    "size":'27"',
  },
  {
    "brand" :"LG",
    "catId":1,
    "dis":"""LG 22MK400H-B 22-inch 16:9 FreeSync LCD Monitor | 22MK400H
Twisted Nematic (TN) Panel
HDMI | VGA Inputs
1920 x 1080 Full HD Resolution
1000:1 Static Contrast Ratio
200 cd/m² Brightness
180°/130° Viewing Angles
1 ms Response Time (GtG)
16.7 Million Colors
75 Hz Refresh Rate""",
    "ex":true,
    "id":17,
    "image":"https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/screens%2FLG%2F22MK400%2F1.jpg?alt=media&token=87d3a916-8b7a-472c-9197-7ccdba37abd4",
    "images":["https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/screens%2FLG%2F22MK400%2F1.jpg?alt=media&token=87d3a916-8b7a-472c-9197-7ccdba37abd4",
      "https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/screens%2FLG%2F22MK400%2F2.jpg?alt=media&token=1f28490f-3127-4c32-92ea-fdba2e4ace3e",
      "https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/screens%2FLG%2F22MK400%2F3.jpg?alt=media&token=ae845210-6ffe-43a6-bda3-e8b0fd2fd014",
      "https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/screens%2FLG%2F22MK400%2F4.jpg?alt=media&token=18ed682e-2d06-41cf-bd3e-1a5403b9cc94",
    ],
    "model":"22MK400H",
    "price":340,
    "size":'22"',
  },
  {
    "brand" :"MSI",
    "catId":1,
    "dis":"""MSI Optix AG32C 32" Curved Gaming Monitor
PANEL SIZE: 31.5" LCD panel LED Backlight
ASPECT RATIO: 16:9
PANEL RESOLUTION: 1920 x 1080
PIXEL PITCH (H X V): 0.36375(H)X0.36375(V)
REFRESH RATE: 165Hz
RESPONSE TIME: 1ms (MPRT), 4ms (GTG)
NTSC / SRGB: 85% / 110%
VIEWING ANGLE: 178°(H) x 178°(V)
CURVED: Yes
POWER CONSUMPTION: 48W Standby < 0.5W, Off < 0.5W
I/O: 1 x HDMI 2.0, 1 x DP 1.2, 1 x DVI
CONTROL: Menu, Bri (-), Vol(+) Input/Enter, Power, MSI Standard OSD format, WARM,COOL,User Mode, PC, Movie, Game, ECO Modes
DISPLAY COLORS: 16.7M
VIDEO PORTS: 1x DP(1.2), 1x HDMI(2.0), 1x DVI
VESA MOUNTING: 100 mm x 100 mm
POWER TYPE: External Adaptor 12V 5A
POWER INPUT: 100~240V, 50~60Hz
SIGNAL FREQUENCY: 56 to 214.56KHz, 48 to 165Hz
ADJUSTMENT (TILT): -5° ~ -15°
NOTE: Display Port: 1920 x 1080 (Up to 165Hz), HDMI: 1920 x 1080 (Up to 165Hz), The color gamut follows the CIE 1976 testing standard.
PANEL TYPE: VA""",
    "ex":true,
    "id":18,
    "image":"https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/screens%2FMSI%2FAG32c%2F1.jpg?alt=media&token=5fd4b3fb-3c1d-4a97-b612-9f346be118a9",
    "images":["https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/screens%2FMSI%2FAG32c%2F1.jpg?alt=media&token=5fd4b3fb-3c1d-4a97-b612-9f346be118a9",
      "https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/screens%2FMSI%2FAG32c%2F2.jpg?alt=media&token=fd078aa3-6da6-46cb-ade1-4b5b9bb8dbe5",
      "https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/screens%2FMSI%2FAG32c%2F3.jpg?alt=media&token=560de50a-be0b-4175-bb0d-e285ae1f9c5e",
      "https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/screens%2FMSI%2FAG32c%2F4.jpg?alt=media&token=b868e26d-12b8-492a-826c-b518df32d569",
      "https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/screens%2FMSI%2FAG32c%2F5.jpg?alt=media&token=7fa5a122-63c4-4243-b3fe-0b438dd9fe4c",
    ],
    "model":"AG32C",
    "price":2580,
    "size":'31.5"',
  },
  {
    "brand" :"MSI",
    "catId":1,
    "dis":"""MSI Optix MAG321CQR 32" Curved Gaming Monitor
DCI-P3 / SRGB: 92% / Up to 122%
PANEL SIZE: 31.5"
ASPECT RATIO: ASPECT RATIO
PANEL RESOLUTION: 2560 x 1440
PIXEL PITCH (H X V): 0.2724(H) x 0.2724(V)
VIEWING ANGLE: 178°
CURVED: 1800R
CONTROL: 5-way OSD navigation joystick
DCR: 100000000:1
ACTIVE DISPLAY AREA (MM): 697.344(H) x 393.696 (V)
SURFACE TREATMENT: Anti-glare
DISPLAY COLORS: 16.7M
VIDEO PORTS: 1x DP 1.4, 2x HDMI 2.0
USB PORTS: 2 x USB 2.0, 1 x USB 2.0 Type B (PC to Monitor)
AUDIO PORTS: 1 x Earphone out
POWER TYPE: External Adaptor 12V 5A
POWER INPUT: 100~240V, 50~60Hz
NOTE: Display Port: 2560 x 1440 (Up to 144Hz), HDMI: 2560 x 1440 (Up to 144Hz), The color gamut follows the CIE 1976 testing standard.
PANEL TYPE: VA""",
    "ex":true,
    "id":19,
    "image":"https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/screens%2FMSI%2FMAG321CQR%2F1.jpg?alt=media&token=1e777fcd-a4c5-4487-8566-0289539a3aac",
    "images":["https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/screens%2FMSI%2FMAG321CQR%2F1.jpg?alt=media&token=1e777fcd-a4c5-4487-8566-0289539a3aac",
      "https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/screens%2FMSI%2FMAG321CQR%2F2.jpg?alt=media&token=74150447-a1ff-41cb-abaf-281d4f1d36e8",
      "https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/screens%2FMSI%2FMAG321CQR%2F3.jpg?alt=media&token=e0c8b239-4ebf-4f34-9336-f9facff7ef80",
      "https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/screens%2FMSI%2FMAG321CQR%2F4.jpg?alt=media&token=548fc59b-78f6-4a2f-a9b8-5eea79924eff",
      "https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/screens%2FMSI%2FMAG321CQR%2F5.jpg?alt=media&token=cfe50c04-b73c-4f13-bd42-65b2d536e5ad",
    ],
    "model":"MAG321CQR",
    "price":3260,
    "size":'31.5"',
  },
  {
    "brand" :"Philips",
    "catId":1,
    "dis":"""Philips 221V8/94 21.5"(54cm) Smart Image LED Monitor, TN Panel, Borderless with VGA & HDMI Port, FHD, 4 ms Response Time, 178x178 Viewing Angle, 75Hz Refresh Rate, Flicker Free, VESA Mount
Brand	PHILIPS
Screen size	21.5 Inches
Resolution	102 PPI
Aspect ratio	16:9
Screen surface description	Flat
About this item
21.5"Philips Monitor
Wide View Monitor
VA Pane""",
    "ex":true,
    "id":20,
    "image":"https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/screens%2FPhilips%2FLCD%20V-Line%2021.5%2F1.jpg?alt=media&token=f1ada2ec-20e2-4fcc-9569-b1128cb389d6",
    "images":["https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/screens%2FPhilips%2FLCD%20V-Line%2021.5%2F1.jpg?alt=media&token=f1ada2ec-20e2-4fcc-9569-b1128cb389d6",
      "https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/screens%2FPhilips%2FLCD%20V-Line%2021.5%2F2.jpg?alt=media&token=0e6fe698-157d-4cf4-9721-3e5d69846d8d",
      "https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/screens%2FPhilips%2FLCD%20V-Line%2021.5%2F3.jpg?alt=media&token=c50a3531-1654-43a1-9c60-0d74ca9b2744",
     ],
    "model":"221V8/94",
    "price":219,
    "size":'21.5"',
  },
  {
    "brand" :"Samsung",
    "catId":1,
    "dis":"""32" WQHD Gaming Curved Monitor CJG5 with 144 Hz Refresh Rate
Easy on the eyes with 1000R curved screen
Minimalist design with the borderless display, fabric-textured backside and slim metal stand
Realistic immersion with the renowned 1000R curve and game-related features""",
    "ex":true,
    "id":21,
    "image":"https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/screens%2FSamsung%2FCJG5%2F1.png?alt=media&token=ba58541c-08eb-46c1-a500-f531b516e0c7",
    "images":["https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/screens%2FSamsung%2FCJG5%2F1.png?alt=media&token=ba58541c-08eb-46c1-a500-f531b516e0c7",
      "https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/screens%2FSamsung%2FCJG5%2F2.png?alt=media&token=2f50f52d-a871-4c38-a0dd-28a62753596d",
      "https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/screens%2FSamsung%2FCJG5%2F3.png?alt=media&token=e4af17ab-2902-4e05-9d7f-d365fb7ff0fd",
    ],
    "model":"CJG5",
    "price":700,
    "size":'32"',
  },
  {
    "brand" :"Samsung",
    "catId":1,
    "dis":"""Resolution: 1920x1080 (Full HD)
Panel Type: PLS
Aspect Ratio: 16:9
Viewing Angle: 178° (Horizontal/Vertical)
Design: Super slim, less than 10mm at its thinnest point
Color Support: 16.7 million colors
Additional Features:
AMD FreeSync for smooth gameplay
Eco Saving Mode
Simple and sleek design with a circular stand""",
    "ex":true,
    "id":22,
    "image":"https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/screens%2FSamsung%2FSF350%2F1.png?alt=media&token=ef97f613-6933-41c4-a139-8ccbc5cdbf88",
    "images":["https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/screens%2FSamsung%2FSF350%2F1.png?alt=media&token=ef97f613-6933-41c4-a139-8ccbc5cdbf88",
      "https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/screens%2FSamsung%2FSF350%2F2.png?alt=media&token=64779e88-026e-4212-9a66-16fd49fa844f",
      "https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/screens%2FSamsung%2FSF350%2F3.png?alt=media&token=4c027702-f49f-4e18-8f2b-8609f4af3d76",
      "https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/screens%2FSamsung%2FSF350%2F4.png?alt=media&token=bd4eb6fb-0100-4a3f-84bd-b8f05e9753c7",
    ],
    "model":"SF350",
    "price":365,
    "size":'21.5"',
  },
  {
    "brand" :"AIR Grill",
    "catId":4,
    "dis":"""Name : Air grill
Model: AG601WS
*6L ,220-240V, 50/60Hz, 1500W
*Upper Heating element
*Metal housing with painting color (Black)
*Functions: Air fry,air grill,Bake, Broil,Roast,Manual.
*LED display for working time and temperature
*max temperature: 260C
*60 minutes timer
*6 buttons""",
    "ex":true,
    "id":23,
    "image":"https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/Air%20grill%2FAG601WS%2F1.png?alt=media&token=06db0109-6847-4bee-b013-e5a8cab2d056",
    "images":["https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/Air%20grill%2FAG601WS%2F1.png?alt=media&token=06db0109-6847-4bee-b013-e5a8cab2d056",
      "https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/Air%20grill%2FAG601WS%2F2.png?alt=media&token=09e404ed-61a1-4470-bd4d-ef72ba5b791d",
      "https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/Air%20grill%2FAG601WS%2F3.png?alt=media&token=0fbf4957-e15b-40ec-8510-3fd09c22a5c8",
      "https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/Air%20grill%2FAG601WS%2F4.png?alt=media&token=3091e593-55c0-4f45-b274-cecc5f7f9329",
    ],
    "model":"AG601WS",
    "price":250,
    "size":'6L',
  },
  {
    "brand" :"AIR Grill",
    "catId":4,
    "dis":"""Name : Air grill
Model: AG708WS
*220V-240V 50-60Hz 1600W
*7QT capacity (Upper heating element only)
*Painting body / black and stainless steel
*Stainless steel handle
*Functions: bake, broil, roast, air fry, air grill, air bomb, preheat manual,dehy
*air frying techology
*plastic with stainless steel wrap housing
*LED display for working time and temperature
*knob control for functions slection and start/cancel
*temp range: 50-260C
*120 minutes timer""",
    "ex":true,
    "id":24,
    "image":"https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/Air%20grill%2FAG708WS%2F1.jfif?alt=media&token=a28d9d20-dbd8-4c76-9127-bd8645f6f255",
    "images":["https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/Air%20grill%2FAG708WS%2F1.jfif?alt=media&token=a28d9d20-dbd8-4c76-9127-bd8645f6f255",
      "https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/Air%20grill%2FAG708WS%2F2.jfif?alt=media&token=35f6c2d5-1ead-4312-a1fd-c20dc4584060",
      "https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/Air%20grill%2FAG708WS%2F3.jfif?alt=media&token=818a6f09-7060-4109-818e-b48407d60971",
      "https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/Air%20grill%2FAG708WS%2F4.jfif?alt=media&token=19d4510c-0974-4394-9635-58c86aacba99",
      "https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/Air%20grill%2FAG708WS%2F5.png?alt=media&token=e4554d0c-204d-4c8a-a232-51c37d63bba9",
    ],
    "model":"AG708WS",
    "price":295,
    "size":'7L',
  },
  {
    "brand" :"Breville",
    "catId":2,
    "dis":"""Breville Barista Express Espresso Machine, Brushed Stainless Steel, Silver, BES870"Min 1 year manufacturer warranty"
Fresh beans to an espresso in under a minute
250gm On board grinder makes up to 25 cups
1600W faster heat up
2 Litre water tank with filter
18 Adjustable grind settings and dosage control""",
    "ex":true,
    "id":25,
    "image":"https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/Espresso%20Coffee%2FBreville%20the%20Barista%20Ex%2F1.jpg?alt=media&token=9c19901e-e264-49a4-8db0-5ab31ff07a40",
    "images":["https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/Espresso%20Coffee%2FBreville%20the%20Barista%20Ex%2F1.jpg?alt=media&token=9c19901e-e264-49a4-8db0-5ab31ff07a40",
      "https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/Espresso%20Coffee%2FBreville%20the%20Barista%20Ex%2F2.jpg?alt=media&token=32449651-689c-4c2d-a240-f9e65ffd2768",
      "https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/Espresso%20Coffee%2FBreville%20the%20Barista%20Ex%2F3.jpg?alt=media&token=783d650a-1788-4ba9-a937-010f05c0aeb5",
      "https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/Espresso%20Coffee%2FBreville%20the%20Barista%20Ex%2F4.jpg?alt=media&token=bf9d86e2-25d3-40fe-805d-f1ea68dc8ed2",
      "https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/Espresso%20Coffee%2FBreville%20the%20Barista%20Ex%2F5.jpg?alt=media&token=6f0b40d8-73f2-4c33-8d68-bd13b7669783",
    ],
    "model":"BES870",
    "price":2150,
    "size":'250gm/25cups',
  },
  {
    "brand" :"DeLonghi",
    "catId":2,
    "dis":"""De'Longhi Dedica Pump Espresso Manual Coffee Machine | Cappuccino, Latte Macchiato With Milk Frother | Therm Block Heating System For Accurate Temperature | Easy To Clean | EC685.R
Brand	De'Longhi
Capacity	1 Liters
Colour	Red
Product dimensions	5.8D x 13W x 12H centimeters
Special features	Manual, Programmable""",
    "ex":true,
    "id":26,
    "image":"https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/Espresso%20Coffee%2FDelonghi%20Dedica%2F1.jpg?alt=media&token=665ceb3e-d471-4c66-ae4c-c9cd6a5fa8bc",
    "images":["https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/Espresso%20Coffee%2FDelonghi%20Dedica%2F1.jpg?alt=media&token=665ceb3e-d471-4c66-ae4c-c9cd6a5fa8bc",
      "https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/Espresso%20Coffee%2FDelonghi%20Dedica%2F2.jpg?alt=media&token=e0e3d055-006e-4b47-b672-91de190f1263",
      "https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/Espresso%20Coffee%2FDelonghi%20Dedica%2F3.jpg?alt=media&token=6552b7e3-220a-4256-ac5c-a2c955b4fe3d",
      "https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/Espresso%20Coffee%2FDelonghi%20Dedica%2F4.jpg?alt=media&token=4f40b5cb-608e-40b2-996f-7bc5448840fa",
      "https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/Espresso%20Coffee%2FDelonghi%20Dedica%2F5.jpg?alt=media&token=75069ee5-8860-4243-a42b-6bf2bcb7dc7a",
      "https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/Espresso%20Coffee%2FDelonghi%20Dedica%2F6.jpg?alt=media&token=89bad92b-6b0c-4f80-983e-187e7c992423",
    ],
    "model":"EC685.R",
    "price":510,
    "size":'1L',
  },
  {
    "brand" :"DeLonghi",
    "catId":2,
    "dis":"""Espresso Maker 1.4 L 1100.0 W ECZ351.BG Beige/Silver/Black
Aesthetic metallic design.
Brews espresso, cappuccinos, and lattes.
Powerful 15-bar pressure pump.
Rapid heating with a thermoblock system.
Dual filter holder for ground coffee and ESE pods.
Milk frothing with a steam wand.
Cup warmer for hot coffee cups.
Easy-to-clean removable drip tray.
Large water reservoir and dosing spoon included.
Backed by the reliability of the DeLonghi brand.""",
    "ex":true,
    "id":27,
    "image":"https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/Espresso%20Coffee%2FDelonghi%20SculTura%2F1.jpg?alt=media&token=0af11342-5d32-4e74-a755-b691081d1ee2",
    "images":["https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/Espresso%20Coffee%2FDelonghi%20SculTura%2F1.jpg?alt=media&token=0af11342-5d32-4e74-a755-b691081d1ee2",
      "https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/Espresso%20Coffee%2FDelonghi%20SculTura%2F2.jpg?alt=media&token=6af85a05-36ee-42a8-8e7d-3e0ca17865b6",
      "https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/Espresso%20Coffee%2FDelonghi%20SculTura%2F3.jpg?alt=media&token=dfaffe9d-f920-430d-8852-05fffb45eff1",
      "https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/Espresso%20Coffee%2FDelonghi%20SculTura%2F4.jpg?alt=media&token=85c27b86-282d-46be-b5fa-0a0df3b37158",
      "https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/Espresso%20Coffee%2FDelonghi%20SculTura%2F5.jpg?alt=media&token=96708491-df2a-45c6-84c9-34b2fc4f9dea",
    ],
    "model":"ECZ351.BG",
    "price":950,
    "size":'1.4 L',
  },
  {
    "brand" :"Espresso Coffee Maker",
    "catId":2,
    "dis":"""Name : Espresso Coffee Maker
Model : CM5201AY / Heat-instant
220-240V , 50/60Hz , 1400 watts
Dark blue spray housing
15L high pressure pump / JIAYIN
1.2L detachable water tank
preset 1 and 2 cup
• With stainless steel decoration
• Aluminum alloy filter holder attached with dual
• stainless fitler to improve coffee quality
• Can use for ground coffee
• Can make coffee or steam conveniently
• Detachable frothing nozzle and drip tray for easy cleaning
• Safe and reliable, with overheating and over pressure protected device
• Durable stainless cup plate for coffee cups preheating
• With built in pressure gauge on front display""",
    "ex":true,
    "id":28,
    "image":"https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/Espresso%20Coffee%2FEspresso%20Coffee%20Maker%2FCM5201AY%20%20Heat-instant%2F1.png?alt=media&token=1cb08ca1-e38a-4353-b25b-b38922aa6b57",
    "images":["https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/Espresso%20Coffee%2FEspresso%20Coffee%20Maker%2FCM5201AY%20%20Heat-instant%2F1.png?alt=media&token=1cb08ca1-e38a-4353-b25b-b38922aa6b57",
      "https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/Espresso%20Coffee%2FEspresso%20Coffee%20Maker%2FCM5201AY%20%20Heat-instant%2F2.png?alt=media&token=77063d72-ee4f-494b-ad31-98a338fdb5b6",
      "https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/Espresso%20Coffee%2FEspresso%20Coffee%20Maker%2FCM5201AY%20%20Heat-instant%2F3.png?alt=media&token=4298b211-5268-4b13-9126-ab2fa026374b",
      "https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/Espresso%20Coffee%2FEspresso%20Coffee%20Maker%2FCM5201AY%20%20Heat-instant%2F4.png?alt=media&token=f7161e73-9510-481b-91e8-23c2b97a2a0b",
   ],
    "model":"CM5201AY",
    "price":350,
    "size":'1.2L',
  },
  {
    "brand" :"Espresso Coffee Maker",
    "catId":2,
    "dis":"""Name : Espresso Coffee Maker
Model : CM6101AY / Water Storage
220-240V , 50/60Hz , 1100 watts
Whole stainless steel housing
15L high pressure pump / JIAYIN
1.5L detachable water tank, preset 1 and 2 cup
• With stainless steel decoration and housing
• Aluminum alloy filter holder attached with dual
• stainless fitler to improve coffee quality
• Can use for ground coffee
• Can make coffee or steam conveniently
• Detachable frothing nozzle and drip tray for easy cleaning
• Safe and reliable, with overheating and over pressure protected device
• Durable stainless cup plate for coffee cups preheating
• With built in pressure gauge on front display""",
    "ex":true,
    "id":29,
    "image":"https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/Espresso%20Coffee%2FEspresso%20Coffee%20Maker%2FCM6101AY%20%20Water%20Storage%2F2.png?alt=media&token=61180ec5-bdbe-4162-8170-0347b6601987",
    "images":["https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/Espresso%20Coffee%2FEspresso%20Coffee%20Maker%2FCM6101AY%20%20Water%20Storage%2F2.png?alt=media&token=61180ec5-bdbe-4162-8170-0347b6601987",
      "https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/Espresso%20Coffee%2FEspresso%20Coffee%20Maker%2FCM6101AY%20%20Water%20Storage%2F3.png?alt=media&token=6c1da60f-1e4f-4949-835f-f62b30af623b",
      "https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/Espresso%20Coffee%2FEspresso%20Coffee%20Maker%2FCM6101AY%20%20Water%20Storage%2F4.png?alt=media&token=c5dd396b-9bfb-4e4d-b168-93e0dd20c05b",
      ],
    "model":"CM6101AY",
    "price":380,
    "size":'1.5L',
  },
  {
    "brand" :"Manual Espresso Coffee Machine",
    "catId":2,
    "dis":"""Name : Manual Portable Espresso Machine
Model: MC101 (2 in 1 function) , White body
Manual Operated from piston action with 10-15bar pressure
Tritan coffee collect cup
Water container: 80ml
Coffee bottle capacity : 120ml
2 in 1 capsule & Ground Coffee
Ergonomic design, compact & featherweight
Portable size: 9.4X2.8X2.8 inches.
Convenient for travel hiking and picnic""",
    "ex":true,
    "id":30,
    "image":"https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/Espresso%20Coffee%2FManual%20Portable%20Espresso%20Machine%2F1.jpg?alt=media&token=e5877777-038f-45fc-b4dd-4e5826c5abea",
    "images":["https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/Espresso%20Coffee%2FManual%20Portable%20Espresso%20Machine%2F2.jpg?alt=media&token=013f5ee3-4aac-4ccb-8386-4e916f5012dc",
      "https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/Espresso%20Coffee%2FManual%20Portable%20Espresso%20Machine%2F2.jpg?alt=media&token=013f5ee3-4aac-4ccb-8386-4e916f5012dc",
      "https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/Espresso%20Coffee%2FManual%20Portable%20Espresso%20Machine%2F3.jpg?alt=media&token=05c4d60a-d4b2-45dc-ab91-cfc9fb21f55e",
    ],
    "model":"MC101",
    "price":150,
    "size":'120ml',
  },
  {
    "brand" :"Melitta",
    "catId":2,
    "dis":"""Melitta Aromafresh Drip Filter Coffee Machine With Grinder & Glass Jug | Grind & Brew | 1 Year Warranty
Wake up with a cup of aroma-rich coffee made from freshly ground beans or pre-ground coffee, Transparent water tank with cup marker for 10 cups (150 ml)
Exceptional taste: optimal preparation temperature, Programmable warm-up time (30, 60 or 90 min), Adjustable coffee grind level and intensity, Borosilicate glass jug
Launch your coffee at the right time with the Timer function, Anti-drip system, Used with 1x4 filters, LCD screen with time display, Stainless steel elements
Preserve your coffeemaker and the taste of coffee: Descaling program, Descaling indicator, Water hardness adjustment, Dishwasher-safe and detachable filter holder, bean container and upper grind head, Automatic shut-off, 1000 W, 3 year warranty
Contents: 1 Melitta Aromafresh Grind and Brew filter coffee maker, Black/Stainless steel, 1021-01, 5 1x4 filters included, Cleaning brush included, Weight: 0,65 kg, Dimensions (LxWxH): 30.2 x 31.2 x 51.5 cm""",
    "ex":true,
    "id":31,
    "image":"https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/Espresso%20Coffee%2FMelitta%2F1.jpg?alt=media&token=ebab1347-eef4-4a79-aeb4-3412147f3f98",
    "images":["https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/Espresso%20Coffee%2FMelitta%2F1.jpg?alt=media&token=ebab1347-eef4-4a79-aeb4-3412147f3f98",
      "https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/Espresso%20Coffee%2FMelitta%2F2.jpg?alt=media&token=5c1b87d9-6b59-44f2-a045-dafc675ac82a",
      "https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/Espresso%20Coffee%2FMelitta%2F3.jpg?alt=media&token=b1ea831b-a204-419a-a44d-50242bb00697",
      "https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/Espresso%20Coffee%2FMelitta%2F4.jpg?alt=media&token=86c1b145-c903-4bb3-9868-14ff6c9a7b9e",
      "https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/Espresso%20Coffee%2FMelitta%2F5.jpg?alt=media&token=e78c02da-6831-4eea-bd27-73ebced5d122",
      "https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/Espresso%20Coffee%2FMelitta%2F6.jpg?alt=media&token=ac441019-232d-41d1-bfa8-42a16006e436",
    ],
    "model":"Aromafresh",
    "price":1100,
    "size":'10 cups (150 ml)',
  },
  {
    "brand" :"NESCAFÉ DOLCE GUSTO",
    "catId":2,
    "dis":"""Nescafe Dolce Gusto by De'Longhi - MINI ME Automatic Capsule Coffee Machine, Compact & Powerful up to 15 Bar Pressure, Cappuccino, Grande, Tea, Hot Chocolate & Espresso Coffee Maker, EDG305.WR, RED
Brand	NESCAFÉ DOLCE GUSTO
Capacity	0.8 Liters
Colour	Red
Product dimensions	6.3D x 9.5W x 12.2H centimeters
Special features	Programmable""",
    "ex":true,
    "id":32,
    "image":"https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/Espresso%20Coffee%2FNescafe%20Dolce%20Gusto%20by%20De'Longhi%20-%20MINI%20ME%2F1.jpg?alt=media&token=4a04be49-c2e1-4434-82fa-27d87ddf4373",
    "images":["https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/Espresso%20Coffee%2FNescafe%20Dolce%20Gusto%20by%20De'Longhi%20-%20MINI%20ME%2F1.jpg?alt=media&token=4a04be49-c2e1-4434-82fa-27d87ddf4373",
      "https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/Espresso%20Coffee%2FNescafe%20Dolce%20Gusto%20by%20De'Longhi%20-%20MINI%20ME%2F2.jpg?alt=media&token=a8677f44-f3e7-4c83-b637-bf23f05acd99",
      "https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/Espresso%20Coffee%2FNescafe%20Dolce%20Gusto%20by%20De'Longhi%20-%20MINI%20ME%2F3.jpg?alt=media&token=954002b3-9fe8-4b5d-a53b-2d0ae00e2fb8",
      "https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/Espresso%20Coffee%2FNescafe%20Dolce%20Gusto%20by%20De'Longhi%20-%20MINI%20ME%2F4.jpg?alt=media&token=5f5869e7-d810-47ef-9932-ecfe0b0e742a",
      "https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/Espresso%20Coffee%2FNescafe%20Dolce%20Gusto%20by%20De'Longhi%20-%20MINI%20ME%2F5.jpg?alt=media&token=8c261132-6604-4e8a-ba56-ed2af973227d",
     ],
    "model":"EDG305.WR",
    "price":350,
    "size":'0.8 Liters',
  },
  {
    "brand" :"Saachi",
    "catId":2,
    "dis":"""Saachi 150ml All-in-One Coffee Maker with 15-Bar Pressure Pump, 850W, NL-COF-7056, Black/Silver
Makes a variety of coffee beverages such as cappuccino, espresso, cafe latte, and more
Swivel steam jet lets you froth up milk for cappuccino and cafe latte
Heats up your beverages when required
Comes with a safety lock and scale, so your coffee doesn't spill
Resting cup plate equipped with additional warming function to keep your coffee warm
Auto shut-off is done every 10 minutes""",
    "ex":true,
    "id":33,
    "image":"https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/Espresso%20Coffee%2FSaachi%20NL-COF-7056%2F1.jpg?alt=media&token=b27ef487-05e2-484a-b928-aadd00f77c5d",
    "images":["https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/Espresso%20Coffee%2FSaachi%20NL-COF-7056%2F1.jpg?alt=media&token=b27ef487-05e2-484a-b928-aadd00f77c5d",
      "https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/Espresso%20Coffee%2FSaachi%20NL-COF-7056%2F2.jpg?alt=media&token=2fb4b715-d98f-4b73-9c52-c248076e83d1",
      "https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/Espresso%20Coffee%2FSaachi%20NL-COF-7056%2F3.jpg?alt=media&token=59c559e8-1981-4960-9110-17c1b3dde4a6",
   ],
    "model":"NL-COF-7056",
    "price":270,
    "size":'150ml',
  },
  {
    "brand" :"Stand Mixer",
    "catId":3,
    "dis":"""Name : Stand Mixer
Model : FM116 ,1000W-1200W, 50/60Hz, 8835 MOTOR
*ABS housing + metal part, spray color (Silver)
*5.2L brushed stainless steel 304 bowl
*Full metal gear system/ Pure copper motor
*Low noise(75dB at highest speed)
*Variable 8 speed setting
*10 Minutes auto shut off for safe operation
**LED screen show time and speed
*Non-slip feet""",
    "ex":true,
    "id":34,
    "image":"https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/Stand%20Mixer%2FFM116%2F1.jpg?alt=media&token=085033e3-e496-4550-9da1-80f35cd8df12",
    "images":["https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/Stand%20Mixer%2FFM116%2F2.jpg?alt=media&token=a091bb67-b311-41e3-8b63-f7e2ae3fff21",
      "https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/Stand%20Mixer%2FFM116%2F3.jpg?alt=media&token=f4ba9248-04fa-40c6-9e5f-2cc0cedc8eea",
      "https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/Stand%20Mixer%2FFM116%2F4.jpg?alt=media&token=46645df0-70d9-4f80-8c6c-3fdc3ea1af79",
   ],
    "model":"FM116",
    "price":1200,
    "size":'5.2L',
  },
  {
    "brand" :"Stand Mixer",
    "catId":3,
    "dis":"""Stand Mixer / Semi-commercial mixer
Model : FM802 ,800W, 50/60Hz, DC MOTOR
*Full die-casting housing, spray color in White
*7L brushed stainless steel 304 bowl
*Full metal gear system/ Pure copper motor
*Silence working, no noise
*Strong & long no brush DC motor
*Variable 8 speed setting and pulse control
*10 Minutes auto shut off for safe operation
**LED screen with automatic timer
*Non-slip feet""",
    "ex":true,
    "id":35,
    "image":"https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/Stand%20Mixer%2FFM802%2F2.jpg?alt=media&token=5a88181b-53ff-461b-b077-c4c8cd6bff20",
    "images":["https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/Stand%20Mixer%2FFM802%2F2.jpg?alt=media&token=5a88181b-53ff-461b-b077-c4c8cd6bff20",
      "https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/Stand%20Mixer%2FFM802%2F1.png?alt=media&token=a1f7bf2f-3dcb-4cf4-aec1-37e8d86f47ee",
      "https://firebasestorage.googleapis.com/v0/b/sumer-bc931.appspot.com/o/Stand%20Mixer%2FFM802%2F2.png?alt=media&token=ee2a3cb7-c3a2-4c2b-8613-827d50ba315d",
    ],
    "model":"FM802",
    "price":2850,
    "size":'7L',
  },
];

Future<void> updateProducts() async {
  final firestore = FirebaseFirestore.instance;

  // Reference to the collection
  final productsCollection = firestore.collection('invoices');

  // Start a Firestore batch
  WriteBatch batch = firestore.batch();

  // Fetch all products
  QuerySnapshot productsSnapshot = await productsCollection.get();

  for (QueryDocumentSnapshot doc in productsSnapshot.docs) {
    // Get the current document reference
    DocumentReference productRef = productsCollection.doc(doc.id);

    // Update fields in each document
    batch.update(productRef, {
      'paidAmount': 0.0, // Add the default offerPrice value
      // 'currentQty': doc['name'], // Rename the name field to englishName
    });
  }

  // Commit the batch operation
  await batch.commit();
  print("All products updated successfully!");
}


Map<String , dynamic> salesInvoice = {
  "id": "123456",
  "date": "2025-01-26",
  "time": "12:34 PM",
  "customerName": "John Doe",
  "customerId": "78910",
  "items": [
    {
      "productId": "prod_001",
      "productName": "Laptop",
      "quantity": 1,
      "price": 1000,
      "total": 1000
    },
    {
      "productId": "prod_002",
      "productName": "Mouse",
      "quantity": 2,
      "price": 50,
      "total": 100
    }
  ],
  "subTotal": 1100,
  "tax": 110,
  "totalAmount": 1210,
  "paymentMethod": "Cash",
  "status": "Paid",
  "delivered" : true,
  "addressId" : 1,
  "addressInfo" : "",
  "shipmentType"  : "Fast",
  "shipmentAmount"  : 25,
};