Received: from redirect.mail.gandi.net (relay13.mail.gandi.net [217.70.178.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E90202996
	for <xenomai@lists.linux.dev>; Thu, 17 Jul 2025 09:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752745304; cv=none; b=WCY74AnQk74hmNeSKe3rcxSJZ2lw3C+qqdyB8v1UVxla853DVwn8b0n/Jnid+sUjOE1OBSt5bcmYwI8/n6rtqAsN3Cmdbqe4rlxXqKg/ngkg+7gDf+wKeO6mr2FjtmRM0OslC3f0crE6fgsCL9TC7dRxGEyuNYv2fMpJD0eoIiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752745304; c=relaxed/simple;
	bh=O3nUNi6tl8UodLDrVRuifF2P4lLuTognNwEWNwgLQVk=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gf3YdXs07PpRCNWsgMG26ZY/EfUChENOGvQvzysNLmQo5H5gnwyW5UCWKaVldr1yylpawHhCgdTeOc9GxLjDehUJh+2T3LJcJnx8FlyKRGfiJoYVMh3SzcDziZ3xj8d/yIuKKPeBMOz0H3yN7Nh2e/A44+YYa+INYIs9GiH/dOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sprinte.eu; spf=pass smtp.mailfrom=redirect.mail.gandi.net; dkim=pass (2048-bit key) header.d=sprinte.eu header.i=@sprinte.eu header.b=UkeskBh7; arc=none smtp.client-ip=217.70.178.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sprinte.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sprinte.eu header.i=@sprinte.eu header.b="UkeskBh7"
Received: from spool.mail.gandi.net (spool2.mail.gandi.net [217.70.178.211])
	by relay13.mail.gandi.net (Postfix) with ESMTPS id E55BF41CBC
	for <xenomai@lists.linux.dev>; Thu, 17 Jul 2025 09:41:38 +0000 (UTC)
Received: from mail.sprinte.eu (mail.sprinte.eu [141.95.128.206])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 5784C74003A
	for <xenomai@xenomai.org>; Thu, 17 Jul 2025 09:41:38 +0000 (UTC)
Received: from S1044812.EX793143.lan (2001:41d0:11b:2f00::8d5f:80ce) by
 S1044812.EX793143.lan (2001:41d0:11b:2f00::8d5f:80ce) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Thu, 17 Jul 2025 11:41:37 +0200
Received: from S1044812.EX793143.lan ([fe80::90d1:6ba3:6aa1:fae0]) by
 S1044812.EX793143.lan ([fe80::90d1:6ba3:6aa1:fae0%6]) with mapi id
 15.02.1748.010; Thu, 17 Jul 2025 11:41:37 +0200
From: Julien Blanc <julien.blanc@sprinte.eu>
To: "mincheol1.shin@doosan.com" <mincheol1.shin@doosan.com>,
	"xenomai@xenomai.org" <xenomai@xenomai.org>
Subject: Re: POSIX Socket API and RT IPC Connection
Thread-Topic: POSIX Socket API and RT IPC Connection
Thread-Index: Adv28qj5u0Pzfu1pT6ud35XBHNnM5P//9yAA
Date: Thu, 17 Jul 2025 09:41:37 +0000
Message-ID: <5513cf39ddfa8b279a79edb2328da5bd35c4f10b.camel@sprinte.eu>
References: <PU4P216MB1353E1FD6D6652A5884282F5A951A@PU4P216MB1353.KORP216.PROD.OUTLOOK.COM>
In-Reply-To: <PU4P216MB1353E1FD6D6652A5884282F5A951A@PU4P216MB1353.KORP216.PROD.OUTLOOK.COM>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <1162968C523D4E4ABF31B5EE69565E57@EX793143.lan>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; d=sprinte.eu; s=ovhex803668-selector1;
 c=relaxed/relaxed; t=1752745297; h=from:to:subject:date;
 bh=O3nUNi6tl8UodLDrVRuifF2P4lLuTognNwEWNwgLQVk=;
 b=UkeskBh7ltWTeAaYMpn0ruxXLaICENnlBVuyUBEBJS2/fjfPUxhpQB1A2oj33KGhXg+dTvaPs7mQxKRF5fSzii4LxnfMouGCLW/D0/SInhZHi1yEq0F4654xK8QaRCtZpaP3pGKGeD6FfZkAK2CYpNHWjt6HmOjDYmnLw5rU7Kb6CIBawiSNgJ4GMwmoHtc+4opLXNz7a3TEAIJIPIMtiGXqwRn2W2FMuIN3Q2seSJN7CeBQN2H92dGzCp/anl1N+el3/Kd0sQDToV8aHnaVDJgdIFaHuBWhU5cq7/r7R5wpZ2xcnyw/gnzJT3pO5huEtSUUOvlG+ND2Ma61K9QsIA==
X-GND-Status: LEGIT
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=sprinte.eu header.s=ovhex803668-selector1 header.b=UkeskBh7;
	spf=pass (spool.mail.gandi.net: domain of julien.blanc@sprinte.eu designates 141.95.128.206 as permitted sender) smtp.mailfrom=julien.blanc@sprinte.eu;
	dmarc=pass (policy=none) header.from=sprinte.eu
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeitddvhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvffuthffkfhfjghitgfgggesthgsredttddtjeenucfhrhhomheplfhulhhivghnuceulhgrnhgtuceojhhulhhivghnrdgslhgrnhgtsehsphhrihhnthgvrdgvuheqnecuggftrfgrthhtvghrnhepjedufeeuteegiefhgfektdekleejhfehleeiteethfeljefhveduheekkefhvdeknecukfhppedvudejrdejtddrudejkedrvdduuddpudegiedrvdegjedrledvrddujeegpddvtddtudemgeduugdtmeduudgsmedvfhdttdemmeekugehfhemkedttggvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddujedrjedtrddujeekrddvuddupdhhvghlohepshhpohholhdrmhgrihhlrdhgrghnughirdhnvghtpdhmrghilhhfrhhomhepjhhulhhivghnrdgslhgrnhgtsehsphhrihhnthgvrdgvuhdpnhgspghrtghpthhtohepuddprhgtphhtthhopeigvghnohhmrghisehlihhsthhsrdhlihhnuhigrdguvghv

TGUgamV1ZGkgMTcganVpbGxldCAyMDI1IMOgIDA4OjE5ICswMDAwLCDsi6Drr7zssqAoTWluY2hl
b2wgU2hpbikg7ISg7J6EIOuRkOyCsOuhnOuztO2LseyKpCBhIMOpY3JpdMKgOg0KPiBEZWFyIFhl
bm9tYWkgVGVhbSwNCj4gDQo+IEkgaGF2ZSBhIGZldyBxdWVzdGlvbnMgcmVnYXJkaW5nIGludGVy
LXByb2Nlc3MgY29tbXVuaWNhdGlvbiBhbmQgc29ja2V0IHVzYWdlIGluIFhlbm9tYWkgcmVhbC10
aW1lIHRhc2tzOg0KPiANCj4gVXNpbmcgVURTIFNvY2tldHMgaW4gUlQgVGFza3MNCj4gSXMgaXQg
YWNjZXB0YWJsZSB0byB1c2Ugc3RhbmRhcmQgVW5peCBEb21haW4gU29ja2V0cyAoVURTKSBmb3Ig
SVBDIGJldHdlZW4gcmVhbC10aW1lIChSVCkgdGFza3MgaW4gWGVub21haT8gQXJlIHRoZXJlIGFu
eQ0KPiBjYXZlYXRzIG9yIHJlY29tbWVuZGF0aW9ucyB5b3UgY2FuIHNoYXJlIHJlZ2FyZGluZyB0
aGlzIGFwcHJvYWNoPw0KDQpJdCB3aWxsIHdvcmsgYnV0IHRoZSBjYWxsaW5nIHRocmVhZCB3aWxs
IGxlYXZlIHRoZSBSVCBkb21haW4uIFNvIGl0IGlzIHVubGlrZXkgdG8gYmUgd2hhdCB5b3Ugd2Fu
dC4gVGhlIHdheSB3ZSBoYW5kbGUgdGhhdCBpcyBieQ0KZGVkaWNhdGluZyBhIGxvdy1wcm9yaXR5
IHRocmVhZCBmb3IgdGhhdCB3b3JrLCBvciBpbiBzb21lIGNhc2VzIGEgbGludXgtZG9tYWluIHRo
cmVhZC4NCg0KPiBTdGFuZGFyZCBTb2NrZXQgQVBJIGluIFJUIFByb2Nlc3Nlcw0KPiBJZiBJIGlt
cGxlbWVudCBhbiBSVCBwcm9jZXNzIHRoYXQgY29tbXVuaWNhdGVzIHdpdGggZXh0ZXJuYWwgZGV2
aWNlcywgaXMgaXQgc2FmZSB0byB1c2UgdGhlIHN0YW5kYXJkIHNvY2tldCBBUEk/IE9yIGFyZSB0
aGVyZQ0KPiBzcGVjaWZpYyBndWlkZWxpbmVzIG9yIGJlc3QgcHJhY3RpY2VzIGZvciBzdWNoIHNj
ZW5hcmlvcyBpbiBYZW5vbWFpPw0KDQpTYW1lIGhlcmUsIHRoZSBjYWxsaW5nIHRocmVhZCB3aWxs
IGxlYXZlIHRoZSBSVCBkb21haW4uIEFwYXJ0IGZyb20gdGhhdCwgaXQganVzdCB3b3Jrcy4NCg0K
PiBJRERQICYgWEREUCBDb21tdW5pY2F0aW9uIFNwZWNpZmljYXRpb25zDQo+IENvdWxkIHlvdSBw
bGVhc2UgcHJvdmlkZSBkZXRhaWxzIGFib3V0IHRoZSBjb21tdW5pY2F0aW9uIHNwZWNpZmljYXRp
b25zIG9mIElERFAgYW5kIFhERFA/DQo+IFNwZWNpZmljYWxseToNCj4gDQo+IEFyZSB0aGVzZSBp
bnRlcmZhY2VzIGxpbWl0ZWQgdG8gMToxIGNvbW11bmljYXRpb24sIG9yIGRvIHRoZXkgc3VwcG9y
dCBOOk4gKG1hbnktdG8tbWFueSkgY29tbXVuaWNhdGlvbiBtb2RlbHM/DQoNCklJUkMgb25seSAx
OjEsIGJ1dCB0aGF0J3MgaG93IHdlIHVzZSBpdC4gTWF5YmUgaSdtIG1pc3Npbmcgc29tZXRoaW5n
Lg0KDQo+IEFyZSB0aGVyZSBhbnkgdGVjaG5pY2FsIGxpbWl0YXRpb25zIG9yIHJlY29tbWVuZGVk
IHVzYWdlIHBhdHRlcm5zIGZvciB0aGVzZSBJUEMgbWVjaGFuaXNtcz8NCg0KT25lIGxpbWl0YXRp
b24gdGhhdCB3ZSBoaXQgaXMgdGhhdCB3aGVuIGEgcHJvY2VzcyB0ZXJtaW5hdGVzLCBhbnkgZGF0
YSB3aGljaCBoYWQgYmVlbiBidWZmZXJlZCBieSB0aGUgSVBDLCBhbmQgaGFzIG5vdCBiZWVuDQpj
b25zdW1lZCBieSB0aGUgTlJUIHNpZGUsIGlzIGxvc3QuDQoNClJlZ2FyZHMsDQoNCkp1bGllbg0K
DQo=
