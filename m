From: "Bezdeka, Florian" <florian.bezdeka@siemens.com>
Subject: Re: [PATCH 1/2] y2038: cobalt/posix/mutex: try acquire mutex before
 checking timeout
Date: Wed, 30 Jun 2021 06:59:51 +0000
Message-ID: <94cd19a4ccd202be8552525f9ced1d33a8ff406a.camel@siemens.com>
References: <1625034731-29827-1-git-send-email-chensong_2000@189.cn>
 <073d25fa-3b8e-d91f-690e-7a5e5d67eddc@siemens.com>
In-Reply-To: <073d25fa-3b8e-d91f-690e-7a5e5d67eddc@siemens.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <C579FE9E73432F4C9CD964ECFAB8ED5D@EURPRD10.PROD.OUTLOOK.COM>
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
To: "xenomai@xenomai.org" <xenomai@xenomai.org>, "jan.kiszka@siemens.com" <jan.kiszka@siemens.com>, "chensong_2000@189.cn" <chensong_2000@189.cn>

T24gV2VkLCAyMDIxLTA2LTMwIGF0IDA4OjUwICswMjAwLCBKYW4gS2lzemthIHdyb3RlOg0KPiBP
biAzMC4wNi4yMSAwODozMiwgU29uZyBDaGVuIHZpYSBYZW5vbWFpIHdyb3RlOg0KPiA+IElmIGEg
cHJlb2Nlc3MgaXMgY2FsbGluZyBtdXRleF90aW1lZGxvY2sgdG8gYWNxdWlyZSByZXNvdXJjZSB3
aXRoDQo+ID4gYW4gaW52YWxpZCB0aW1lb3V0LCBtdXRleF90aW1lZGxvY2sgcmV0dXJucyAtRUZB
VUxUIGV2ZW4gcmVzb3VyY2UNCj4gPiBpcyBhdmFpbGFibGUsIGl0IGRvZXNuJ3QgbWFrZSBhbnkg
c2Vuc2UuDQo+ID4gDQo+IA0KPiBJdCBkb2VzIG1ha2Ugc2Vuc2UgZnJvbSB0aGUgcGVyc3BlY3Rp
dmUgb2YgZGV0ZWN0aW5nIHByb2dyYW1taW5nIGVycm9ycw0KPiBvZiB1c2Vyc3BhY2UgZWFybGll
ciwgbm90IG9ubHkgaW4gdGhlIGNvbnRlbnRpb24gY2FzZS4gSXMgUE9TSVgNCj4gZm9yYmlkZGlu
ZyB1cyB0byBkbyB0aGF0PyBJZiBub3QsIEkgd291bGQgcmF0aGVyIHN0aWNrIHdpdGggdGhlIGN1
cnJlbnQNCj4gc2NoZW1lLg0KDQpQT1NJWCBzYXlzIHRoZSAiVGhlIHZhbGlkaXR5IG9mIHRoZSBh
YnNfdGltZW91dCBwYXJhbWV0ZXIgbmVlZCBub3QgYmUNCmNoZWNrZWQgaWYgdGhlIG11dGV4IGNh
biBiZSBsb2NrZWQgaW1tZWRpYXRlbHkuIiwgc28gd2UgYXJlIHN0aWxsDQphbGxvd2VkIHRvIHZh
bGlkYXRlLCBidXQgbWF5YmUgc2hvdWxkIG5vdC4NCg0KVGhlIHNlbV90aW1lZHdhaXQoKSBkb2Vz
IG5vdCB2YWxpZGF0ZSBpbiBjYXNlIHRoZSBzZW1hcGhvcmUgaXMNCmF2YWlsYWJsZSwgc28gd2Un
cmUgdHJ5aW5nIHRvIGNvbnNvbGlkYXRlIGhlcmUuDQoNCj4gDQo+IEphbg0KPiANCg0K

