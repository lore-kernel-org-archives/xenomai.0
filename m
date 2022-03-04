From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
Subject: RE: [PATCH v3] libtraceevent: Add xenomai_schedparams plugin for
 libtraceevent
Date: Fri, 4 Mar 2022 05:31:24 +0000
Message-ID: <MN2PR11MB42857C9B9EEF23B3F6A3DB0FF2059@MN2PR11MB4285.namprd11.prod.outlook.com>
References: <20220303012031.16509-1-hongzhan.chen@intel.com>
 <9191fe03-91df-0ff9-0dd2-33d04641374d@siemens.com>
 <8b23b623-d1b2-e35e-5386-b2220e581c15@siemens.com>
 <MN2PR11MB428569D5D1A197DF1B742172F2059@MN2PR11MB4285.namprd11.prod.outlook.com>
In-Reply-To: <MN2PR11MB428569D5D1A197DF1B742172F2059@MN2PR11MB4285.namprd11.prod.outlook.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
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
To: "Kiszka, Jan" <jan.kiszka@siemens.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>, "florian.bezdeka@siemens.com" <florian.bezdeka@siemens.com>

DQoNCg0KDQoNCj4+LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4+RnJvbTogSmFuIEtpc3pr
YSA8amFuLmtpc3prYUBzaWVtZW5zLmNvbT4gDQo+PlNlbnQ6IFRodXJzZGF5LCBNYXJjaCAzLCAy
MDIyIDM6MDEgUE0NCj4+VG86IENoZW4sIEhvbmd6aGFuIDxob25nemhhbi5jaGVuQGludGVsLmNv
bT47IHhlbm9tYWlAeGVub21haS5vcmc7IGZsb3JpYW4uYmV6ZGVrYUBzaWVtZW5zLmNvbQ0KPj5T
dWJqZWN0OiBSZTogW1BBVENIIHYzXSBsaWJ0cmFjZWV2ZW50OiBBZGQgeGVub21haV9zY2hlZHBh
cmFtcyBwbHVnaW4gZm9yIGxpYnRyYWNlZXZlbnQNCj4+DQo+DQo+Pj4+ICsJbGlidHJhY2VldmVu
dA0KPj4+PiArZWxzZQ0KPj4+PiArDQo+Pj4+ICtpZiBCVUlMRF9MSUJUUkFDRUVWRU5UDQo+Pj4+
ICtTVUJESVJTID0JCVwNCj4+Pj4gKwlsaWJ0cmFjZWV2ZW50DQo+Pj4+ICtlbmRpZg0KPj4+PiAr
DQo+Pj4gDQo+Pj4gWW91IHdhbnQgU1VCRElSUyArPSAuLi4NCj4+PiANCj4+PiBTZWUgZXhpc3Rp
bmcgbWFrZWZpbGVzLg0KPj4+IA0KPj4NCj4+T2gsIGFuZCBJIGRvbid0IHRoaW5rIHRoYXQgdGhl
IGtlcm5lbHNoYXJrIHBsdWdpbiB0ZWNobmljYWxseSBkZXBlbmRzIG9uDQo+DQo+SWYgd2UgcmVt
b3ZlIGluY2x1ZGUgcGF0aCBUUkFDRUVWRU5SX0lOQ0xVRFMgPz0gL3Vzci9sb2NhbC9pbmNsdWRl
L3RyYWNlZXZlbnQNCj5pbiBwbHVnaW4gTWFrZWZpbGUuYW0sIGl0IHJlcG9ydCBmb2xsb3dpbmcg
ZXJyb3I6DQo+L3Vzci9sb2NhbC9pbmNsdWRlL3RyYWNlLWNtZC90cmFjZS1jbWQuaDo5OjEwOiBm
YXRhbCBlcnJvcjogZXZlbnQtcGFyc2UuaDogTm8gc3VjaCBmaWxlIG9yIGRpcmVjdG9yeQ0KPiAg
ICA5IHwgI2luY2x1ZGUgImV2ZW50LXBhcnNlLmgiICAgICAgIA0KPg0KPkl0IGRlZmluZWx5IGRl
cGVuZHMgb24gbGlidHJhY2VldmVudCBvbmUuDQoNCkkgd2lsbCByZW1vdmUgdGhlIGRlcGVuZGVu
Y3kgYmV0d2VlbiB0d28gcGx1Z2lucyBpbiBWNC4NCg0KUmVnYXJkcw0KDQpIb25nemhhbiBDaGVu
DQo+DQo+UmVnYXJkcw0KPg0KPkhvbmd6aGFuIENoZW4NCj4gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIA0KPj50aGUgbGlidHJhY2Vl
dmVudCBvbmUuIEJvdGggY2FuIGJlIGFuZCBhcmUgY29udHJvbGxlZCB2aWEgY29uZmlndXJlDQo+
PmluZGVwZW5kZW50bHksIHRob3VnaCB5b3Ugbm9ybWFsbHkgL3dhbnQvIGxpYnRyYWNlZXZlbnQg
YXMgd2VsbCB3aGVuDQo+PnVzaW5nIHRoZSBrZXJuZWxzaGFyayBwbHVnaW4uDQo+Pg0KPj5KYW4N
Cj4+DQo+Pi0tIA0KPj5TaWVtZW5zIEFHLCBUZWNobm9sb2d5DQo+PkNvbXBldGVuY2UgQ2VudGVy
IEVtYmVkZGVkIExpbnV4DQo=

