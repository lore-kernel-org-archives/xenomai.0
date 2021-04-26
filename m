From: "Bezdeka, Florian" <florian.bezdeka@siemens.com>
Subject: Re: y2038 wiki/roadmap and development branch update
Date: Mon, 26 Apr 2021 09:33:04 +0000
Message-ID: <da58f467a5fed5dce870c46633f79f54aa0710a2.camel@siemens.com>
References: <bd6bbdd2de6f649a5c93a31dd9ef0e1c432d9ca2.camel@siemens.com>
 <f16dfe97-865f-37ae-5979-11696f3c12bc@189.cn>
In-Reply-To: <f16dfe97-865f-37ae-5979-11696f3c12bc@189.cn>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <4B0301A36CA0114DA676D70B4CBBEED1@EURPRD10.PROD.OUTLOOK.COM>
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
To: "chensong_2000@189.cn" <chensong_2000@189.cn>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>, "jan.kiszka@siemens.com" <jan.kiszka@siemens.com>, "chensong@tj.kylinos.cn" <chensong@tj.kylinos.cn>

T24gTW9uLCAyMDIxLTA0LTI2IGF0IDE3OjIxICswODAwLCBjaGVuc29uZ18yMDAwQDE4OS5jbiB3
cm90ZToNCj4gDQo+IOWcqCAyMDIxLzQvMjMg5LiL5Y2IMTE6MzAsIEJlemRla2EsIEZsb3JpYW4g
5YaZ6YGTOg0KPiA+IEhpIFNvbmcsDQo+ID4gDQo+ID4gSSBqdXN0IG1vdmVkIHRoZSB5MjAzOCBy
b2FkbWFwIHdlIG9uY2UgcHJlcGFyZWQgaW4gbXkgcGVyc29uYWwNCj4gPiBnaXRsYWIuY29tIHBy
b2plY3QgdG8gdGhlIG9mZmljaWFsIFhlbm9tYWkgaGFja2Vyc3BhY2UgWzFdLg0KPiA+IA0KPiA+
IEluIGFkZGl0aW9uIHRoZXJlIGlzIG5vdyBhIGZsb3JpYW4veTIwMzggYnJhbmNoIGluIHRoZSBY
ZW5vbWFpDQo+ID4gaGFja2Vyc3BhY2UgWzJdIHdoaWNoIGhvbGRzIHRoZSBjdXJyZW50IHN0YXRl
LiBUaGlzIGJyYW5jaCBpcyBiYXNlZCBvbg0KPiA+IGN1cnJlbnQgd2lwL2RvdmV0YWlsLCBzbyBp
dCdzIG5vdCBhIHN0YWJsZSBicmFuY2ggYW5kIG1pZ2h0IGJlIHJlYmFzZWQNCj4gPiB3aGVuZXZl
ciBuZWVkZWQuDQo+ID4gDQo+ID4gV2hpbGUgdXBkYXRpbmcgdGhlIHJvYWRtYXAgSSBqdXN0IHJl
YWxpemVkIHRoYXQgd2UgYWxyZWFkeSBtaXNzZWQgdHdvDQo+ID4gYWZmZWN0ZWQgc3lzY2FsbHMs
IHdoaWNoIChhY2NvcmRpbmcgdG8gdGhlIGN1cnJlbnQgc3lzY2FsbCB0YWJsZQ0KPiA+IG9yZGVy
aW5nKSB3b3VsZCBiZSB0aGUgZmlyc3QgdHdvOg0KPiA+IMKgwqDCoC0gc2NfY29iYWx0X3RocmVh
ZF9zZXRzY2hlZHBhcmFtX2V4DQo+ID4gwqDCoMKgLSBzY19jb2JhbHRfdGhyZWFkX2dldHNjaGVk
cGFyYW1fZXgNCj4gDQo+IGkgbG9va2VkIGludG8gZnVuY3Rpb25zIHRocmVhZF9zZXRzY2hlZHBh
cmFtX2V4L3RocmVhZF9nZXRzY2hlZHBhcmFtX2V4LCANCj4gZGlkbid0IGZpbmQgYW55dGhpbmcg
YWJvdXQgdGltZTY0LCBidXQgaSB3aWxsIGtlZXAgaXQgaW4gbWluZC4NCg0KVGhlcmUgaXMgYSBz
dHJ1Y3Qgc2NoZWRfcGFyYW1fZXggY29taW5nIGluIGFzIHBhcmFtZXRlciB3aGljaCBob2xkcw0K
c3RydWN0IF9fc2NoZWRfcnJfcGFyYW0gd2hpY2ggaG9sZHMgc3RydWN0IF9fdXNlcl9vbGRfdGlt
ZXNwZWMgd2hpY2ggaXMNCm5vdCB5MjAzOCBzYWZlLg0KDQo+IA0KPiA+IA0KPiA+IEkgdXBkYXRl
ZCB0aGUgcm9hZG1hcCBhY2NvcmRpbmdseSBhbmQgcmUtc29ydGVkIHRoZSB0YWJsZS4gV291bGQg
YmUNCj4gPiBuaWNlIGlmIHlvdSBjb3VsZCBkb3VibGUtY2hlY2sgdGhhdCBhZ2Fpbi4NCj4gDQo+
IGRvbmUsIHRoYW5rcw0KPiA+IA0K

