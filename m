Received: from mail.sprinte.eu (mail.sprinte.eu [141.95.128.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C6B55C3C
	for <xenomai@lists.linux.dev>; Thu, 28 Mar 2024 08:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.95.128.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711614304; cv=none; b=TWicfu1ra0zXxuwf4YC72lFnUZi53PRbkOAQ33ilKNiL0PauZIq6LNDXIf1gEoQ5kAyG10KnD/VlVHEe5eED0jRW8mUm4sLBq/yVQJrQ1VWXxxh2BV67WUVtVfcjb7v8JgG/IWzu/eLm+j+T8tdKYMzSD4fRm7j2I60giBaTgt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711614304; c=relaxed/simple;
	bh=X1jFaD/b0cJdSkyE3HTrCmDS96ftHQ8KrpA7M1AEU1c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Op2hmbag1vCOQlfH7qH3xA8zUylKAjsDTdi4zUF9RSdGo7qi+CfmyDeD9sn3K6Q1YWPepTqrh3p+U90kNREKkypyEzX7EGGYgbtrjvfDrB6JtAUSaKopJztYVDH4lA8f5Oh8clntdi4+lLMW9evIzC/Rob5//fJn45GBxHQnbt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sprinte.eu; spf=pass smtp.mailfrom=sprinte.eu; dkim=pass (2048-bit key) header.d=sprinte.eu header.i=@sprinte.eu header.b=QEjXg5Dv; arc=none smtp.client-ip=141.95.128.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sprinte.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sprinte.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sprinte.eu header.i=@sprinte.eu header.b="QEjXg5Dv"
Received: from S1044812.EX793143.lan (2001:41d0:11b:2f00::8d5f:80ce) by
 S1044812.EX793143.lan (2001:41d0:11b:2f00::8d5f:80ce) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 28 Mar 2024 09:24:51 +0100
Received: from S1044812.EX793143.lan ([fe80::90d1:6ba3:6aa1:fae0]) by
 S1044812.EX793143.lan ([fe80::90d1:6ba3:6aa1:fae0%6]) with mapi id
 15.02.1544.009; Thu, 28 Mar 2024 09:24:51 +0100
From: Julien Blanc <julien.blanc@sprinte.eu>
To: "ruiqurm@gmail.com" <ruiqurm@gmail.com>
CC: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Re: Issue with std::mutex when porting POSIX program to Xenomai 3
Thread-Topic: Issue with std::mutex when porting POSIX program to Xenomai 3
Thread-Index: AQHagLb+QgHYOIIxfUSpkjGBcU538bFMwJsA
Date: Thu, 28 Mar 2024 08:24:51 +0000
Message-ID: <4ef1b2532c41d19c57a1d0c6eb15f7c8aada8eba.camel@sprinte.eu>
References: <TYZPR04MB6425188BB84FE4C65883656BAA3B2@TYZPR04MB6425.apcprd04.prod.outlook.com>
In-Reply-To: <TYZPR04MB6425188BB84FE4C65883656BAA3B2@TYZPR04MB6425.apcprd04.prod.outlook.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <3EFB71FF5AFA50498EDE4F3928EFEE25@EX793143.lan>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; d=sprinte.eu; s=ovhex803668-selector1;
 c=relaxed/relaxed; t=1711614291; h=from:to:subject:date;
 bh=X1jFaD/b0cJdSkyE3HTrCmDS96ftHQ8KrpA7M1AEU1c=;
 b=QEjXg5DvwDMS1vercvSqNKuKX9oWPATQ1qTpxBjezDGxrfjiXKrDm3fhlsGmF8zKVfvWHUwwqXjrjjukrD4eYNzHMWcH8+jNwGjDGKO+4yyWRc2meU9D1YITEraFkAEqSVD2xAR5MuRebKmp4J2rG03rSq1mLs/i4KBta6Wi42CZATD7vbIxpajDH1dTajzAYX+K7/MC+A+g7RMOKqZamSYYCiLeeARYJtjzXFe9+Yrs+BjSQoZDh6NFlLpdCpB2AEz7UCLZ3076SK1OFKERGJ1ENPZ+gUBHMvEMKpTQOzHz1dPbGd78+LhFIK+QXbzeyH6GgHiPlEWj3PaWm4pKKg==

TGUgamV1ZGkgMjggbWFycyAyMDI0IMOgIDAyOjMxICswMDAwLCBTYW0gQ2hpdSBhIMOpY3JpdMKg
Og0KPiANCj4gVGhhbmsgeW91LCBKdWxpZW4uIEkgd2lsbCBnaXZlIGl0IGEgdHJ5Lg0KPiANCj4g
QWRkaXRpb25hbGx5LCBJJ20gY3VyaW91cyBpZiwgYmVzaWRlcyB0aGUgaXNzdWUgd2l0aCB0aGUg
bXV0ZXgsIHlvdSd2ZSBlbmNvdW50ZXJlZCBhbnkgc2lnbmlmaWNhbnQgY2hhbGxlbmdlcyBkdXJp
bmcgdGhlIHByb2Nlc3MNCj4gb2YgcG9ydGluZyB5b3VyIFBPU0lYIHByb2dyYW0uIA0KDQpJdCB3
YXMgbm90IGEgcG9ydCwgdGFyZ2V0dGluZyB4ZW5vbWFpIHdhcyBhIHJlcXVpcmVtZW50IGZyb20g
dGhlIHN0YXJ0IG9mIHRoZSBwcm9qZXQsIHNvIGkgZ3Vlc3MgaXQgbWFrZXMgdGhpbmdzIGEgbG90
IGVhc2llci4gV2UNCmp1c3QgbGVhcm5lZCB0aGF0IHVzaW5nIGFueSBDKysgc3RhbmRhcmQgc3lu
Y2hyb25pemF0aW9uL3RocmVhZCBmYWNpbGl0aWVzIGlzIGEgbm8tZ28gb24geGVub21haS4gU2lu
Y2Ugd2UgYWxyZWFkeSBoYWQgc29tZQ0KaGlnaGVyLWxldmVsIGZhY2lsaXRpZXMgKHdlIGhhdmUg
c29tZSBzaGFyZWQgY29kZSB0aGF0IGFsc28gdGFyZ2V0cyBmcmVlcnRvcyB1c2luZyB0aGlzIHBs
YXRmb3JtIGFic3RyYWN0aW9uIGxheWVyKSwgaXQgd2FzIHByZXR0eQ0KZWFzeSBmb3IgdXMuDQoN
CkNvYmFsdCB3cmFwcGVycyBjYW4gYmUgdHJpY2t5IHNvbWV0aW1lcywgc28gd2UndmUgbGVhcm5l
ZCB0byB1c2UgX19SVCBvIF9fU1REIG1hY3JvcyB3aGVuIG5lZWRlZCAob3VyIGFwcHMgYXJlIG9m
dGVuIGEgbWl4ZWQgYmFnDQpvZiBSVCBhbmQgbm9uLVJUIHRocmVhZHMpLg0KDQoNClJlZ2FyZHMs
DQoNCkp1bGllbg0K
