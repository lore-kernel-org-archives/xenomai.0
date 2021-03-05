From: "florian.bezdeka@siemens.com" <florian.bezdeka@siemens.com>
Subject: Re: [y2038][RFC PATCH 2/2] y2038: Adding sem_timedwait_time64
Date: Fri, 5 Mar 2021 07:53:47 +0000
Message-ID: <d2cba251eaa972233bfc19c664b7c145bd3a1c63.camel@siemens.com>
References: <87v9a7z0xh.fsf@xenomai.org>
 <20210304113653.45432-1-florian.bezdeka@siemens.com>
 <20210304113653.45432-3-florian.bezdeka@siemens.com>
 <6041C65D.1070109@tj.kylinos.cn>
 <20427835a99ada0a326072d8c4e2941e3b12121e.camel@siemens.com>
 <6041E0F6.9060509@tj.kylinos.cn>+54A20D85F00AA805
In-Reply-To: <6041E0F6.9060509@tj.kylinos.cn>+54A20D85F00AA805
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <22AB7EE353608044854B23186836567E@EURPRD10.PROD.OUTLOOK.COM>
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
To: "chensong@tj.kylinos.cn" <chensong@tj.kylinos.cn>
Cc: "rpm@xenomai.org" <rpm@xenomai.org>, "xenomai@xenomai.org" <xenomai@xenomai.org>, "jan.kiszka@siemens.com" <jan.kiszka@siemens.com>, "chensong@kylinos.cn" <chensong@kylinos.cn>

T24gRnJpLCAyMDIxLTAzLTA1IGF0IDE1OjQyICswODAwLCBjaGVuc29uZyB3cm90ZToNCj4gDQo+
ID4gPiA+IA0KPiA+ID4gPiArQ09CQUxUX1NZU0NBTEwoc2VtX3RpbWVkd2FpdF90aW1lNjQsIHBy
aW1hcnksDQo+ID4gPiA+ICsJICAgICAgIChzdHJ1Y3QgY29iYWx0X3NlbV9zaGFkb3cgX191c2Vy
ICp1X3NlbSwNCj4gPiA+ID4gKwkJY29uc3Qgc3RydWN0IF9fa2VybmVsX3RpbWVzcGVjIF9fdXNl
ciAqdV90cykpDQo+ID4gPiA+ICt7DQo+ID4gPiA+ICsJc3RydWN0IHRpbWVzcGVjNjQgdHM2NDsN
Cj4gPiA+ID4gKw0KPiA+ID4gPiArCWlmIChnZXRfdGltZXNwZWM2NCgmdHM2NCwgdV90cykpDQo+
ID4gPiANCj4gPiA+IGdldF90aW1lc3BlYzY0IGRpZG4ndCBleGlzdCB1bnRpbCBrZXJuZWwgNC4x
Mywgc2hhbGwgd2UgdGFrZSBjYXJlIG9mIHRoaXM/DQo+ID4gPiBnZXRfdGltZXNwZWM2NCB1c2Vz
IGNvcHlfZnJvbV91c2VyLCBpcyAgdGhlcmUgYW55IHNpZGUgZWZmZWN0Pw0KPiA+IA0KPiA+IFll
cyBhbmQgeWVzLiBJIGFscmVhZHkgbm90aWNlZCBpdCBidXQgZGlkIG5vdCBzZW5kIG91dCB2MiBk
dWUgdG8gc29tZQ0KPiA+IG90aGVyIHRoaXMgSSBoYXZlIHRvIGFkZHJlc3MgZmlyc3QuIFN0aWxs
IHRyeWluZyB0byBmaW5kIGEgd2F5IHRoYXQNCj4gPiBhbGxvd3MgdXMgdG8gcHJldmVudCBkdXBs
aWNhdGlvbiBhbGwgdGhlIG5lY2Vzc2FyeSBoZWxwZXJzLi4uDQo+IA0KPiBPciB3ZSBkb24ndCB1
c2UgaGVscGVycywgbGlrZSB0aGlzDQo+IHN0cnVjdCBfX2tlcm5lbF90aW1lc3BlYyBrdHM7DQo+
IHN0cnVjdCB0aW1lc3BlYzY0IHRzNjQ7DQo+IA0KPiBjb2JhbHRfY29weV9mcm9tX3VzZXIoJmt0
cywgdV90cywgc2l6ZW9mKGt0cykpOw0KPiANCj4gdHM2NC50dl9zZWMgPSBrdHMudHZfc2VjOw0K
PiANCj4gaSdtIHdvcmtpbmcgb24gY2xvY2suYywgYW5kIHdpbGwgc3VibWl0IHBhdGNoZXMsIHBs
ZWFzZSByZXZpZXcuDQoNClRoaXMgaXMgbm90IGNvcnJlY3QgaW4gY2FzZSBvZiBhIGNvbXBhdCBz
eXNjYWxsLiBXZSBoYXZlIGRpZmZlcmVudA0KcGFkZGluZyBiZXR3ZWVuIGtlcm5lbCBhbmQgYXBw
bGljYXRpb24gd2hpY2ggbmVlZHMgdG8gYmUgYWRkcmVzc2VkLg0KVGhhdCBjYW4gYmUgZG9uZSBu
aWNlbHkgaW4gYSBoZWxwZXIgd2hpY2ggY2FuIGNoZWNrIHRoZSBjb250ZXh0IGl0IGlzDQpiZWlu
ZyBjYWxsZWQgaW4uIChTZWUgZ2V0X3RpbWVzcGVjNjQoKSBvZiBhIGtlcm5lbCB0aGF0IGhhcyBp
dCkNCg0KQXMgeW91IHBvaW50ZWQgb3V0IHdlIGNhbiBub3QgdXNlIGdldF90aW1lc3BlYzY0KCkg
YXMgaXMsIHdlIG5lZWQgYQ0KY29iYWx0IHZlcnNpb24gb2YgaXQuDQoNClBsZWFzZSB3YWl0IGZv
ciB2MiwgeW91IHdpbGwgc2VlLi4uDQoNCg0KPiANCg==

