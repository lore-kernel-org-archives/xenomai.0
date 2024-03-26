Received: from mail.sprinte.eu (mail.sprinte.eu [141.95.128.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6410C1B960
	for <xenomai@lists.linux.dev>; Tue, 26 Mar 2024 09:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.95.128.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711446699; cv=none; b=Wo0yQnDaFVHj5yaE83Grm9baN0J6oQWMrioTKgzADyzkyREfMTuP9V8LufhGxnk/jSBH0tjIG1fdgb1RbP7xw+r3Y98F6bxOTtwOyqDNCh3NDgmY7Um0ZhN6GvI2wUkw99vAw+T10gbt62AZpE0p4/rKqgIYp301aP94AD8M+yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711446699; c=relaxed/simple;
	bh=jGF97S2IxjyHaq5sQU5030xNkrX86duFOiaHIN5reC4=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lSlc/7tcSBvTNYkdx2UWUKDVqdFmux/K1MnqGAdgxB3eQr7nFHyUeq07jtxAiwHQl543FVnChct36LugkRJly79/qrXPlTNOO+Z95X7uR7NDvSH54DH0rbKGFBNSRPIsetAP3n1z5Gx7UOn8HpFx0L03je6ncHtrF2ccyG9/qS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sprinte.eu; spf=pass smtp.mailfrom=sprinte.eu; dkim=pass (2048-bit key) header.d=sprinte.eu header.i=@sprinte.eu header.b=shVFmk6I; arc=none smtp.client-ip=141.95.128.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sprinte.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sprinte.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sprinte.eu header.i=@sprinte.eu header.b="shVFmk6I"
Received: from S1044812.EX793143.lan (2001:41d0:11b:2f00::8d5f:80ce) by
 S1044812.EX793143.lan (2001:41d0:11b:2f00::8d5f:80ce) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 26 Mar 2024 10:46:25 +0100
Received: from S1044812.EX793143.lan ([fe80::90d1:6ba3:6aa1:fae0]) by
 S1044812.EX793143.lan ([fe80::90d1:6ba3:6aa1:fae0%6]) with mapi id
 15.02.1544.009; Tue, 26 Mar 2024 10:46:25 +0100
From: Julien Blanc <julien.blanc@sprinte.eu>
To: "ruiqurm@gmail.com" <ruiqurm@gmail.com>, "xenomai@lists.linux.dev"
	<xenomai@lists.linux.dev>
Subject: Re: Issue with std::mutex when porting POSIX program to Xenomai 3
Thread-Topic: Issue with std::mutex when porting POSIX program to Xenomai 3
Thread-Index: AQHaf13iQgHYOIIxfUSpkjGBcU538bFJtW+A
Date: Tue, 26 Mar 2024 09:46:25 +0000
Message-ID: <2783a56721258c8b0661fceb4589c8119c00fb96.camel@sprinte.eu>
References: <TYZPR04MB642556FC09A8013E8B51B9FDAA352@TYZPR04MB6425.apcprd04.prod.outlook.com>
In-Reply-To: <TYZPR04MB642556FC09A8013E8B51B9FDAA352@TYZPR04MB6425.apcprd04.prod.outlook.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <A59AAC9A36FBCC46829B9B1EF6DFE525@EX793143.lan>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; d=sprinte.eu; s=ovhex803668-selector1;
 c=relaxed/relaxed; t=1711446386; h=from:to:subject:date;
 bh=jGF97S2IxjyHaq5sQU5030xNkrX86duFOiaHIN5reC4=;
 b=shVFmk6IVIbyaMxiW524pP5Nv9FL29RVf6ckzfUm3p3B1kLfpQbGjkk9L4Ovg+pPEbh2WXnX1cuS2Fy/GtlWIgI7GzKX7Irol8rp76Siu+W78Q6EmlFiaaXhuWuRY3tOr8e1p3+hBrkTK06kSdEBZc6qnK9fWQnrnZeEoWet5lualQDmzxnXlJth2v8vtSKYiApPhwnYfos68qvUuBat+C9DohXcnkVygnuFIXyx+tBedB7Kd4YDGHO07nOPhURBs9Rxqa25iNzXcuU3L6WCktRVsRS0jlJbhKW4bKC/iRN/t33ToK81fV12m6ZJQIRkmp2A54QjJTU/VjCmemDQ7w==

TGUgbWFyZGkgMjYgbWFycyAyMDI0IMOgIDA5OjEzICswMDAwLCBTYW0gQ2hpdSBhIMOpY3JpdMKg
Og0KPiBEZWFyIFhlbm9tYWkgQ29tbXVuaXR5LA0KPiANCj4gDQo+IFNvIG1heWJlIEkgc2hvdWxk
IGNvbnNpZGVyIHJlcGxhY2luZyBzdGQ6Om11dGV4wqB3aXRoIHB0aHJlYWRfbXV0ZXguwqAgSG93
ZXZlciwgYmVmb3JlIHByb2NlZWRpbmcsIEkgd291bGQgbGlrZSB0byBpbnF1aXJlIGlmDQo+IHRo
ZXJlIGFyZSBiZXR0ZXINCj4gwqBhcHByb2FjaGVzIG9yIHNvbHV0aW9ucyBmb3IgcG9ydGluZyBQ
T1NJWCBDKysgcHJvZ3JhbXMgdGhhdCB1dGlsaXplIHN0ZDo6bXV0ZXguDQoNCnN0ZDo6bXV0ZXgg
aXMgbm90IHBvc2l4LCBpdCdzIEMrKy4gV2hldGhlciBvciBub3QgaXQgd2lsbCBtYWtlIHBvc2l4
IGNhbGxzLCBhbmQgd2hpY2ggY2FsbHMgaXQgd2lsbCBtYWtlLCBpcyBjb21wbGV0ZWx5IHVwIHRv
IHlvdXINCmxpYmMrKyBpbXBsZW1lbnRhdGlvbi4NCg0KSWYgeW91IHBsYW4gb24gdXNpbmcgc3Rk
Ojp4eCBjYWxscyBmcm9tIHhlbm9tYWkgdGhyZWFkcywgaXQgd2lsbCB1c3VhbGx5IG5vdCB3b3Jr
OiB5b3Ugd291bGQgbmVlZCBhIHhlbm9tYWktY29tcGF0aWJsZSBsaWJjKyssIGFuZA0KaSdtIG5v
dCBhd2FyZSBvZiBhbnkuIFNvbWUgY2FsbHMgbWlnaHQgaGFwcGVuIHRvIHdvcmssIHNvbWUgd29u
J3QsIGFuZCB0aGVyZSBpcyBqdXN0IG5vIGd1YXJhbnRlZSB0aGF0IGEgbGliIHVwZGF0ZSB3aWxs
IG5vdCBicmVhaw0KdGhpbmdzLiBJZiB5b3UgcGxhbiBvbiB1c2luZyBzdGQ6Onh4IGNhbGxzIGZy
b20gcmVndWxhciBsaW51eCB0aHJlYWRzLCBpbnNpZGUgYSB4ZW5vbWFpIGFwcGxpY2F0aW9uLCB5
b3Ugd2lsbCBuZWVkIHRvIGRpc2FibGUNCmNvYmFsdCB3cmFwcGVycy4NCg0KVGhlIHdheSB3ZSBz
b2x2ZWQgdGhpcyBpcyBieSBpbXBsZW1lbnRpbmcgb3VyIG93biB4ZW5vbWFpOjptdXRleCwgd2hp
Y2ggcmVzZW1ibGVzIHN0ZCdzIG9uZSwgYW5kIHVzZXMgd3JhcHBlZCBwdGhyZWFkX211dGV4X3h4
DQpjYWxscy4gVGhpcyBhbHNvIGFsbG93cyB1cyB0byBjb21waWxlIHRvIHJlZ3VsYXIgcG9zaXgs
IGZvciB0ZXN0IHB1cnBvc2VzLg0KDQpSZWdhcmRzLA0KDQpKdWxpZW4NCg==
