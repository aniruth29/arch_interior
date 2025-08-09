'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "34f2018f475ded4203909a85eb77157f",
"assets/AssetManifest.bin.json": "4a66f7d26178d2e26bfae373171576b9",
"assets/AssetManifest.json": "aef783a9a2f06f4d78e1ec63b5089481",
"assets/assets/2.0x/aluminium_fact.jpg": "4a688c29953fb25406d439aff5571073",
"assets/assets/aboutus_image.jpeg": "9bc2d69469754272ebf3eaac13ff15b3",
"assets/assets/aluminium_fact.jpg": "4a688c29953fb25406d439aff5571073",
"assets/assets/aluminium_factory.webp": "77e156e5fb43ce56249d02bf2312b7a0",
"assets/assets/ashok_leyland_logo.png": "0dd26b84279cabe1fe4f92a15c820805",
"assets/assets/brakes_india.png": "68776cbe99051212048d977b35f189a4",
"assets/assets/century_ply.png": "5984cac9e408d938f575ec9242cccb2b",
"assets/assets/client1.jpeg": "62ff4cb4a76219994577baa846aabb8e",
"assets/assets/client2.jpeg": "3c9a33606ea73cc1e60475c559e7239f",
"assets/assets/client3.jpeg": "86f4119361ccfaab66c149b64015eb4d",
"assets/assets/commerical.png": "926afd049dda66db5345267076ade25c",
"assets/assets/construction.png": "4a50d96455d06eb6b650c08673d58691",
"assets/assets/hero_image.jpeg": "e5c4f8fa450b655dd55f18c497c95325",
"assets/assets/home.png": "74a0ec4354bd0093caa85c5753e7ccc1",
"assets/assets/indocool.png": "91caedb35e78260269fbc1639f1ae249",
"assets/assets/km.png": "c64dc2653954d0356e1879c6f7a9cfd9",
"assets/assets/logo.png": "42857b471c546c2015028ddf34ea1d17",
"assets/assets/logo_bg.png": "fe335d2c06241aec48f32dc3491df870",
"assets/assets/modular_bedroom.jpg": "7835c7cc1a4394b00313403548fd18e2",
"assets/assets/modular_interior.jpg": "12eacf42a7286c97fe3d41cc06f24f2f",
"assets/assets/modular_kitchen.jpeg": "ad7e68b08160a15b71442b55a4632d21",
"assets/assets/office.png": "df2a646d3333df5ca921d18fff900e4c",
"assets/assets/opmobility.png": "417794089cf73319f3607469fe0f76a0",
"assets/assets/rks.jpg": "a29b52f487e0405985fd667a97beee39",
"assets/assets/room1,1.jpg": "18f7dfd50844291e4e4dc34ab7c7a4e7",
"assets/assets/room1,2.jpg": "1722b28b97c072fd896250e9cfd889ee",
"assets/assets/room2,1.jpg": "afce11fd3fad700cba34c9f312f1ce87",
"assets/assets/room2,2.jpg": "4c19383f5793a07f57544c4bcf24dd64",
"assets/assets/sundaram.png": "b87cd9c0630200bbe842184f1734dd2b",
"assets/assets/swanag.png": "3ac91feb3bbee30bfabd92669e73021d",
"assets/assets/tidc.jpeg": "d756c83a3aa36c85a639fe951a754b1f",
"assets/assets/wardrobe.jpg": "3f64aaa292e547d60a17b632f8550621",
"assets/assets/wooden_factory.webp": "7f98571178e7f16165d4d04a4124877c",
"assets/FontManifest.json": "db8f453ee5bd623ef9ffbe9d7a009cf7",
"assets/fonts/MaterialIcons-Regular.otf": "3c548b9cf09bfa17cc52c59bb61a4a72",
"assets/NOTICES": "61c6d1d583934a8f74506628e88d6c19",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
"assets/packages/material_symbols_icons/lib/fonts/MaterialSymbolsOutlined.ttf": "1e1c756dea990b722332b90447808cd1",
"assets/packages/material_symbols_icons/lib/fonts/MaterialSymbolsRounded.ttf": "111e80415827a37f1372203ad5921abc",
"assets/packages/material_symbols_icons/lib/fonts/MaterialSymbolsSharp.ttf": "e3e83d387dbbbdd693f8374d1ef022ff",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"canvaskit/canvaskit.js": "86e461cf471c1640fd2b461ece4589df",
"canvaskit/canvaskit.js.symbols": "68eb703b9a609baef8ee0e413b442f33",
"canvaskit/canvaskit.wasm": "efeeba7dcc952dae57870d4df3111fad",
"canvaskit/chromium/canvaskit.js": "34beda9f39eb7d992d46125ca868dc61",
"canvaskit/chromium/canvaskit.js.symbols": "5a23598a2a8efd18ec3b60de5d28af8f",
"canvaskit/chromium/canvaskit.wasm": "64a386c87532ae52ae041d18a32a3635",
"canvaskit/skwasm.js": "f2ad9363618c5f62e813740099a80e63",
"canvaskit/skwasm.js.symbols": "80806576fa1056b43dd6d0b445b4b6f7",
"canvaskit/skwasm.wasm": "f0dfd99007f989368db17c9abeed5a49",
"canvaskit/skwasm_st.js": "d1326ceef381ad382ab492ba5d96f04d",
"canvaskit/skwasm_st.js.symbols": "c7e7aac7cd8b612defd62b43e3050bdd",
"canvaskit/skwasm_st.wasm": "56c3973560dfcbf28ce47cebe40f3206",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "76f08d47ff9f5715220992f993002504",
"flutter_bootstrap.js": "b2db85910dcd2dcd17e493b0065667b3",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "9e4ecdaa7fa4aa8260d7883289332457",
"/": "9e4ecdaa7fa4aa8260d7883289332457",
"main.dart.js": "29e5830ff78d8def8001e5177ea06c93",
"manifest.json": "dc5cb2a0437968ac72f400ac6293e80f",
"version.json": "814ad4538e60afef3d79d050878a30f5"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
