From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
Subject: RE: [PATCH v2 2/3] Add --with-kernelshark option
Date: Thu, 3 Mar 2022 06:48:51 +0000
Message-ID: <MN2PR11MB4285E18E7B7408E1569BA917F2049@MN2PR11MB4285.namprd11.prod.outlook.com>
References: <20220302025721.9354-1-hongzhan.chen@intel.com>
 <20220302025721.9354-2-hongzhan.chen@intel.com>
 <6e6af75b-dc2e-ca94-3fba-d5c3785edf7e@siemens.com>
 <MN2PR11MB428578EBDC156D45F80AC814F2049@MN2PR11MB4285.namprd11.prod.outlook.com>
 <f1820385-31df-7e26-fa33-201b298e22b9@siemens.com>
In-Reply-To: <f1820385-31df-7e26-fa33-201b298e22b9@siemens.com>
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
To: "Kiszka, Jan" <jan.kiszka@siemens.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEphbiBLaXN6a2EgPGphbi5r
aXN6a2FAc2llbWVucy5jb20+IA0KPlNlbnQ6IFRodXJzZGF5LCBNYXJjaCAzLCAyMDIyIDI6Mzkg
UE0NCj5UbzogQ2hlbiwgSG9uZ3poYW4gPGhvbmd6aGFuLmNoZW5AaW50ZWwuY29tPjsgeGVub21h
aUB4ZW5vbWFpLm9yZw0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgMi8zXSBBZGQgLS13aXRoLWtl
cm5lbHNoYXJrIG9wdGlvbg0KPg0KPk9uIDAzLjAzLjIyIDA3OjMwLCBDaGVuLCBIb25nemhhbiB3
cm90ZToNCj4+IA0KPj4gDQo+PiANCj4+Pj4gKwl0cmFjaW5nL01ha2VmaWxlIFwNCj4+Pj4gKwl0
cmFjaW5nL2tlcm5lbHNoYXJrL01ha2VmaWxlIFwNCj4+Pj4gIAlsaWIvTWFrZWZpbGUgXA0KPj4+
PiAgCWxpYi9ib2lsZXJwbGF0ZS9NYWtlZmlsZSBcDQo+Pj4+ICAJbGliL2JvaWxlcnBsYXRlL2lu
aXQvTWFrZWZpbGUgXA0KPj4+PiBkaWZmIC0tZ2l0IGEvdHJhY2luZy9NYWtlZmlsZS5hbSBiL3Ry
YWNpbmcvTWFrZWZpbGUuYW0NCj4+Pj4gaW5kZXggOGJkZjFmOTA2Li43OTI1YWU5YzYgMTAwNjQ0
DQo+Pj4+IC0tLSBhL3RyYWNpbmcvTWFrZWZpbGUuYW0NCj4+Pj4gKysrIGIvdHJhY2luZy9NYWtl
ZmlsZS5hbQ0KPj4+PiBAQCAtMSw2ICsxLDcgQEANCj4+Pj4gLQ0KPj4+PiAraWYgQlVJTERfS0VS
TkVMU0hBUksNCj4+Pj4gIFNVQkRJUlMgPQkJXA0KPj4+PiAgCWtlcm5lbHNoYXJrDQo+Pj4+ICtl
bmRpZg0KPj4+PiAgDQo+Pj4+ICBESVNUX1NVQkRJUlMgPSAJCVwNCj4+Pj4gIAlrZXJuZWxzaGFy
aw0KPj4+DQo+Pj4gU2VlbXMgeW91IGxvc3QgdGhlIEFDX1BST0dfQ1hYIC0gdGhpbmdzIGRvIG5v
dCBidWlsZCBub3cuDQo+PiANCj4+IFNvcnJ5LCBJIGFzc3VtZWQgdGhhdCBwYXRjaCBbMV0gcGFz
cyByZXZpZXcgLCBzbyBJIGhhdmUgbm90IGNvbW1pdHRlZCBhZ2FpbiB0byByZXZpZXcuDQo+PiBD
b3VsZCB5b3UgYXBwbHkgdGhpcyBwYXRjaD8NCj4+IA0KPj4gaHR0cHM6Ly94ZW5vbWFpLm9yZy9w
aXBlcm1haWwveGVub21haS8yMDIyLUZlYnJ1YXJ5LzA0NzI2Mi5odG1sDQo+PiANCj4NCj5XaGVu
IHNlbmRpbmcgdjQgYWZ0ZXIgbXkgcmV2aWV3IHJlbWFya3MsIHBsZWFzZSBpbmNsdWRlIGFsbCBw
YXRjaGVzLg0KDQpJZiBpdCBhbHJlYWR5IHBhc3MgcmV2aWV3ICwgd2h5IGNhbm5vdCB3ZSBtZXJn
ZSBpdCBhdCBmaXJzdD8NCg0KUmVnYXJkcw0KDQpIb25nemhhbiBDaGVuDQo+DQo+SmFuDQo+DQo+
LS0gDQo+U2llbWVucyBBRywgVGVjaG5vbG9neQ0KPkNvbXBldGVuY2UgQ2VudGVyIEVtYmVkZGVk
IExpbnV4DQo+DQo=

