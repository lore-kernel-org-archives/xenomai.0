Received: from de-s03-gw1.mail.cloud.nospamproxy.com (de-s03-gw1.mail.cloud.nospamproxy.com [193.37.132.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D1F23BD14
	for <xenomai@lists.linux.dev>; Wed,  9 Jul 2025 08:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=193.37.132.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752051418; cv=pass; b=DP60+QkLc7/g77DT7Ecph4qpTGcpSAhCu0XUIHCZP5kEddmwbD7kikmm1RKmh0km36LlYmnYslCNAaEW67sXIrHtkJsKpflyh125QP8mYmsprHt/q4ubdsyussf7WSAf1HdQFZqLAYDLhN5CgIvtBxEU8HQcpJu13kTNWtGq8C4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752051418; c=relaxed/simple;
	bh=4yxd4JMUewfdJdgJwg4IUQN5YoqXendzsfASKT/uHRI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ttufchMQ6jkcoUMnmb35/fG968bqtzMyvgf7F7sx1GmM3KRlhhPjbmUU3Y10PUFEmHraoy1P6FvBvvxybY3V5jNOYKDJmeLGoUBolYaHrdgcsIY7RFTTfH4eLIBsUT0H7R7lfe0fAINHOPd/QkKDvR5zT2eSHz6tlHTCltxEcr4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baumueller.com; spf=pass smtp.mailfrom=baumueller.com; dkim=permerror (0-bit key) header.d=baumueller.com header.i=@baumueller.com header.b=qgN5+DTj; dkim=pass (1024-bit key) header.d=baumueller.com header.i=@baumueller.com header.b=gT67XLN+; arc=pass smtp.client-ip=193.37.132.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baumueller.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baumueller.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=baumueller.com header.i=@baumueller.com header.b="qgN5+DTj";
	dkim=pass (1024-bit key) header.d=baumueller.com header.i=@baumueller.com header.b="gT67XLN+"
ARC-Seal: i=1; cv=none; a=rsa-sha256; t=1752051411; d=cloud.nospamproxy.com; 
 s=arc-s03-250709061604r; b=
 KgIugO9qt+AtDnvBL2I4XDvgBkuJEnSr7P6o0Ah6ayaX1fmit31mIaqo3hFsQTmZFjFHf0ISxIFY4gtglVITq+lwj5CQreYDC6LTyRIIMXbw1dW31qBsB0H5N1nJriRa8mfbs1QjtIjdtUMZrd27dxG2/3dWLxzQJkV3vX+Js4Q=
ARC-Message-Signature: i=1; c=relaxed/relaxed; d=cloud.nospamproxy.com; 
 s=arc-s03-250709061604r; t=1752051411; 
 bh=4yxd4JMUewfdJdgJwg4IUQN5YoqXendzsfASKT/uHRI=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id; 
 a=rsa-sha256; b=
 0MYTpoQHrS2gbyTsXQvGNKtf45dhrp6adLR0zz/vXa+RqdKIAH7ETWwoV7rANhvCc4S+m1gSw9xFTfKp1RcGs1faAg9fT3JgYiHaE1RAhYQsiZuWye76maE5FFBWbGQ8tykIsvpfyTZia9vzlPUvbpKroqkuTdB3aoSkv7QKrDA=
ARC-Authentication-Results: i=1; cloud.nospamproxy.com;spf=Pass
 smtp.mailfrom=Peter.Steub@baumueller.com
 smtp.helo=nospam.baumueller.com;dmarc=Pass header.from=baumueller.com
DKIM-Signature: v=1; c=relaxed/relaxed; d=baumueller.com; s=dkim1e; 
 t=1752051411; bh=4yxd4JMUewfdJdgJwg4IUQN5YoqXendzsfASKT/uHRI=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id; 
 a=ed25519-sha256; b=
 qgN5+DTjpSNZqSjOL8UcPFljYNQ/k0A0DkbSdgWGwa23flqSBpvqxEi6Yorhl4KP8XwpkUcJgJCBhPKYNvrRCQ==
DKIM-Signature: v=1; c=relaxed/relaxed; d=baumueller.com; s=dkim1r; 
 t=1752051411; bh=4yxd4JMUewfdJdgJwg4IUQN5YoqXendzsfASKT/uHRI=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id; 
 a=rsa-sha256; b=
 gT67XLN+Ea3XsqwuG8MxOCWCCHh9jGIhGHd1IUsOJjR8YUIR39YxlVA7piEFf6Wb819lrQaYJE2Ovvm6dP5MGFCCrnGHIDYVVqYKAWOV674vj8lVIEq3nWp2UGrlpKGCH8e7UoU3djipScoX1AKLyEPREEpBNeCwGBc8gtrjn/4=
From: "Steub, Peter" <Peter.Steub@baumueller.com>
To: Philippe Gerum <rpm@xenomai.org>
CC: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: AW: [EVL_XENOMAI-4] libevl and __USE_TIME_BITS64 on 32bit ARMv7
Thread-Topic: [EVL_XENOMAI-4] libevl and __USE_TIME_BITS64 on 32bit ARMv7
Thread-Index: AdvwpuKBls/PuQ6OSi2Dqmr4+DVZYgABJMEkAAA+Z9A=
Date: Wed, 9 Jul 2025 08:56:51 +0000
Message-ID: <9778eb48b6f94d0a92b613eb19a2426d@baumueller.com>
References: <e5963e4cef7d473baf4a039d8eac49b1@baumueller.com>
 <87o6ttn4yd.fsf@xenomai.org>
In-Reply-To: <87o6ttn4yd.fsf@xenomai.org>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

PiAtLS0tLVVyc3Byw7xuZ2xpY2hlIE5hY2hyaWNodC0tLS0tDQo+IFZvbjogUGhpbGlwcGUgR2Vy
dW0gPHJwbUB4ZW5vbWFpLm9yZz4NCj4gR2VzZW5kZXQ6IE1pdHR3b2NoLCA5LiBKdWxpIDIwMjUg
MTA6MjgNCj4gQW46IFN0ZXViLCBQZXRlciA8UGV0ZXIuU3RldWJAYmF1bXVlbGxlci5jb20+DQo+
IENjOiB4ZW5vbWFpQGxpc3RzLmxpbnV4LmRldg0KPiBCZXRyZWZmOiBSZTogW0VWTF9YRU5PTUFJ
LTRdIGxpYmV2bCBhbmQgX19VU0VfVElNRV9CSVRTNjQgb24gMzJiaXQNCj4gQVJNdjcNCj4gDQo+
ICJTdGV1YiwgUGV0ZXIiIDxQZXRlci5TdGV1YkBiYXVtdWVsbGVyLmNvbT4gd3JpdGVzOg0KPiAN
Cj4gPiBJIGp1c3QgcmVhbGl6ZWQsIHRoYXQgbXkgYXBwbGljYXRpb24gaXMgdXNpbmcgMzJiaXQg
dGltZSB2YWx1ZXMsIHdoaWNoIGlzIG5vdA0KPiB3aGF0IEkgd2FudCBhbmQgbmVlZC4gU28gSSBh
ZGRlZCAiIC1EX1RJTUVfQklUUz02NCAtDQo+IERfRklMRV9PRkZTRVRfQklUUz02NCIgdG8gbXkg
dG9vbGNoYWluLiBOb3cgdGhlIGV2bCBhcGkgaXMgbm90IHdvcmtpbmcNCj4gYW55bW9yZS4gQWxs
IGZ1bmN0aW9ucyB3aXRoICJ0aW1lc3BlYyIgbGlrZSAiZXZsX3JlYWRfY2xvY2soKSIgZmFpbCBz
aW5jZQ0KPiAidGltZXNwZWMiIGhhcyBjaGFuZ2VkIGZyb20gMzJiaXQgc2Vjb25kcyB0byA2NGJp
dCBzZWNvbmRzLg0KPiA+DQo+ID4gV2hhdCBpcyB0aGUgcmlnaHQgd2F5IHRvIGZpeCB0aGlzLCBJ
IGd1ZXNzIEkgbmVlZCB0byBidWlsZCBsaWJldmwgd2l0aCA2NGJpdCB0aW1lDQo+IHZhbHVlcyBi
dXQgSSBkaWQgbm90IGZpbmQgaG93IHRvIGRvIGl0IHJpZ2h0Lg0KPiA+DQo+ID4gRXZsIChSNTEp
IGlzIGNyb3NzIGJ1aWxkIHRocm91Z2ggYSBZb2N0byBidWlsZC4NCj4gPg0KPiA+IFRoYW5rIHlv
dS4NCj4gPg0KPiA+IE1pdCBmcmV1bmRsaWNoZW4gR3LDvMOfZW4gLyBraW5kIHJlZ2FyZHMNCj4g
Pg0KPiANCj4gU2luY2UgWW9jdG8gNC4zIG5hbmJpZWxkLCA2NGJpdCB0aW1lIGFuZCBsYXJnZWZp
bGUgc3VwcG9ydCBhcmUgYXV0b21hdGljYWxseQ0KPiBlbmFibGVkIGZvciAzMmJpdCBhcmNoaXRl
Y3R1cmVzIHN1Y2ggYXMgYXJtdjcuIEknbSBidWlsZGluZyBsaWJldmwgZnJvbSBZb2N0bw0KPiBz
dHloZWFkIEFUTSwgd2l0aCBzaXplb2Yoc3RydWN0IHRpbWVzcGVjKSA9PQ0KPiAxNiBhcyBvYnNl
cnZlZCBieSBsaWJldmwsIGFzIGV4cGVjdGVkLiBUaGVyZSBpcyBubyBzcGVjaWZpYyB0dW5pbmcg
bmVlZGVkIGJ5DQo+IGxpYmV2bCByZWdhcmRpbmcgdGhpcywgaWYgdGhlIHRvb2xjaGFpbiBidWls
ZGluZyBpdCBkb2VzIHRoZSByaWdodCB0aGluZy4NCj4gDQo+IFdoaWNoIFlvY3RvIHJlbGVhc2Ug
YXJlIHlvdSB1c2luZz8NCj4gDQo+IC0tDQo+IFBoaWxpcHBlLg0KDQpIbW0gSSBhbSBvbiA0LjAg
KGtpcmtzdG9uZSksIHNvIEkgcHJvYmFibHkgc2hvdWxkIGp1c3QgYnVpbGQgbGliZXZsIHdpdGgg
NjRiaXQgdGltZSBhbmQgbGFyZ2UgZmlsZSBzdXBwb3J0LCBJIGRvIG5vdCB3YW50IHRvIGJyZWFr
IHNvbWUgcmFuZG9tIHBhY2thZ2UuIA0KQ2FuIHlvdSB0ZWxsIG1lIHdoYXQgdG8gc2V0IGluIHRo
ZSBsaWJldmwgcmVjaXBlIHRvIGJ1aWxkIGl0IHdpdGggNjRiaXQgdGltZSB2YWx1ZSBhbmQgbGFy
Z2UgZmlsZSBzdXBwb3J0Pw0KDQpUaGFuayB5b3UuDQoNCk1pdCBmcmV1bmRsaWNoZW4gR3LDvMOf
ZW4gLyBraW5kIHJlZ2FyZHMNCg0KaS4gQS4gUGV0ZXIgU3RldWINCg==

