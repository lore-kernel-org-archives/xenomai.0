From: "DIAO, Hanson" <hanson.diao@siemens.com>
Subject: RE: A potential Xenomai Mutex issue
Date: Fri, 23 Aug 2019 17:27:29 +0000
Message-ID: <DM6PR07MB59618611F0A6CBCAF565B856E7A40@DM6PR07MB5961.namprd07.prod.outlook.com>
References: <DM6PR07MB596162CF3DD4EB4071336D26E7A50@DM6PR07MB5961.namprd07.prod.outlook.com>
 <43f9470f-ed47-0a2a-71f5-ca9bca08879a@siemens.com>
 <DM6PR07MB59614BFAE90AE8DA6B49769EE7A40@DM6PR07MB5961.namprd07.prod.outlook.com>
 <2f51ad42-4be3-606d-dbdf-ee036bd562de@siemens.com>
 <DM6PR07MB59610EC30F9B7433FBD53E35E7A40@DM6PR07MB5961.namprd07.prod.outlook.com>
 <d3ed1327-3026-6489-a66b-56f9680f08d2@siemens.com>
 <DM6PR07MB596161BCD969C8C69F2E8D31E7A40@DM6PR07MB5961.namprd07.prod.outlook.com>
 <eb28e913-89d2-6141-c37d-e2c5e0a540ec@siemens.com>
In-Reply-To: <eb28e913-89d2-6141-c37d-e2c5e0a540ec@siemens.com>
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
To: "jan.kiszka@siemens.com" <jan.kiszka@siemens.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Tm8sIHRoZSB0aHJlYWQgd2FzIG5vdCBkb2luZyBhbnkgbWlncmF0aW9ucyB0byBzZWNvbmRhcnkg
bW9kZS4NCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEphbiBLaXN6a2EgPGph
bi5raXN6a2FAc2llbWVucy5jb20+DQpTZW50OiBGcmlkYXksIEF1Z3VzdCAyMywgMjAxOSAxMjox
OSBQTQ0KVG86IERJQU8sIEhhbnNvbiAoREkgUEEgQ0kgUkMgUiZEIFNXMikgPGhhbnNvbi5kaWFv
QHNpZW1lbnMuY29tPg0KQ2M6IHhlbm9tYWlAeGVub21haS5vcmcNClN1YmplY3Q6IFJlOiBBIHBv
dGVudGlhbCBYZW5vbWFpIE11dGV4IGlzc3VlDQoNCk9uIDIzLjA4LjE5IDE3OjQ5LCBESUFPLCBI
YW5zb24gKERJIFBBIENJIFJDIFImRCBTVzIpIHdyb3RlOg0KPiBIaSBKYW4sDQo+DQo+IFRoYW5r
IHlvdSBmb3IgeW91ciByZXBseS4gUGxlYXNlIHNlZSBteSBmb2xsb3dpbmcgY29tbWVudHMuIFRo
YW5rIHlvdSBzbyBtdWNoLg0KPg0KPg0KPiBGb3IgdGhlIGlzc3VlIDIgdGhlIHRlc3QgY2FzZSBp
cyB2ZXJ5IHNpbXBsZS4gVGhlIGxvY2sgc2VxdWVuY2UgaXMgYXMgYmVsb3cuIEFmdGVyIFJlYWRS
ZWcgZnVuY3Rpb24gSSBjaGVja2VkIHRoZSBsb2NrY250LiBUaGUgbG9ja2NudCBpcyAxLg0KPiBJ
bnQgd3JpdGVSZWcoKQ0KPiB7DQo+ICAgICAgIFNNSUxvY2soKTsNCj4gICAgICAgUmVhZFJlZygp
Ow0KPiAgICAgICAuLi4uLi4NCj4gICAgICAgU01JVW5sb2NrKCk7DQo+IH0NCj4NCj4gSW50IFJl
YWRSZWcoKQ0KPiB7DQo+ICAgICAgIFNNSUxvY2soKTsNCj4gICAgICAgLyogIENoZWNrIHRoZSBs
b2NrY250IGhlcmUuIEl0IGlzIHN0aWxsIDEsIHNob3VsZCBiZSAyICovDQo+ICAgICAgIC4uLi4u
Li4uDQo+ICAgICAgIC4uLi4uLg0KPiAgICAgICBTTUlVbmxvY2soKTsNCj4gfQ0KDQpJcyB0aGUg
dGhyZWFkIGRvaW5nIGFueSBtaWdyYXRpb25zIHRvIHNlY29uZGFyeSBtb2RlIGJldHdlZW4gdGhl
IGVudHJ5IG9mIHdyaXRlUmVnIGFuZCB0aGUgY2hlY2tpbmcgb2YgbG9ja2NudD8NCg0KSmFuDQoN
Ci0tDQpTaWVtZW5zIEFHLCBDb3Jwb3JhdGUgVGVjaG5vbG9neSwgQ1QgUkRBIElPVCBTRVMtREUg
Q29ycG9yYXRlIENvbXBldGVuY2UgQ2VudGVyIEVtYmVkZGVkIExpbnV4DQo=

