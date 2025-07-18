Received: from mail.sprinte.eu (mail.sprinte.eu [141.95.128.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E01C292B30
	for <xenomai@lists.linux.dev>; Fri, 18 Jul 2025 08:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.95.128.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752828303; cv=none; b=Z5i5iPnPfWqy1Dtq+zurls4Qf6qZHkT+8nZOOugMkyR3LZ5foU0bMf8L5kSJyaujY0uo+J7uPamP1pI9fSYcfS11MBMfSESPEZuC/3sXKfEQfFu3bX0+5q7xt6wOu+WQiYpjM5CK5qdemqNaPanqed8vXPoQUtPYBbqYu42zRw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752828303; c=relaxed/simple;
	bh=GlhAupLlbI2cA7eWbPVHGWLEGyvJKvJrFXfPf1ZdMIY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YKd38TYupFFfGvKX03QMxTdTThR4mOOEMzSFt7h4ktJRo9qwq+0czdh1hmT24yh1HZhAttp2rrUGqI5++ztwm1WM5QmxVug5ab/n7jazo8xppXt5Ba+qIxSp7n9vasTNgsjCt02YyrsSAw/B3Nzagdnw1btJfCC+7wmoVAlPn4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sprinte.eu; spf=pass smtp.mailfrom=sprinte.eu; dkim=pass (2048-bit key) header.d=sprinte.eu header.i=@sprinte.eu header.b=WAXASb93; arc=none smtp.client-ip=141.95.128.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sprinte.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sprinte.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sprinte.eu header.i=@sprinte.eu header.b="WAXASb93"
Received: from S1044812.EX793143.lan (2001:41d0:11b:2f00::8d5f:80ce) by
 S1044812.EX793143.lan (2001:41d0:11b:2f00::8d5f:80ce) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 18 Jul 2025 10:39:49 +0200
Received: from S1044812.EX793143.lan ([fe80::90d1:6ba3:6aa1:fae0]) by
 S1044812.EX793143.lan ([fe80::90d1:6ba3:6aa1:fae0%6]) with mapi id
 15.02.1748.010; Fri, 18 Jul 2025 10:39:49 +0200
From: Julien Blanc <julien.blanc@sprinte.eu>
To: "mincheol1.shin@doosan.com" <mincheol1.shin@doosan.com>
CC: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Re: POSIX Socket API and RT IPC Connection
Thread-Topic: POSIX Socket API and RT IPC Connection
Thread-Index: Adv28qj5u0Pzfu1pT6ud35XBHNnM5P//9yAA//7lFfCAApv8AA==
Date: Fri, 18 Jul 2025 08:39:48 +0000
Message-ID: <186a1a422d175d6b763db2799b2101c425302ac2.camel@sprinte.eu>
References: <PU4P216MB1353E1FD6D6652A5884282F5A951A@PU4P216MB1353.KORP216.PROD.OUTLOOK.COM>
	 <5513cf39ddfa8b279a79edb2328da5bd35c4f10b.camel@sprinte.eu>
	 <PU4P216MB13539AEEC96AF61832AB4DE3A950A@PU4P216MB1353.KORP216.PROD.OUTLOOK.COM>
In-Reply-To: <PU4P216MB13539AEEC96AF61832AB4DE3A950A@PU4P216MB1353.KORP216.PROD.OUTLOOK.COM>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <349A487D549E564798E5C4A1F3241494@EX793143.lan>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; d=sprinte.eu; s=ovhex803668-selector1;
 c=relaxed/relaxed; t=1752827989; h=from:to:subject:date;
 bh=GlhAupLlbI2cA7eWbPVHGWLEGyvJKvJrFXfPf1ZdMIY=;
 b=WAXASb93br3CkYvVtajcOMMu4vtqDD+1ZsQwHFssgm+wPa+dj7dRnW1h/TPMU3RHgGhAHvNhlagRDj6M9HeQASfsPXrPsscJV8+8WIbXHiioiomWkvwrzTVtcdO3lp3ekgBI4hhcU/rV3F2q/8+ENzBgOc2vR/0XBwroUH9OnD3yO03GlyMc0kJa84S/vRbamMSRLRIV57HYTUYddnaAQOnTI81ivJCID258XQANeR4yBTY6mb2bhI5hJh5MF5iZLzlZYZDuSJYIMVNQbEYeq+l9qhJZEloeJVOt6wzIn59xWrYG4vuHTaSKkLV1cFb0d65SnJficegJ722jd4OjPg==

Q0MtaW5nIHRoZSBsaXN0LCBiZWNhdXNlIG90aGVycyBtYXkgZ2l2ZXMgbW9yZSBwcmVjaXNlIGFu
c3dlcnMuDQoNCkxlIHZlbmRyZWRpIDE4IGp1aWxsZXQgMjAyNSDDoCAwMDo0MCArMDAwMCwg7Iug
66+87LKgKE1pbmNoZW9sIFNoaW4pIOyEoOyehCDrkZDsgrDroZzrs7Tti7HsiqQgYSDDqWNyaXTC
oDoNCj4gDQo+IElmIGEgdGhyZWFkIGlzIGltcGxlbWVudGVkIGFzIGFuIFJUIHRhc2sgYnV0IHVz
ZXMgdGhlIHN0YW5kYXJkIHNvY2tldCBBUEksIGRvZXMgbGVhdmluZyB0aGUgUlQgZG9tYWluIG9u
bHkgYWZmZWN0IHJlYWwtdGltZQ0KPiBwZXJmb3JtYW5jZT/CoA0KDQpBZmFpayBpdCBkb2VzLiBJ
J20gbm90IGF3YXJlIG9mIG90aGVyIGlzc3Vlcy4gSnVzdCBiZSBjYXJlZnVsIG5vdCB0byBob2xk
IGFueSB4ZW5vbWFpIHJlc291cmNlIHdoZW4geW91IG1pZ3JhdGUsIGJlY2F1c2UgdGhhdCB3aWxs
DQphZmZlY3QgYW55IG90aGVyIHhlbm9tYWkgdGhyZWFkIHRoYXQgdXNlcyB0aGVtIGZvciBzeW5j
aHJvbml6YXRpb24gKGVnIHdhaXRpbmcgb24gYSBtdXRleCkuDQoNCj4gT3IgY291bGQgaXQgYWxz
byBwb3RlbnRpYWxseSBjYXVzZSBpc3N1ZXMgc3VjaCBhcyB0cmlnZ2VyaW5nIHRoZSB3YXRjaGRv
ZyBvciBmcmVlemluZyBwaGVub21lbmEgZHVlIHRvIHRoZSBsb3NzIG9mIHJlYWwtdGltZQ0KPiBn
dWFyYW50ZWVzPw0KDQpVc3VhbGx5IGl0J3MgdGhlIG90aGVyIHdheS4gVHJpZ2dlcmluZyB0aGUg
d2F0Y2hkb2cgb3IgZnJlZXppbmcgaXMgY2F1c2VkIGJ5IGEgcnQgdGhyZWFkIHRha2luZyBhbGwg
Y3B1IHRpbWUg4oCTIHVubGVzcyBvZiBjb3Vyc2UNCnlvdSBjbGVhciB0aGUgd2F0Y2hkb2cgaW4g
dGhpcyBzcGVjaWZpYyB0aHJlYWQsIGFuZCBpdCBpcyBpZGxlZCBmb3IgdG9vIGxvbmcsIGJ1dCB0
aGF0IHdvdWxkIG1lYW4gdGhlIGlzc3VlIGlzIGVsc2V3aGVyZS4NCk1pZ3JhdGluZyB0byB0aGUg
bGludXggZG9tYWluIHdpbGwgbWVhbnMgaXQgd2lsbCBiZSBoYW5kbGVkIGJ5IHRoZSBsaW51eCBr
ZXJuZWwgc2NoZWR1bGVyLCB3aGljaCBpcyB1c3VhbGx5IHByZWVtcHRpdmUgYW5kIHJvdW5kLQ0K
cm9iaW4sIHdoaWNoIGFjdHVhbGx5IHRyaWVzIHRvIHByZXZlbnQgZnJlZXplcy4NCg0KPiBJbiBz
dWNoIGNhc2VzLCB3b3VsZCBpdCBiZSBiZXR0ZXIgcHJhY3RpY2UgdG8gaW1wbGVtZW50IHRoZSB0
aHJlYWQgZW50aXJlbHkgYXMgYSBQT1NJWCB0aHJlYWQgaW5zdGVhZCBvZiBhbiBSVCB0aHJlYWQ/
DQoNClNDSEVEX1dFQUsgaXMgcHJvYmFibHkgd2hhdCB5b3Ugd2FudCBmb3IgdGhvc2UgdGhyZWFk
cy4gTWFraW5nIHRoZW0gY29tcGxldGVseSBvdXRzaWRlIHhlbm9tYWkgZG9tYWluIHdpbGwgY2F1
c2Ugc3luY2hyb25pemF0aW9uDQp3aXRoIHhlbm9tYWkgdGhyZWFkcyB0byBiZSBtdWNoIG1vcmUg
cGFpbmZ1bC4NCg0KDQpCZXN0IHJlZ2FyZHMsDQoNCkp1bGllbg0K
