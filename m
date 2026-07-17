Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279A41EB1AA
	for <xenomai@lists.linux.dev>; Fri, 17 Jul 2026 02:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784255955; cv=none; b=MmjZuQ1jAIXvn2CCCeFM1LNOUfO2eVz4vayUZDK6s2/lZXZ+SBDoj9k0Wipn/hR7FjuPDpbQYePT4lKwB9Pd84dEMjbxmeKf8P/zwzGqqO54fV1qNnekd9eWWyg30ofIq4HGDnk82XQsvfEJNp3hURCSmBRWYqM+H0es0GVvpMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784255955; c=relaxed/simple;
	bh=jVDZAWE/X9vbW9oyrWm8FMcocMvED9XQOeQzw1pvKBY=;
	h=Date:From:To:Cc:Subject:Content-Type:MIME-Version:Message-ID; b=kCfReFWJS+ISGdEn6Nxyy21YKaKhig40YFSRbsoHGuysGmiPBp+RshbA+p1ldZeHousl9TuA+ntoSBELLs8ccRoYvFFF1kWxIkur/EoYkxG8hB+fW88cf14mQoXYmoZ0Emq2ueIhcMMCqe3Tyk2n1Z399o7i/DRXtkch7uUz9PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Xq1f2fzp; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Xq1f2fzp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=jVDZAWE/X9vbW9oyrWm8FMcocMvED9XQOeQzw1pvKBY=; b=X
	q1f2fzpJZMY4nYwU0GpjWK/k5lGk0Jon+WChsFH0ziq7d8kIPlahrkH5rZCTKicv
	2lCt9uVqd1kcIPHARctn8p1XVcCLx1hnR2Og8k4mprxwpFavBvxKdzsXSKyzw2AM
	cGIIIpPjMTuprqYJCw1T38bTVyMnf+oKpsvd00Ross=
Received: from powertree$163.com ( [219.142.137.151] ) by
 ajax-webmail-wmsvr-40-103 (Coremail) ; Fri, 17 Jul 2026 10:39:05 +0800
 (CST)
Date: Fri, 17 Jul 2026 10:39:05 +0800 (CST)
From: linz <powertree@163.com>
To: "Florian Bezdeka" <florian.bezdeka@siemens.com>
Cc: "Philippe Gerum" <rpm@xenomai.org>,
	"jan.kiszka@siemens.com" <jan.kiszka@siemens.com>,
	"xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: [PATCH v3] irqchip: gic-v3-its: irq_pipeline: Fix OOB context
 in-band lock warning for ITS lock
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260511(2e539873) Copyright (c) 2002-2026 www.mailtech.cn 163com
X-NTES-SC: AL_Qu2TBv6eukEv4yWebOkckk8bhes9Wsa4s/ki3YBXc+wEvTvB0wwYV058F2Xa6tyOKQ2cnTKOezdX0cl7UJZHt9l4LWJmdD25Tm9i4MSL5A==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Message-ID: <30686e71.2228.19f6df11b6e.Coremail.powertree@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:ZygvCgD3953JlVlq6gogAA--.16148W
X-CM-SenderInfo: psrzv2pwuhvqqrwthudrp/xtbC7QmIHmpZlcm4wAAA3l
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

ClRoZSB3YXJuaW5nIHNob3duIGJlbG93IGNvdWxkIGJlIG9ic2VydmVkIG9uIGRvdmV0YWlsIDYu
NiB3aXRoIGFybTY0CmFyY2hpdGVjdHVyZSB3aGVuIENPTkZJR19ERUJVR19JUlFfUElQRUxJTkUg
aXMgZW5hYmxlZC4KClRoZSByZWFzb24gaXMgdGhlIHVzYWdlIG9mIGEgcmF3X3NwaW5sb2NrX3Qg
aW4gaGFyZCBJUlEgbWFza2luZyBjb2RlCnBhdGguIEEgbWlncmF0aW9uIHRvIGhhcmRfc3Bpbmxv
Y2tfdCBmaXhlcyB0aGlzIGlzc3VlLgoKW8KgIMKgIDEuNTEwOTAzXSBJUlEgcGlwZWxpbmU6IHNv
bWUgY29kZSBydW5uaW5nIGluIG9vYiBjb250ZXh0ICdYZW5vbWFpJwrCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGNhbGxlZCBhbiBpbi1iYW5kIG9ubHkgcm91dGlu
ZQpbwqAgwqAgMS41MTA5MTJdIENQVTogMCBQSUQ6IDAgQ29tbTogc3dhcHBlci8wIFRhaW50ZWQ6
IEcgU8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgNi42LjYzLWRvdmV0YWlsMiAjOApbwqAgwqAg
MS41MTA5MThdIEhhcmR3YXJlIG5hbWU6IFBlMjIwNCBERU1PIEREUjQgKERUKQpbwqAgwqAgMS41
MTA5MjBdIElSUSBzdGFnZTogWGVub21haQpbwqAgwqAgMS41MTA5MjNdIENhbGwgdHJhY2U6ClvC
oCDCoCAxLjUxMDkyNl3CoCBkdW1wX2JhY2t0cmFjZSsweDkwLzB4ZTQKW8KgIMKgIDEuNTEwOTQw
XcKgIHNob3dfc3RhY2srMHgxNC8weDFjClvCoCDCoCAxLjUxMDk0Nl3CoCBkdW1wX3N0YWNrX2x2
bCsweDg0LzB4YzgKW8KgIMKgIDEuNTEwOTUzXcKgIGR1bXBfc3RhY2srMHgxNC8weDFjClvCoCDC
oCAxLjUxMDk1N13CoCBjaGVja19pbmJhbmRfc3RhZ2UrMHhiMC8weGM4ClvCoCDCoCAxLjUxMDk2
NV3CoCBpbmJhbmRfaXJxX3NhdmUrMHhjLzB4MjgKW8KgIMKgIDEuNTEwOTcxXcKgIF9yYXdfc3Bp
bl9sb2NrX2lycXNhdmUrMHgxNC8weDkwClvCoCDCoCAxLjUxMDk3N13CoCBpdHNfc2VuZF9zaW5n
bGVfY29tbWFuZCsweDI0LzB4MTU0ClvCoCDCoCAxLjUxMDk4NF3CoCBscGlfdXBkYXRlX2NvbmZp
ZysweDljLzB4MTQ0ClvCoCDCoCAxLjUxMDk5MF3CoCBpdHNfbWFza19pcnErMHgyYy8weDY0ClvC
oCDCoCAxLjUxMDk5N13CoCBpcnFfY2hpcF9tYXNrX3BhcmVudCsweDE4LzB4MjAKW8KgIMKgIDEu
NTExMDA1XcKgIGl0c19tYXNrX21zaV9pcnErMHgxYy8weDI4ClvCoCDCoCAxLjUxMTAxMl3CoCBo
YW5kbGVfZmFzdGVvaV9pcnErMHgxY2MvMHgyYjQKW8KgIMKgIDEuNTExMDE2XcKgIGdlbmVyaWNf
cGlwZWxpbmVfaXJxX2Rlc2MrMHg2Yy8weGE0ClvCoCDCoCAxLjUxMTAyMV3CoCBnZW5lcmljX2hh
bmRsZV9kb21haW5faXJxKzB4MTgvMHgyMApbwqAgwqAgMS41MTEwMjhdwqAgZ2ljX2hhbmRsZV9p
cnErMHg0Yy8weDEyMApbwqAgwqAgMS41MTEwMzJdwqAgaGFuZGxlX2lycV9waXBlbGluZWQrMHg0
MC8weDY0ClvCoCDCoCAxLjUxMTAzOF3CoCBjYWxsX29uX2lycV9zdGFjaysweDI0LzB4MzAKW8Kg
IMKgIDEuNTExMDQ0XcKgIGRvX2ludGVycnVwdF9oYW5kbGVyKzB4MTM4LzB4MTU4ClvCoCDCoCAx
LjUxMTA1MF3CoCBlbDFfaW50ZXJydXB0KzB4NDAvMHgxMTAKW8KgIMKgIDEuNTExMDU1XcKgIGVs
MWhfNjRfaXJxX2hhbmRsZXIrMHgxNC8weDFjClvCoCDCoCAxLjUxMTA2MV3CoCBlbDFoXzY0X2ly
cSsweDY0LzB4NjgKW8KgIMKgIDEuNTExMDY0XcKgIGRlZmF1bHRfaWRsZV9jYWxsKzB4MzAvMHg3
OApbwqAgwqAgMS41MTEwNzFdwqAgZG9faWRsZSsweDEyOC8weDE1MApbwqAgwqAgMS41MTEwNzdd
wqAgY3B1X3N0YXJ0dXBfZW50cnkrMHgzNC8weDM4ClvCoCDCoCAxLjUxMTA4MV3CoCBrZXJuZWxf
aW5pdCsweDAvMHgxZDQKW8KgIMKgIDEuNTExMDg4XcKgIGFyY2hfcG9zdF9hY3BpX3N1YnN5c19p
bml0KzB4MC8weDgKW8KgIMKgIDEuNTExMDk2XcKgIHN0YXJ0X2tlcm5lbCsweDUwNC8weDVjYwpb
wqAgwqAgMS41MTExMDNdwqAgX19wcmltYXJ5X3N3aXRjaGVkKzB4YmMvMHhjNAoKU2lnbmVkLW9m
Zi1ieTogemhhbmdsaW4gPHBvd2VydHJlZUAxNjMuY29tPgotLS0KIGRyaXZlcnMvaXJxY2hpcC9p
cnEtZ2ljLXYzLWl0cy5jIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAx
IGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9pcnFjaGlwL2lycS1naWMtdjMtaXRz
LmMgYi9kcml2ZXJzL2lycWNoaXAvaXJxLWdpYy12My1pdHMuYwppbmRleCAwZTU3NzM1ZWFjLi4z
ZjJiMDJiOGY0IDEwMDY0NAotLS0gYS9kcml2ZXJzL2lycWNoaXAvaXJxLWdpYy12My1pdHMuYwor
KysgYi9kcml2ZXJzL2lycWNoaXAvaXJxLWdpYy12My1pdHMuYwpAQCAtOTQsNyArOTQsNyBAQCBz
dHJ1Y3QgaXRzX2RldmljZTsKICAqIGxpc3QuCiAgKi8KIHN0cnVjdCBpdHNfbm9kZSB7Ci0JcmF3
X3NwaW5sb2NrX3QJCWxvY2s7CisJaGFyZF9zcGlubG9ja190CQlsb2NrOwogCXN0cnVjdCBtdXRl
eAkJZGV2X2FsbG9jX2xvY2s7CiAJc3RydWN0IGxpc3RfaGVhZAllbnRyeTsKIAl2b2lkIF9faW9t
ZW0JCSpiYXNlOwotLSAKMi4zNC4xCgo=
