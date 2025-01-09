Received: from redirect.mail.gandi.net (relay14.mail.gandi.net [217.70.178.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAFBD2153FA
	for <xenomai@lists.linux.dev>; Thu,  9 Jan 2025 10:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736418523; cv=none; b=jO5coxcD+sl0g8aaFEAY4Y761x8NqzzKOSf/lBo4scxt5x80M1RPU03o6DrkQ0Dq6MZkigc9caKOMiJ5Ksp8m6nNMLsbday0GtJEhlQ22APvrR4E9VRPG2v4c80ES1WA6A20Vd1SfTXg4926JAofP7Y2lzwi+YFFrYjgj1rs58s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736418523; c=relaxed/simple;
	bh=eJnWdDRv0X7w7RBB8KIqLy3mXDR5QSXzbz7m150FRvI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=uiZjtk9yY7HPSW4N5fdNP63oHaYoIvny61UM3wAGtGukxaTn30OeGmR56gcZdIdaP7+lxn+l9vuRcUhgyphG0VbGNL9/cn2rNXWirqX39kCX8vIBCPiCNyjheXuOjIALmDC744KUDmBfH3958TLK35YzMeHfkxHw30lcdJ95ivo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=redirect.mail.gandi.net; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=TsmXQCyb reason="signature verification failed"; arc=none smtp.client-ip=217.70.178.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="TsmXQCyb"
Received: from spool.mail.gandi.net (spool4.mail.gandi.net [217.70.178.213])
	by relay14.mail.gandi.net (Postfix) with ESMTPS id A64741A0005;
	Thu,  9 Jan 2025 10:28:31 +0000 (UTC)
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by spool.mail.gandi.net (Postfix) with ESMTP id 2F26F7803E4;
	Thu,  9 Jan 2025 10:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=1J494q/oKIKTIRAC7AD9wV5OatgVq4XI/gwCI/sci/g=; b=T
	smXQCyb+Eijmfz4XXPdMx7JB5rpdAJx5xzuHSuaDUSfyvsmfZMNeh3isCRvMjOQv
	3lZdgFZKNBAIw+4bZNo6vs00qIVSr2KD+oMPuLEp04p2KSIerHtagxHSIA13s/FX
	bo29qyuLQfDyaa3LIa6Kc3nCIrAlsZQ1HLSCVdCFZk=
Received: from powertree$163.com ( [219.142.137.151] ) by
 ajax-webmail-wmsvr-40-138 (Coremail) ; Thu, 9 Jan 2025 18:28:24 +0800 (CST)
Date: Thu, 9 Jan 2025 18:28:24 +0800 (CST)
From: linz  <powertree@163.com>
To: "Philippe Gerum" <rpm@xenomai.org>
Cc: "Jan Kiszka" <jan.kiszka@web.de>, 
	"xenomai@xenomai.org" <xenomai@xenomai.org>
Subject: Re:Re: calling __get_cpu_fpsimd_context twice in a row when
 kernel_neon_begin running
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20240801(9da12a7b)
 Copyright (c) 2002-2025 www.mailtech.cn 163com
In-Reply-To: <87ttmwo7by.fsf@xenomai.org>
References: <867aed54-563a-4c06-b750-4a7727e6e4c0@163.com>
 <103fdf7d-d3c8-45a9-b25d-283c9af400eb@siemens.com>
 <77c3e1fd-dab9-4b7c-b4f7-67c38dfc37bc@siemens.com>
 <79e83ee2-7406-43c1-9a71-e79cb2cbd127@163.com>
 <d799980b-fbfc-467b-87b7-5a4fbc6ddf50@web.de> <87ttmwo7by.fsf@xenomai.org>
X-NTES-SC: AL_Qu2YBPiat00r4iKQZekfmkcXhuY2WsKzuPoh2oJVPJt4jBDoxzgGTUFMAmr23+eOEgmLrheYWyBw6fpzZ4BXUr0iYXunExaxLeBK7IKFq7lXpA==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Message-ID: <8dbe101.93d4.1944a9bae5f.Coremail.powertree@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:iigvCgD3f87IpH9nWxBUAA--.19505W
X-CM-SenderInfo: psrzv2pwuhvqqrwthudrp/xtbB0gDPlWd-lBm-VgADs3
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
Authentication-Results: spool.mail.gandi.net;
	dkim=fail ("body hash did not verify") header.d=163.com header.s=s110527 header.b="T smXQCy";
	dmarc=pass (policy=none) header.from=163.com;
	spf=pass (spool.mail.gandi.net: domain of powertree@163.com designates 220.197.31.5 as permitted sender) smtp.mailfrom=powertree@163.com

SGksICBhbGwKSSB0aGluayB0aGUgZm9sbG93aW5nIHBhdGNoIGNhbiByZXNvbHZlIHRoZSBidWcs
ICBpdCBhbGxvd3Mgb29iIHRocmVhZHMgdG8gc2FmZWx5IHByZWVtcHQga2VybmVsX25lb25fYmVn
aW4oKSAvIGtlcm5lbF9uZW9uX2VuZCBzZWN0aW9ucy4KaHR0cHM6Ly9zb3VyY2UuZGVueC5kZS9Y
ZW5vbWFpL2xpbnV4LWRvdmV0YWlsLy0vY29tbWl0LzliMTk3MDBlNjIzZjk2MjIyYzY5ZWNiMmFk
ZWNiMWEzZTM2NjRjYzAKCkJ1dCB0aGlzIHBhdGNoIGhhcyBiZWVuIG1lcmdlZCBpbnRvIHRoZSBM
aW51eCBrZXJuZWwgdmVyc2lvbiA2LjguIEF0IHByZXNlbnQsIEkgaGF2ZSBubyBwbGFuIHRvIHVw
Z3JhZGUgdG8gdmVyc2lvbiA2LjguCkknbSBub3Qgc3VyZSBpZiBJIHVuZGVyc3RhbmQgY29ycmVj
dGx5LCBidXQgaWYgc28sIGlzIHRoZXJlIGEgcGxhbiB0byBiYWNrcG9ydCB0aGlzIHBhdGNoIHRv
IGEgbG93ZXIgdmVyc2lvbiwgc3VjaCBhcyA1LjEwPwoKCkF0IDIwMjQtMDEtMjkgMTY6NDI6Mzgs
ICJQaGlsaXBwZSBHZXJ1bSIgPHJwbUB4ZW5vbWFpLm9yZz4gd3JvdGU6Cj4KPkphbiBLaXN6a2Eg
PGphbi5raXN6a2FAd2ViLmRlPiB3cml0ZXM6Cj4KPj4gT24gMjUuMDEuMjQgMDQ6MTgsIGxpbnog
d3JvdGU6Cj4+PiBJIHRoaW5rIG15IHBhdGNoIGlzIG5vdCBzdWl0YWJsZSBhZnRlciBsaXN0ZW5p
bmcgdG8geW91ciBzdWdnZXN0aW9ucy4KPj4+IEFuZCBJIGRvbid0IGhhdmUgYW55IG90aGVyIGdv
b2Qgc29sdXRpb25zLgo+Pj4KPj4+IEkgdGhpbmsgeDg2IGlzIG9rIGJlY2F1c2UgdGhlcmUgaXMg
bm8gb3BlcmF0aW9uIG9mIHdyaXRpbmcgZ2xvYmFsCj4+PiB2YXJpYWJsZXMgaW4gdGhlIGNyaXRp
Y2FsIHpvbmUuCj4+Pgo+Pj4ga2VybmVsX2ZwdV9iZWdpbgo+Pj4gwqDCoMKgID0+a2VybmVsX2Zw
dV9iZWdpbl9tYXNrCj4+PiA9PnByZWVtcHRfZGlzYWJsZSAvLyBlbnRlciB0aGUgY3JpdGljYWwg
em9uZQo+Pj4gwqDCoMKgwqDCoMKgwqAgPT5XQVJOX09OX0ZQVSghaXJxX2ZwdV91c2FibGUoKSk7
Cj4+PiDCoMKgwqDCoMKgwqDCoCA9PldBUk5fT05fRlBVKHRoaXNfY3B1X3JlYWQoaW5fa2VybmVs
X2ZwdSkpOwo+Pj4gwqDCoMKgwqDCoMKgwqAgPT5mbGFncyA9IGhhcmRfY29uZF9sb2NhbF9pcnFf
c2F2ZSgpOyAvLyBsZWF2ZSB0aGUgY3JpdGNhbCB6b25lCj4+Pgo+Pj4KPj4+IEJ1dCBpbiBhcm02
NCwgdGhlcmUgaXMgb3BlcmF0aW9uIG9mIHdyaXRpbmcgZ2xvYmFsIHZhcmlhYmxlcyBpbiB0aGUK
Pj4+IGNyaXRpY2FsIHpvbmUsIHVuZm9ydHVuZXJuYWx5Lgo+Pj4gZWZpX2NhbGxfcnRzCj4+PiDC
oCA9Pl9fZWZpX2Zwc2ltZF9iZWdpbgo+Pj4gwqDCoMKgID0+a2VybmVsX25lb25fYmVnaW4KPj4+
IMKgwqDCoMKgwqAgPT5nZXRfY3B1X2Zwc2ltZF9jb250ZXh0Cj4+PiA9PmhhcmRfcHJlZW1wdF9k
aXNhYmxlIC8vIGRpc2FibGUgaW50ZXJydXB0LCBlbnRlciB0aGUgY3JpdGljYWwgem9uZQo+Pj4g
PT5fX2dldF9jcHVfZnBzaW1kX2NvbnRleHQgLy/CoCBmaXJzdCBjYWxsLCBtb2RpZnkgZ2xvYmFs
IHZhcmlhYmxlCj4+PiBmcHNpbWRfY29udGV4dF9idXN5Cj4+PiA9PmhhcmRfY29uZF9sb2NhbF9p
cnFfcmVzdG9yZSAvLyBlbmFibGUgaW50ZXJydXB0LCBsZWF2ZSB0aGUgY3JpdGNhbCB6b25lCj4+
Pgo+Pj4gaGFuZGxlX2FyY2hfaXJxX3BpcGVsaW5lZCAvLyBMYXRlbmN5IHRpbWVyIGludGVycnVw
dCB0cmlnZ2VyZWQKPj4+ID0+aGFuZGxlX2lycV9waXBlbGluZWRfZmluaXNoCj4+PiDCoCA9Pmly
cV9leGl0X3BpcGVsaW5lCj4+PiDCoMKgwqAgPT54bnNjaGVkX3J1bgo+Pj4gwqDCoMKgwqDCoCA9
Pl9feG5zY2hlZF9ydW4KPj4+IMKgwqDCoMKgwqDCoMKgID0+cGlwZWxpbmVfc2NoZWR1bGUKPj4+
IMKgwqDCoMKgwqDCoMKgwqDCoCA9PnJ1bl9vb2JfY2FsbAo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCA9Pl9fX3huc2NoZWRfcnVuCj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCA9PnBp
cGVsaW5lX3N3aXRjaF90bwo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgID0+ZG92
ZXRhaWxfY29udGV4dF9zd2l0Y2gKPj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgPT5fX3N3aXRjaF90bwo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgPT5mcHNpbWRfdGhyZWFkX3N3aXRjaAo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgID0+X19nZXRfY3B1X2Zwc2ltZF9jb250ZXh0IC8vIHNlY29uZCBjYWxs
Cj4+Pgo+Pj4gU28sIEkgdGhpbmsgdGhlcmUgYXJlIG1vcmUgdG9kb3Mgb24gYXJtNjQuIERvIHlv
dSBoYXZlIGFueSBvdGhlciBnb29kCj4+PiBzdWdnZXN0aW9ucz8KPj4+Cj4+Cj4+IFBoaWxpcHBl
LCBzb21lIGlucHV0IG9uIHRoaXMgaXNzdWUgd291bGQgYmUgaGVscGZ1bCB0byBrbm93IHdoYXQg
dGhlCj4+IG5leHQgc3RlcCBuZWVkcyB0byBiZS4gSXQncyBzdGlsbCB1bmNsZWFyIHRvIG1lIGhv
dyBmdW5kZW1lbnRhbCB0aGlzCj4+IGlzc3VlIGlzIChmYWxzZSBwb3NpdGl2ZSB3YXJuaW5nIG9y
IHJlYWwgc3RhdGUgY29ycnVwdGlvbj8pLgo+Pgo+Cj5UaGlzIGlzIGEgY3VycmVudCBsaW1pdGF0
aW9uIG9uIGFybTY0IHdoaWNoIGFtb3VudHMgdG8gYSBidWcKPmFjdHVhbGx5LiB4ODYgaGFzIHRo
ZSBwcm9wZXIgaW1wbGVtZW50YXRpb24sIHdoaWNoIGFsbG93cyBvb2IgdGhyZWFkcyB0bwo+c2Fm
ZWx5IHByZWVtcHQga2VybmVsX2ZwdV9iZWdpbigpIC8ga2VybmVsX2ZwdV9lbmQgc2VjdGlvbnMu
ICBTaW5jZQo+a2VybmVsX25lb25fYmVnaW4oKSByZS1lbmFibGVzIGhhcmQgaXJxcyBiZWZvcmUg
bGVhdmluZywgaXQgaXMgY3JlYXRpbmcKPnRoZSBvcHBvcnR1bml0eSBmb3IgYSBtZXNzLgo+Cj5U
aGUgd2F5IHRvIGZpeCB0aGlzIGlzIHRvIGltcGxlbWVudCB0aGUgeDg2IGxvZ2ljIHRvIGFybTY0
IHdoZW4gaXQgY29tZXMKPnRvIGluLWtlcm5lbCBmcHUgdXNhZ2UuCj4KPi0tIAo+UGhpbGlwcGUu
Cg==
