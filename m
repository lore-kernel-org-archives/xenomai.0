Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69642C11FE
	for <xenomai@lists.linux.dev>; Tue, 14 Jul 2026 03:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784000599; cv=none; b=eXAHiGag56g5rP3xfWs+dFdbPYI9AGlJw8yHhW5SBsSqcqM/p/UenT3Z0Z3aTnFG46UQI/H4AUkTptEaDNnbzY7oeqdTXFtd3c7mjnJwc3oDPnlDUT6wEV87pr06DoViQ7n98Axmb1F15Uf3xU0BUZ+pP2uYZ2i5hzjYVea/T0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784000599; c=relaxed/simple;
	bh=lzh6sKwQOM7ypeY1xYcmi7qhh615NZjmbiS0CCzGQVc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=gyLnFGbWn90kv5e6kZl07XTCchKXq9ODcOFm208RUreQWsQQlL7ICziZtJL4dl79AGoKs3HKeoXIVQIoKiQIxz/L0bQXhJ+DU30YI0HVRZ0B0cJgAxzu98tfQKVfrj633R0tDwCycAmkoL0mYbVmBp18conubrdYH7OMNZXegQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=HTng/52B; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="HTng/52B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=lzh6sKwQOM7ypeY1xYcmi7qhh615NZjmbiS0CCzGQVc=; b=H
	Tng/52Bxv+p1yWDpMmKzuRtK5AIY8SnSzvPw/OmFwEZeM9AW20xPDtj43I7JhD4u
	Az14hS1Uk1gcfRPUHS/2XD7LUNk2YWG/TWNY9pMwFFtUqc7c9Uru8rhhDenQGVH0
	fGNRABH0nrQdkW0/8UGoXdprRuftLaiqHQiJMf+niU=
Received: from powertree$163.com ( [219.142.137.151] ) by
 ajax-webmail-wmsvr-40-103 (Coremail) ; Tue, 14 Jul 2026 11:43:09 +0800
 (CST)
Date: Tue, 14 Jul 2026 11:43:09 +0800 (CST)
From: linz  <powertree@163.com>
To: "Florian Bezdeka" <florian.bezdeka@siemens.com>
Cc: "Philippe Gerum" <rpm@xenomai.org>,
	"jan.kiszka@siemens.com" <jan.kiszka@siemens.com>,
	xenomai@lists.linux.dev
Subject: [PATCH v2] irqchip: gic-v3-its: irq_pipeline: Fix OOB context
 in-band lock warning for ITS lock
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260511(2e539873) Copyright (c) 2002-2026 www.mailtech.cn 163com
In-Reply-To: <6ca12451-a015-4b54-9e22-0256e97d834e@siemens.com>
References: <517534d7.8863.19efe1f45f1.Coremail.powertree@163.com>
 <ad8e6855-2d67-49a4-9a52-9819b93b1802@siemens.com>
 <023fa6882b563713cbcc06bd954c8e9db4200d73.camel@siemens.com>
 <c017bc0.9041.19f5afdb56f.Coremail.powertree@163.com>
 <6ca12451-a015-4b54-9e22-0256e97d834e@siemens.com>
X-NTES-SC: AL_Qu2TBvybv00j7yWYYukckk8bhes9Wsa4s/ki3YBXc+wEvTvB0wwYV058F2Xa6tyOKQ2cnTKOezdX0cl7UJZHatXAUS5KqONkyYlIms219g==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Message-ID: <55bf6b7f.363a.19f5eb8aece.Coremail.powertree@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:ZygvCgD3t2ZNsFVqPqgdAA--.11318W
X-CM-SenderInfo: psrzv2pwuhvqqrwthudrp/xtbC7g0vxGpVsE0u8QAA3V
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

VGhhbmsgeW91IGZvciB5b3VyIGZlZWRiYWNrCgpVbmRlciA2LjYuNjMtZG92ZXRhaWwyIGVudmly
b25tZW50LCByYXdfc3BpbmxvY2tfdCBmb3IgdGhlIElUUyBub2RlIGxvY2sgdHJpZ2dlcnMgb3V0
4oCRb2bigJFiYW5kIGNvbnRleHQgd2FybmluZyBpbiBpcnHigJFwaXBlbGluZSBjb2RlLgpBcyBz
dWdnZXN0ZWQgYnkgRmxvcmlhbiwgaHlicmlkX3NwaW5sb2NrX3Qgc2hvdWxkIGJlIGxpbWl0ZWQg
dG8gc3RydWN0IGlycV9kZXNjIGFuZCBpcnFjaGlwIGludGVybmFscy4gSVRTIG5vZGUgbG9jayBp
cyBtb3JlIHN1aXRhYmxlIHRvIHVzZSBoYXJkX3NwaW5sb2NrX3QuCgpBZnRlciByZXBsYWNpbmcg
cmF3X3NwaW5sb2NrX3Qgd2l0aCBoYXJkX3NwaW5sb2NrX3QsIHRoZSBjYWxs4oCRdHJhY2Ugd2Fy
bmluZyBkaXNhcHBlYXJzIGFuZCBzeXN0ZW0gcnVucyBzdGFibHkuCgpJbiBhZGRpdGlvbiwgdGhl
IGdpY+KAkXYzIGlycWNoaXAgYWxyZWFkeSBoYXMgSVJRQ0hJUF9QSVBFTElORV9TQUZFIGZsYWcs
IHdoaWxlIGl0c19pcnFfY2hpcCBsYWNrcyB0aGlzIGZsYWcuCkVuYWJsaW5nIElSUUNISVBfUElQ
RUxJTkVfU0FGRSBmb3IgaXRzX2lycV9jaGlwIGhhcyBubyBlZmZlY3QgdG8gcmVzb2x2ZSB0aGUg
d2FybmluZy4KClNpZ25lZC1vZmYtYnk6IHpoYW5nbGluIDxwb3dlcnRyZWVAMTYzLmNvbT4KLS0t
CiBkcml2ZXJzL2lycWNoaXAvaXJxLWdpYy12My1pdHMuYyB8IDIgKy0KIDEgZmlsZSBjaGFuZ2Vk
LCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvaXJx
Y2hpcC9pcnEtZ2ljLXYzLWl0cy5jIGIvZHJpdmVycy9pcnFjaGlwL2lycS1naWMtdjMtaXRzLmMK
aW5kZXggMGU1NzczNWVhYy4uM2YyYjAyYjhmNCAxMDA2NDQKLS0tIGEvZHJpdmVycy9pcnFjaGlw
L2lycS1naWMtdjMtaXRzLmMKKysrIGIvZHJpdmVycy9pcnFjaGlwL2lycS1naWMtdjMtaXRzLmMK
QEAgLTk0LDcgKzk0LDcgQEAgc3RydWN0IGl0c19kZXZpY2U7CiAgKiBsaXN0LgogICovCiBzdHJ1
Y3QgaXRzX25vZGUgewotCXJhd19zcGlubG9ja190CQlsb2NrOworCWhhcmRfc3BpbmxvY2tfdAkJ
bG9jazsKIAlzdHJ1Y3QgbXV0ZXgJCWRldl9hbGxvY19sb2NrOwogCXN0cnVjdCBsaXN0X2hlYWQJ
ZW50cnk7CiAJdm9pZCBfX2lvbWVtCQkqYmFzZTsKLS0gCjIuMzQuMQ==
