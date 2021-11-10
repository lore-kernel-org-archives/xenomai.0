From: "Bezdeka, Florian" <florian.bezdeka@siemens.com>
Subject: Re: [xenomai-images][PATCH v2 3/8] kas: Introduce kas option file for
 CI builds
Date: Wed, 10 Nov 2021 13:23:38 +0000
Message-ID: <4f247c90da63fb084b9f95ecbc4c1c4d6443f010.camel@siemens.com>
References: <20211013121732.140595-1-florian.bezdeka@siemens.com>
 <20211013121732.140595-4-florian.bezdeka@siemens.com>
 <4904b421-4c6a-91d7-5ff0-14066517ab04@siemens.com>
In-Reply-To: <4904b421-4c6a-91d7-5ff0-14066517ab04@siemens.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <40F27CA974CAD84AB1CD393127093892@EURPRD10.PROD.OUTLOOK.COM>
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

T24gV2VkLCAyMDIxLTEwLTEzIGF0IDE0OjIyICswMjAwLCBKYW4gS2lzemthIHdyb3RlOg0KPiBP
biAxMy4xMC4yMSAxNDoxNywgRmxvcmlhbiBCZXpkZWthIHdyb3RlOg0KPiA+IEZvciBub3cgdGhl
IGRpZmZlcmVuY2UgYmV0d2VlbiB0aGUgZGVtbyBhbmQgdGhlICJjaSBpbWFnZSIgaXMgdGhlDQo+
ID4gcmVtb3ZlZCBzc2hkLXJlZ2VuLWtleXMuIFRoYXQgcmVkdWNlcyB0aGUgKGZpcnN0KSBib290
IHRpbWUgZXNwZWNpYWxseQ0KPiA+IG9uIGxvdyBlbmQgQ0kgaGFyZHdhcmUuIEhlbHBzIHRvIHN0
YXkgd2l0aGluIExBVkEgdGltZW91dHMuDQo+ID4gDQo+ID4gQ0kgYnVpbGRzIHdpbGwgbm93IHVz
ZSB0aGF0IGZpbGUuDQo+ID4gDQo+IA0KPiBUb28gbWFueSBvcHRpb25zLiBDYW4ndCB3ZSBjb25z
b2xpZGF0ZSBvdmVyIGEgc2luZ2xlIENJL0NUIHRoaW5nIHRoYXQNCj4gYWxzbyBpbmNsdWRlcyB0
aGUgY2hhbmdlcyBmb3IgY2ktYm9hcmQ/DQoNCkl0IGhhcyBiZWVuIGEgd2hpbGUsIGJ1dCBjb21p
bmcgYmFjayB0byB0aGlzIG5vdy4uLg0KDQpJIGFncmVlLCB3ZSBoYXZlIGEgbG90IG9mIHN1Y2gg
b3B0aW9uIGZpbGVzLCBidXQgYWZ0ZXIgY2hlY2tpbmcgdGhlbQ0KYWxsIGFnYWluOiBUaGV5IGFs
bCBoYXZlIGEgdW5pcXVlIHB1cnBvc2UuDQoNCldlIGRvbid0IGhhdmUgYSBzaW5nbGUgQ0kvQ1Qg
b3B0aW9uIGZpbGUgYmVjYXVzZSB0aGUgcWVtdSB0ZXN0IHRhcmdldHMNCmFyZSBkaWZmZXJlbnQg
aW4gY29tcGFyaXNvbiB0byB0aGUgcmVhbCBib2FyZCB0YXJnZXRzLiBXZSBkbyBub3QgYm9vdA0K
dXAgYSAiZGlzayIvd2ljIGltYWdlLCB3ZSBwYXNzIGEga2VybmVsIGltYWdlIHRvIHFlbXUuDQoN
CldpdGhvdXQgaW50cm9kdWNpbmcgb3B0LWNpLnltbCBJIHdvdWxkIGhhdmUgdG8gc3ByZWFkIHRo
ZSBjaQ0Kb3B0aW1pemF0aW9ucyBpbnRvIHNldmVyYWwgYm9hcmQgc3BlY2lmaWMgY29uZmlncywg
d2hpY2ggd291bGQgZW5hYmxlDQp0aGUgY2kgb3B0aW1pemF0aW9uIGZvciAicmVhbCBib2FyZCBi
dWlsZHMiIGFzIHdlbGwuIFRoYXQgaXMgbm90IHdoYXQNCndlIHdhbnQuDQoNCkZ1cnRoZXIgaWRl
YXM/DQoNCldoYXQgYWJvdXQgaW50cm9kdWNpbmcgYSBjaSBpbWFnZT8gRG9lcyB0aGF0IG1ha2Ug
c2Vuc2U/IFRoZSBjb250ZW50DQp3b3VsZCBuZWFybHkgYmUgdGhlIHNhbWUgYXMgd2l0aGluIG9w
dC1jaS55bWwgbm93Lg0KDQo+IA0KPiBKYW4NCj4gDQoNCg==

