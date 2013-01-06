Message-ID: <50E995EB.8040300@web.de>
Date: Sun, 06 Jan 2013 16:19:07 +0100
From: Jan Kiszka <jan.kiszka@web.de>
MIME-Version: 1.0
References: <50E47751.1070005@siemens.com>
	<50E59112.6080005@siemens.com>	<50E94E72.5050309@xenomai.org>
	<50E95812.8050503@web.de> <50E959EC.8030306@web.de>
	<50E98242.30104@xenomai.org> <50E98849.5050903@web.de>
	<50E9897E.2000106@xenomai.org> <50E98E62.7090907@web.de>
	<50E993B7.9070201@xenomai.org> <50E99430.5000700@web.de>
	<50E9951E.4030809@xenomai.org>
In-Reply-To: <50E9951E.4030809@xenomai.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Subject: Re: [Xenomai] [PATCH v3] nucleus: Convert intrlock to a sleeping
 Linux lock
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "Mauerer, Wolfgang" <wolfgang.mauerer@siemens.com>, Xenomai <xenomai@xenomai.org>

T24gMjAxMy0wMS0wNiAxNjoxNSwgR2lsbGVzIENoYW50ZXBlcmRyaXggd3JvdGU6Cj4gT24gMDEv
MDYvMjAxMyAwNDoxMSBQTSwgSmFuIEtpc3prYSB3cm90ZToKPiAKPj4gT24gMjAxMy0wMS0wNiAx
NjowOSwgR2lsbGVzIENoYW50ZXBlcmRyaXggd3JvdGU6Cj4+Pj4gSWYgeW91IHByZWZlciB0byBz
a2lwIHRoZSB3YXJuaW5nIGluIGlwaXBlLCB0aGVuIEkgd2lsbCBzZW5kIGEKPj4+PiBjb3JyZXNw
b25kaW5nIHBhdGNoLiBUaGUgbG9jayBjb252ZXJzaW9uIGlzIHN0aWxsIG5lY2Vzc2FyeSBmb3Ig
Zm9yZ2UsCj4+Pj4gdGhvdWdoLgo+Pj4KPj4+Cj4+PiBUaGVyZSBhcmUgb3RoZXIgd2F5cyBhcm91
bmQsIGlwaXBlX3ZpcnR1YWxpemVfaXJxIGlzIGFscmVhZHkgYSB3cmFwcGVyCj4+PiB1c2VkIG9u
bHkgYnkgMi42LCBzbyB3ZSBjYW4gYWRkIHNvbWUgY29kZSBoZXJlLiBTbywgd2UgY2FuIG9ubHkg
Y2hlY2sKPj4+IGlwaXBlX3Jvb3RfcCBoZXJlLCBhbmQgZGlzYWJsZSB0aGUgd2FybmluZyBpbiBp
cGlwZV9yZXF1ZXN0X2lycS4KPj4KPj4gRXJyLCB3ZSByYXRoZXIgbmVlZCB1bmNoZWNrZWQgX19p
cGlwZV9yZXF1ZXN0X2lycSwgY2FsbGVkIGJ5Cj4+IGlwaXBlX3JlcXVlc3RfaXJxIGFmdGVyIHRl
c3RpbmcgdGhlIGNvbnRleHQgYW5kIGJ5IGlwaXBlX3ZpcnR1YWxpemVfaXJxCj4+IHdpdGhvdXQg
dGhhdCB0ZXN0Lgo+IAo+IAo+IGlwaXBlX3Jvb3Rfb25seSBkb2VzIHR3byB0ZXN0cywgaXQgdGVz
dHMgd2hldGhlciB0aGUgY3VycmVudCBkb21haW4gaXMKPiByb290LCBhbmQgd2hldGhlciByb290
IGlzIHN0YWxsZWQuIFRoZSBwcm9ibGVtLCBhcyBmYXIgYXMgSSB1bmRlcnN0b29kLAo+IGNvbWUg
ZnJvbSB0aGUgc2Vjb25kIHRlc3QsIHdoYXQgSSBtZWFuIGlzIHRoYXQgd2UgY2FuIGFycmFuZ2Ug
dG8ga2VlcAo+IHRoZSBmaXJzdCB0ZXN0IGZvciBpcGlwZV92aXJ0dWFsaXplX2lycS4KCldlbGws
IGlmIHdlIGRpc2FsbG93IG5vbi1yb290IGludm9jYXRpb25zIG9mIGlwaXBlX3ZpcnR1YWxpemVf
aXJxLCB0aGVuCndlIGNhbiBhbHNvIGNvbnZlcnQgdGhlIGxvY2sgdG8gYSBMaW51eCB2ZXJzaW9u
LiBJIHRob3VnaHQgeW91ciBjb25jZXJucwphcmUgcmVsYXRlZCB0byByZXN0cmljdGluZyB0aGUg
dXNhZ2Ugb2YgdGhhdCBzZXJ2aWNlcyAob3Igc2VydmljZXMgdGhhdApjYWxsIGl0KSBpbiBzdGFi
bGUgMi42LgoKSmFuCgoKLS0tLS0tLS0tLS0tLS0gbmV4dCBwYXJ0IC0tLS0tLS0tLS0tLS0tCkEg
bm9uLXRleHQgYXR0YWNobWVudCB3YXMgc2NydWJiZWQuLi4KTmFtZTogc2lnbmF0dXJlLmFzYwpU
eXBlOiBhcHBsaWNhdGlvbi9wZ3Atc2lnbmF0dXJlClNpemU6IDI2MSBieXRlcwpEZXNjOiBPcGVu
UEdQIGRpZ2l0YWwgc2lnbmF0dXJlClVSTDogPGh0dHA6Ly93d3cueGVub21haS5vcmcvcGlwZXJt
YWlsL3hlbm9tYWkvYXR0YWNobWVudHMvMjAxMzAxMDYvYjZiMGQ0N2UvYXR0YWNobWVudC5wZ3A+
Cg==
