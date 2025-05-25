Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E8891DACB1
	for <xenomai@lists.linux.dev>; Sun, 25 May 2025 13:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748179746; cv=none; b=MKHbdzHv7VxEbAqq4wgVKTzfp8Va2R5lDXbzc2CpBsnltOg+sfw/ZmgwgQC1mEBgFsVHjUhm8DWyIVplpF5oX4T1Ch0hSpJstEb3+8s4uS4PvL0e9sIngKVe5HBaPDnPKI+OsEat9kSvpX1B7Gsa7gruNRS0dP1qHhNLo8+BPdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748179746; c=relaxed/simple;
	bh=IpHVVstP3cXnaslolEyKrs/c54Rf6mHJ3fcvhzFmXSU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=EKgSeW3oTUsAY+AImU2d0NEVXXikL1Ky+Kiq0bBpIXvXkrhw4RQLOWF4XEAacxFXTZm29MaKM+w/M85hqSZiepEdKyTeBmJWG03e0PRSxQ+UiJ2du/7Aq/Dfa/Z4Ens5ZNsh2Mg5sBicBGha46UyIHjCv5JsD7iGo4EVMXwkNSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=XlF+wLIw; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="XlF+wLIw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=IpHVVstP3cXnaslolEyKrs/c54Rf6mHJ3fcvhzFmXSU=; b=X
	lF+wLIw4S1UJciGg9VQbE6aYdUA7/dY9xqSme07//8f+3bQTh4PMuBS6BrqN49rD
	cy42SgQZ4kUKCzq/sllj51//owmFFhZ5YqaCJtR5Fi2G065lPi3gQUbavlPJYLTb
	uFB/eHsy0t/h+b2OuKsiqt0HIbcyCR0xPlf+mpuq0E=
Received: from aspirestro$163.com ( [120.244.221.195] ) by
 ajax-webmail-wmsvr-40-115 (Coremail) ; Sun, 25 May 2025 21:28:55 +0800
 (CST)
Date: Sun, 25 May 2025 21:28:55 +0800 (CST)
From: "Haiyang He" <aspirestro@163.com>
To: "Florian Bezdeka" <florian.bezdeka@siemens.com>
Cc: jan.kiszka@siemens.com, xenomai@lists.linux.dev
Subject: Re:Re: [PATCH] scripts/wrap-link.sh: Add support for -h|-help
 option
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20240801(9da12a7b)
 Copyright (c) 2002-2025 www.mailtech.cn 163com
In-Reply-To: <12ce1549fe564a2225490b7e2f10f8151fb2f790.camel@siemens.com>
References: <20250525080648.353288-1-aspirestro@163.com>
 <12ce1549fe564a2225490b7e2f10f8151fb2f790.camel@siemens.com>
X-NTES-SC: AL_Qu2fCv2ctk8o4yKeYulS/zNL9LNGI5rF+b5VqfQ0XPw9mADC4xwnYVxHDHjP6Nz82UxiuxHDqhKz5g15qB93
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Message-ID: <991f7ec.2380.19707a1d2e6.Coremail.aspirestro@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:cygvCgD3XwUYGzNo8ogMAA--.61441W
X-CM-SenderInfo: pdvsx2xhvw20i6rwjhhfrp/1tbiXA9YcWgy4E+NAAADsB
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

QXQgMjAyNS0wNS0yNSAxNzo1MTozMiwgIkZsb3JpYW4gQmV6ZGVrYSIgPGZsb3JpYW4uYmV6ZGVr
YUBzaWVtZW5zLmNvbT4gd3JvdGU6Cj5PbiBTdW4sIDIwMjUtMDUtMjUgYXQgMTY6MDYgKzA4MDAs
IEhhaXlhbmcgSGUgd3JvdGU6Cj4+IEZvbGxvd2luZyB0aGUgcG9ydGluZy1wb3NpeCB0aXAsIGFk
ZCBzdXBwb3J0IGZvciAtaHwtaGVscCBvcHRpb24uCj4KPkkgdGhpbmsgdGhlIGxvbmcgb3B0aW9u
IHNob3VsZCBiZSAtLWhlbHAgKGluc3RlYWQgb2YgLWhlbHApLgo+CldlbGwsIGl0IHNob3VsZCB1
c3VhbGx5IGJlIC0taGVscC4gCkknbSBqdXN0IGtlZXBpbmcgaXQgY29uc2lzdGVudCB3aXRoIHRo
ZSBwb3J0aW5nLXBvc2l4IHRpcCB3ZWJwYWdlLgpJZiB0aGUgY29udGVudCBvZiB3ZWJwYWdlIGNv
dWxkIGNoYW5nZSwgSSBwcmVmZXIgdG8gb25seSBhZGQgLWggb3B0aW9uLgoKSGFpeWFuZy4KPj4g
Cj4+IFRpcDogaHR0cHM6Ly92My54ZW5vbWFpLm9yZy90aXBzL3BvcnRpbmctcG9zaXgvCj4+IAo+
PiBTaWduZWQtb2ZmLWJ5OiBIYWl5YW5nIEhlIDxhc3BpcmVzdHJvQDE2My5jb20+Cj4+IC0tLQo+
PiAgc2NyaXB0cy93cmFwLWxpbmsuc2ggfCA2ICsrKysrKwo+PiAgMSBmaWxlIGNoYW5nZWQsIDYg
aW5zZXJ0aW9ucygrKQo+PiAKPj4gZGlmZiAtLWdpdCBhL3NjcmlwdHMvd3JhcC1saW5rLnNoIGIv
c2NyaXB0cy93cmFwLWxpbmsuc2gKPj4gaW5kZXggZmE4M2JkNWUyLi4yMWM2ODg1YTIgMTAwNzU1
Cj4+IC0tLSBhL3NjcmlwdHMvd3JhcC1saW5rLnNoCj4+ICsrKyBiL3NjcmlwdHMvd3JhcC1saW5r
LnNoCj4+IEBAIC0xNyw2ICsxNyw3IEBAIE9wdGlvbnM6Cj4+ICAtcSBiZSBxdWlldAo+PiAgLXYg
YmUgdmVyYm9zZSAocHJpbnQgZWFjaCBjb21tYW5kIGJlZm9yZSBydW5uaW5nIGl0KQo+PiAgLW4g
ZHJ5IHJ1biAocHJpbnQgYWxsIGNvbW1hbmRzIGJ1dCBkb24ndCBydW4gYW55KQo+PiArLWgsIC1o
ZWxwIHNob3cgdGhpcyBoZWxwIG1lc3NhZ2UgYW5kIGV4aXQKPj4gIAo+PiAgRXhhbXBsZToKPj4g
ICQxIC12IGdjYyAtbyBmb28gZm9vLm8gLVdsLEAvdXNyL3hlbm9tYWkvbGliL2NvYmFsdC53cmFw
cGVycyAtTC91c3IveGVub21haS9saWIgLWxjb2JhbHQgLWxtb2RlY2hrIC1scHRocmVhZCAtbHJ0
Cj4+IEBAIC04NSw2ICs4NiwxMSBAQCB3aGlsZSB0ZXN0ICQjIC1ndCAwOyBkbwo+PiAgCSAgICBk
cnlydW49ImVjaG8gIyAiCj4+ICAJICAgIDs7Cj4+ICAKPj4gKwktaHwtaGVscCkKPj4gKwkgICAg
dXNhZ2UgIiRwcm9nbmFtZSIKPj4gKwkgICAgZXhpdCAwCj4+ICsJICAgIDs7Cj4+ICsKPj4gIAkt
KikKPj4gIAkgICAgY2M9IiRjYyAkYXJnIgo+PiAgCSAgICA7Owo+PiAtLSAKPj4gMi4zNC4xCj4K

