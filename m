From: "Bezdeka, Florian" <florian.bezdeka@siemens.com>
Subject: Re: [PATCH] drivers/testing/switchtest: Properly clean up xnthread on
 error
Date: Thu, 7 Oct 2021 14:31:48 +0000
Message-ID: <d8a7952b994212f07834dd7af4aa79126f2a9138.camel@siemens.com>
References: <6f7e5329-69ef-4a7c-7227-c49a5c7a8a23@siemens.com>
In-Reply-To: <6f7e5329-69ef-4a7c-7227-c49a5c7a8a23@siemens.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <C0DCA2F54B613B4EA3FF615D788920A0@EURPRD10.PROD.OUTLOOK.COM>
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

T24gVGh1LCAyMDIxLTEwLTA3IGF0IDE2OjEyICswMjAwLCBKYW4gS2lzemthIHZpYSBYZW5vbWFp
IHdyb3RlOg0KPiBGcm9tOiBKYW4gS2lzemthIDxqYW4ua2lzemthQHNpZW1lbnMuY29tPg0KPiAN
Cj4gQW5hbG9nb3VzbHkgdG8gZGZiNTVkNjRmYzBkLg0KDQpTZWVtcyBib3RoIHF1YWxpZnkgZm9y
IHN0YWJsZS4NCg0KPiANCj4gU2lnbmVkLW9mZi1ieTogSmFuIEtpc3prYSA8amFuLmtpc3prYUBz
aWVtZW5zLmNvbT4NCj4gLS0tDQo+ICBrZXJuZWwvZHJpdmVycy90ZXN0aW5nL3N3aXRjaHRlc3Qu
YyB8IDIgKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYg
LS1naXQgYS9rZXJuZWwvZHJpdmVycy90ZXN0aW5nL3N3aXRjaHRlc3QuYyBiL2tlcm5lbC9kcml2
ZXJzL3Rlc3Rpbmcvc3dpdGNodGVzdC5jDQo+IGluZGV4IDgyMjQ5NzRlNWMuLjZmOGE5ZmNhYTMg
MTAwNjQ0DQo+IC0tLSBhL2tlcm5lbC9kcml2ZXJzL3Rlc3Rpbmcvc3dpdGNodGVzdC5jDQo+ICsr
KyBiL2tlcm5lbC9kcml2ZXJzL3Rlc3Rpbmcvc3dpdGNodGVzdC5jDQo+IEBAIC01MDQsNiArNTA0
LDggQEAgc3RhdGljIGludCBydHN3aXRjaF9jcmVhdGVfa3Rhc2soc3RydWN0IHJ0c3dpdGNoX2Nv
bnRleHQgKmN0eCwNCj4gIAkJc2F0dHIuZW50cnkgPSBydHN3aXRjaF9rdGFzazsNCj4gIAkJc2F0
dHIuY29va2llID0gJmFyZzsNCj4gIAkJZXJyID0geG50aHJlYWRfc3RhcnQoJnRhc2stPmt0YXNr
LCAmc2F0dHIpOw0KPiArCQlpZiAoZXJyKQ0KPiArCQkJX194bnRocmVhZF9kaXNjYXJkKCZ0YXNr
LT5rdGFzayk7DQo+ICAJfSBlbHNlDQo+ICAJCS8qDQo+ICAJCSAqIEluIG9yZGVyIHRvIGF2b2lk
IGNhbGxpbmcgeG50aHJlYWRfY2FuY2VsKCkgZm9yIGFuDQoNCg==

