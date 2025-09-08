Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1FEB2949E0
	for <xenomai@lists.linux.dev>; Mon,  8 Sep 2025 06:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757313737; cv=none; b=O5YIRHl6svUudkScTs2oRxCuDpzeWUpUEQLmm8B8wZO6bk9QPb3sePoi4n4FDq+g5i7qievO8/5nTAjqP4joD5ldCscU24Cp81gcuqR50GDzufFhOU9VXXM1VLTJfsGZnbtYI6h/dJhmcnh/4gbf8c3roYktjd7fJcjVn8skZLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757313737; c=relaxed/simple;
	bh=tYDzuTeweZvXOqhFhgCIW7ghd8ACBVyHA3EK3NYsnts=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=L1h6i1P7Yi0aNaPaCB9zQy2U/SykleybtEN6IaOfCjI+Hee2bpf3OWnIb/ztYte0yGlX2IE0mj9Qz6A197H0RpxFM4GXNnY4LxYbIqM9o1Dfw1wnn0WO0W2anYyr0fyyJnjF+E1u9dCdO4h2q2RU2aD9k2OfVNZu/3tTY/n81vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=TfjYs1/g; arc=none smtp.client-ip=117.135.210.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="TfjYs1/g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=tYDzuTeweZvXOqhFhgCIW7ghd8ACBVyHA3EK3NYsnts=; b=T
	fjYs1/g6aULlj+yrTLPIJCL/5pP5JvMuOel2uhl8JLwBclWuIdWYPa9xkwb+kIxV
	y7Hl4Q89gL4yUwa08Li6sZ73IkmylDo3egI+q7ESw6V0ZOD6FBGurSLFA3k+qHUS
	jKkDzxIVno8rS4k/9x/s1CoG6VEUKB9NFvYl2tygyM=
Received: from yxianyao$126.com ( [183.238.12.146] ) by
 ajax-webmail-wmsvr-41-115 (Coremail) ; Mon, 8 Sep 2025 14:42:03 +0800 (CST)
Date: Mon, 8 Sep 2025 14:42:03 +0800 (CST)
From: "Yao Yongxian" <yxianyao@126.com>
To: "Jan Kiszka" <jan.kiszka@siemens.com>
Cc: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Re:Re: Regarding the issue of rt_timer_read
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20250723(a044bf12) Copyright (c) 2002-2025 www.mailtech.cn 126com
In-Reply-To: <f293b971-906c-41e2-a966-a39b65e1e587@siemens.com>
References: <5990240f.1ddd.18c8f7bf237.Coremail.yxianyao@126.com>
 <c8491c64-f8d7-4136-8552-8ac1fb111170@siemens.com>
 <6e6d5f0a.3f41.18ce78d31f5.Coremail.yxianyao@126.com>
 <5a675ae.2fa0.19927496712.Coremail.yxianyao@126.com>
 <f293b971-906c-41e2-a966-a39b65e1e587@siemens.com>
X-NTES-SC: AL_Qu2eBf+avE8p5SecZekWmEsQju45WMW0uPwu3YZTOJs0lC7u1A08UVNFDFDuz8GWGy+wqCWZTRhj1vVecpdiYqA+UyqV2Pmhf0vNqnSZ1hqk
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Message-ID: <267d379d.51f8.199280f6d63.Coremail.yxianyao@126.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:cykvCgD3X7O8er5o7qkpAA--.4448W
X-CM-SenderInfo: p10lt0x1drqiyswou0bp/1tbiWAu9s2i3l5gXVwANsA
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

Ckhpo6wKCkF0IDIwMjUtMDktMDggMTM6Mzk6MTEsICJKYW4gS2lzemthIiA8amFuLmtpc3prYUBz
aWVtZW5zLmNvbT4gd3JvdGU6Cj5PbiAwOC4wOS4yNSAwNTowNSwgWWFvIFlvbmd4aWFuIHdyb3Rl
Ogo+PiAKPj4gSGksCj4+IAo+PiBPbiB0aGUgc2FtZSBjb21wdXRlciwgaW1tZWRpYXRlbHkgZXhl
Y3V0ZSBydF90aW1lcl9yZWFkKCkgYWZ0ZXIgcmVib290aW5nIHRoZSBtYWNoaW5lIHRvIG9idGFp
biB0aGUgdGltZToKPj4gCj4+IGEpIFdoZW4gcnVubmluZyBMaW51eCA0LjE5Ljg5ICAgKyBpcGlw
ZSAgICAgICsgWGVub21haTMuMSwgICAgIHJ0X3RpbWVyX3JlYWQoKSByZXR1cm4gODcxNTA2OTk5
MG5zCkNvcnJlY3QgOiBhKSBXaGVuIHJ1bm5pbmcgTGludXggNC4xOS44OSAgICsgaXBpcGUgICAg
ICArIFhlbm9tYWkzLjEsICAgICBydF90aW1lcl9yZWFkKCkvMTAwMCByZXR1cm4gODcxNTA2OTk5
MG5zCgo+PiBiKSBXaGVuIHJ1bm5pbmcgTGludXggNS4xMC4xOTkgKyBkb3ZldGFpbCArIFhlbm9t
YWkgMy4yLjQsIHJ0X3RpbWVyX3JlYWQoKSByZXR1cm4gICAgIDUwODc5MDI4bnMKQ29ycmVjdDog
YikgV2hlbiBydW5uaW5nIExpbnV4IDUuMTAuMTk5ICsgZG92ZXRhaWwgKyBYZW5vbWFpIDMuMi40
LCBydF90aW1lcl9yZWFkKCkvMTAwMCByZXR1cm4gICAgIDUwODc5MDI4bnMKCj4+IAo+PiBUaGUg
dGltZSByZWFkIGJ5IHJ0X3RpbWVyX3JlYWQgaXMgdGhlIHJlbGF0aXZlIHRpbWUgc2luY2UgdGhl
IHN5c3RlbSBzdGFydHVwLiBXaHkgZG9lcyBzY2VuYXJpbyBhIHJlYWQgdGltZSBhcyBsb25nIGFz
IG92ZXIgdHdvIGhvdXJzLCB3aGlsZSBzY2VuYXJpbyBiIGlzIG5vcm1hbD8KPj4gCj4KPkktcGlw
ZSB1c2VkIGl0J3Mgb3duIHRpbWViYXNlIHRoYXQgd2FzIHN5bmMnZWQgYnkgWGVub21haSB0byBM
aW51eCBvbmNlCj5kdXJpbmcgYm9vdC11cCwgSUlSQyBhZ2FpbnN0IENMT0NLX1JFQUxUSU1FIHdo
aWNoIG1pZ2h0IG5vdCBoYXZlIGJlZW4KPnNldCB5ZXQgYXQgdGhpcyBwb2ludC4gV2l0aCBkb3Zl
dGFpbCwgd2UgY2FuIHVzZSB0aGUgTGludXggY2xvY2tzCj5kaXJlY3RseSBzbyB0aGF0IHlvdSBh
cmUgcmVhZGluZyBDTE9DS19NT05PVE9OSUMgaGVyZS4KPgo+VGhhdCBtZWFucyB0aGF0IG9sZCBj
b2RlIHdoaWNoIHVzZWQgdG8gcnVuIG92ZXIgaS1waXBlIHNob3VsZCBub3QgaGF2ZQo+cmVsaWVk
IG9uIHRoZSBjbG9jayBiZWluZyBzeW5jJ2VkIGFueXRoaW5nICh3ZSBoYWQgQ0xPQ0tfSE9TVF9S
RUFMVElNRQo+dW5kZXIgcG9zaXggZm9yIHRoYXQpLgoKVGhlIHZhbHVlIHJldHVybiBieSBydF90
aW1lcl9yZWFkIGlzIHN1cHBvc2VkIHRvIGJlIHRoZSB0aW1lIGVsYXBzZWQgc2luY2Ugc3lzdGVt
IHN0YXJ0dXAuCkhvd2V2ZXIsIHRoZSB2YWx1ZSByZXR1cm4gYnkgSS1waXBlIGlzIG92ZXIgdHdv
IGhvdXMsIHdoaWNoIGlzIGNsZWFybHkgaW5jb3JyZWN0LCBhcyBJIGV4ZWN1dGVkIGl0IHNob3J0
bHkgYWZ0ZXIgdGhlIHN5c3RlbSBzdGFydGVkLgoKV2hhdCBkb2VzIHRoZSB2YWx1ZSByZXR1cm4g
YnkgcnRfdGltZXJfcmVhZCByZXByZXNlbnQgdW5kZXIgSS1waXBlPwoKLS0KVGhhbmtzLApZYW8g
WW9uZ3hpYW4K
