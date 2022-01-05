From: "Bezdeka, Florian" <florian.bezdeka@siemens.com>
Subject: Re: [PATCH 0/7] y2038: cond_wait_prologue64 and related fixes
Date: Wed, 5 Jan 2022 14:56:33 +0000
Message-ID: <c53158602ef5d92c35dade7e66e34fcbafaa333c.camel@siemens.com>
References: <20220105140650.1033850-1-florian.bezdeka@siemens.com>
 <13d8cb9c-591d-481a-73b6-623b892deea0@siemens.com>
In-Reply-To: <13d8cb9c-591d-481a-73b6-623b892deea0@siemens.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <E83E4676558EC641B84ADE4E2C964D1A@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>, "jan.kiszka@siemens.com" <jan.kiszka@siemens.com>

T24gV2VkLCAyMDIyLTAxLTA1IGF0IDE1OjQzICswMTAwLCBKYW4gS2lzemthIHdyb3RlOg0KPiBP
biAwNS4wMS4yMiAxNTowNiwgRmxvcmlhbiBCZXpkZWthIHdyb3RlOg0KPiA+IEhpIGFsbCwNCj4g
PiANCj4gPiB0aGlzIGlzIHRoZSBsYXN0IG1pc3NpbmcgUE9TSVggcmVsYXRlZCB5MjAzOCBhZmZl
Y3RlZCBzeXNjYWxsIGluDQo+ID4gWGVub21haS4gV2l0aCB0aGlzIGFwcGxpZWQgd2UgaGF2ZSB0
d28gWGVub21haSBzcGVjaWZpYyBzeXNjYWxscw0KPiA+IG1pc3Npbmc6DQo+ID4gDQo+ID4gICAt
IHNjX2NvYmFsdF90aHJlYWRfc2V0c2NoZWRwYXJhbV9leA0KPiA+ICAgLSBzY19jb2JhbHRfdGhy
ZWFkX2dldHNjaGVkcGFyYW1fZXgNCj4gPiANCj4gPiBXaGlsZSBhZGRpbmcgdGVzdHMgZm9yIHRo
ZSBpbnRyb2R1Y2VkIGNvbmRfd2FpdF9wcm9sb2d1ZTY0IEkgaGl0IGENCj4gPiBrZXJuZWwgT09Q
UyBkdWUgdG8gaW5zdWZpY2llbnQgdmFsaWRhdGlvbiBvZiB1c2VyIHByb3ZpZGVkIHBvaW50ZXJz
Lg0KPiA+IFRoYXQgaGFzIGJlZW4gYWRkcmVzc2VkIGFzIHdlbGwuDQo+IA0KPiBUaGFua3MgZm9y
IGJvdGghIElzIGl0IHBvc3NpYmx5IHRvIG1vdmUgdGhlIGZpeGVzIHRoZSBmcm9udD8gVGhhdCB3
b3VsZA0KPiBhbHNvIGVuc3VyZSB0aGF0IEkgY2FuIGVhc2lseSBwaWNrIHRoZW0gaW50byBzdGFi
bGUuDQoNClllcy4gUGF0Y2ggNCBhbmQgNyBjb3VsZCBiZSBtb3ZlZCB0byB0aGUgZnJvbnQgZWFz
aWx5LiBEbyB5b3Ugd2FudCBtZQ0KdG8gc3BsaXQgcGF0Y2ggMiBpbnRvIHRoZSB5MjAzOCBhbmQg
bm9uIHkyMDM4IHBhcnQsIG9yIGRvZXMgdGhhdCBub3QNCnF1YWxpZnkgZm9yIHN0YWJsZSBhdCBh
bGw/DQoNCj4gDQo+IFRoYW5rcywNCj4gSmFuDQo+IA0KDQo=

