Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA7B29E10F
	for <xenomai@lists.linux.dev>; Mon, 13 Jul 2026 10:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783939360; cv=none; b=ZHGEuC771CQvqAzKkXcE4jpAxMs30J3vt0nLe/DtX0dtYjtGO7k5xRbSitdUBKRqkuyopc/tcwuh4WJqkieiGJsTYWSknTN62QONzHkJqXj13xkw2IA3Si84PpVxELp7cWZd1t2zM2xzTn/e4MEnnnFLZelsxvfRgbVEjMg5zCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783939360; c=relaxed/simple;
	bh=0KOgoa9/N25s/fqjz+1v0kahy7ziJf1x+odLFOH8q34=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=uzvi9h8OFSHH9Sh8Mhhb+/Yq18cI759vej4QxSRAANELT+SxHnNsbUmVqzmGtmmj0VvQJwP462sGwe8j2V6/ulG5Qmyvo8BAW+jf1Y0Wbbcg+VTe6T6h2j1aJg988bqf++yjV/qFPjJAzC0OzbdIs5877AaB44CZtTWY/LAbP+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=WGSCuKxa; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="WGSCuKxa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=0KOgoa9/N25s/fqjz+1v0kahy7ziJf1x+odLFOH8q34=; b=W
	GSCuKxaWO3JElMHYjriCr7e/Jgstog1Qe2A5//in3TQpLLDZeIX9KxRoxBcGSITM
	q9rbqt8gsR3ggb913ycBOtH5VxvJlP5dJLaM6bF51R0HnjpHsERYVc4KhGljuxje
	EQHJwhbsg/6bh33zllvbnmPNzYy1TvIr3teWpiDk/A=
Received: from powertree$163.com ( [219.142.137.151] ) by
 ajax-webmail-wmsvr-40-103 (Coremail) ; Mon, 13 Jul 2026 18:42:33 +0800
 (CST)
Date: Mon, 13 Jul 2026 18:42:33 +0800 (CST)
From: linz  <powertree@163.com>
To: "Jan Kiszka" <jan.kiszka@siemens.com>
Cc: "Florian Bezdeka" <florian.bezdeka@siemens.com>,
	"Philippe Gerum" <rpm@xenomai.org>, xenomai@lists.linux.dev
Subject: [PATCH v2] irqchip: gic-v3-its: irq_pipeline: fix OOB context
 in-band lock warning for ITS lock using hard spinlocks instead of hybrid
 spinlocks
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260511(2e539873) Copyright (c) 2002-2026 www.mailtech.cn 163com
In-Reply-To: <6ca12451-a015-4b54-9e22-0256e97d834e@siemens.com>
References: <517534d7.8863.19efe1f45f1.Coremail.powertree@163.com>
 <ad8e6855-2d67-49a4-9a52-9819b93b1802@siemens.com>
 <023fa6882b563713cbcc06bd954c8e9db4200d73.camel@siemens.com>
 <c017bc0.9041.19f5afdb56f.Coremail.powertree@163.com>
 <6ca12451-a015-4b54-9e22-0256e97d834e@siemens.com>
X-NTES-SC: AL_Qu2TAfWYtksu5SSebekckk8bhes9Wsa4s/ki3YBXc+wEvTvB0wwYV058F2Xa6tyOKQ2cnTKOezdX0cl7UJZHGYU2jPMWs61xNuvnAj9eUA==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Message-ID: <581e35af.92dd.19f5b124b8a.Coremail.powertree@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:ZygvCgDXn7QZwVRq4kMdAA--.10053W
X-CM-SenderInfo: psrzv2pwuhvqqrwthudrp/xtbCxhkmu2pUwRnFOwAA3a
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

VGhhbmsgeW91IGZvciB5b3VyIGZlZWRiYWNrCgoKVGhlIGdpYy12MyBJUlEgY2hpcCBpcyBhbHJl
YWR5IG1hcmtlZCB3aXRoIElSUUNISVBfUElQRUxJTkVfU0FGRS7CoFRoZSBpdHNfaXJxX2NoaXAg
aXMgbm90IG1hcmtlZCB3aXRoIElSUUNISVBfUElQRUxJTkVfU0FGRS4gSSBhZGRlZCB0aGUgZmxh
ZyBhbmQgdGVzdGVkLCBidXQgaXQgZGlkIG5vdCBoYXZlIGFueSBlZmZlY3QuCgpNZWFud2hpbGUs
IEkgcmVhZCB0aGUgY29kZSByZWxhdGVkIHRvIElSUUNISVBfUElQRUxJTkVfU0FGRS4gSWYgdGhl
IGdpYy12MyBJUlEgY2hpcCBpcyBub3QgbWFya2VkIHdpdGggSVJRQ0hJUF9QSVBFTElORV9TQUZF
LCBhIGNhbGwgdHJhY2UgbGlrZSB0aGUgZm9sbG93aW5nIHdvdWxkIGJlIHJlcG9ydGVkOgpNU0kg
ZG9tYWluIGlycWNoaXAgWFhYIGlzIG5vdCBwaXBlbGluZS1zYWZlISBvciBpcnFjaGlwIFhYWCBp
cyBub3QgcGlwZWxpbmUtc2FmZSEKSG93ZXZlciwgSSBkaWQgbm90IHNlZSBhbnkgc3VjaCBtZXNz
YWdlIGluIG15IGxvZ3MuCgpCYXNlZCBvbiBGbG9yaWFuJ3Mgc3VnZ2VzdGlvbiwgSSByZXZpc2l0
ZWQgdGhlIFhlbm9tYWkgNCBkb2N1bWVudGF0aW9uIHJlZ2FyZGluZyBoeWJyaWRfc3BpbmxvY2tf
dCBhbmQgaGFyZF9zcGlubG9ja190LsKgCkkgYWdyZWUgd2l0aCBGbG9yaWFuJ3MgcG9pbnQgdGhh
dCBoeWJyaWRfc3BpbmxvY2tfdCBzaG91bGQgYmUgbGltaXRlZCB0byBzdHJ1Y3QgaXJxX2Rlc2Mg
YW5kIElSUSBjaGlwcywgYW5kIHRoYXQgaGFyZF9zcGlubG9ja190IGlzIG1vcmUgYXBwcm9wcmlh
dGUgZm9yIHRoZSBJVFMgbm9kZSBsb2NrLgoKSSBjaGFuZ2VkIHRoZSBsb2NrIHRvIGhhcmRfc3Bp
bmxvY2tfdCBhbmQgdGVzdGVkIGl0LiBUaGUgY2FsbCB0cmFjZSBubyBsb25nZXIgYXBwZWFycyBh
bmQgdGhlIHN5c3RlbSB3b3JrcyBmaW5lLgoKVGhlIHBhdGNoIGlzIGFzIGZvbGxvd3MuIFBsZWFz
ZSBoZWxwIHJldmlldyBpdDoKCkZyb20gZTBjYmM5MzE2YWYzMzFiZjAwN2M4NmUxZmNhYjBlZjg2
OTliMDVjOSBNb24gU2VwIDE3IDAwOjAwOjAwIDIwMDEKRnJvbTogemhhbmdsaW4xMDQwIDxwb3dl
cnRyZWVAMTYzLmNvbT4KRGF0ZTogTW9uLCAxMyBKdWwgMjAyNiAxNzo1Mzo0NCArMDgwMApTdWJq
ZWN0OiBbUEFUQ0hdIGlycWNoaXA6IGdpYy12My1pdHM6IGlycV9waXBlbGluZTogZml4IE9PQiBj
b250ZXh0IGluLWJhbmQKwqBsb2NrIHdhcm5pbmcgZm9yIElUUyBsb2NrIHVzaW5nIGhhcmQgc3Bp
bmxvY2tzIGluc3RlYWQgb2YgaHlicmlkIHNwaW5sb2NrcwoKLS0tCsKgZHJpdmVycy9pcnFjaGlw
L2lycS1naWMtdjMtaXRzLmMgfCAyICstCsKgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCsp
LCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9pcnFjaGlwL2lycS1naWMtdjMt
aXRzLmMgYi9kcml2ZXJzL2lycWNoaXAvaXJxLWdpYy12My1pdHMuYwppbmRleCAwZTU3NzM1ZWFj
Li4zZjJiMDJiOGY0IDEwMDY0NAotLS0gYS9kcml2ZXJzL2lycWNoaXAvaXJxLWdpYy12My1pdHMu
YworKysgYi9kcml2ZXJzL2lycWNoaXAvaXJxLWdpYy12My1pdHMuYwpAQCAtOTQsNyArOTQsNyBA
QCBzdHJ1Y3QgaXRzX2RldmljZTsKwqAgKiBsaXN0LgrCoCAqLwrCoHN0cnVjdCBpdHNfbm9kZSB7
Ci3CoCDCoCByYXdfc3BpbmxvY2tfdMKgIMKgIMKgIMKgIGxvY2s7CivCoCDCoCBoYXJkX3NwaW5s
b2NrX3TCoCDCoCDCoCDCoCBsb2NrOwrCoCDCoCDCoHN0cnVjdCBtdXRleMKgIMKgIMKgIMKgIGRl
dl9hbGxvY19sb2NrOwrCoCDCoCDCoHN0cnVjdCBsaXN0X2hlYWTCoCDCoCBlbnRyeTsKwqAgwqAg
wqB2b2lkIF9faW9tZW3CoCDCoCDCoCDCoCAqYmFzZTsKLS3CoAoyLjM0LjE=
