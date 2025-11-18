Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9681286897
	for <xenomai@lists.linux.dev>; Tue, 18 Nov 2025 15:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763479883; cv=none; b=AMz1fHgdW32heymLBUPSnWKTjBU6IIaAVqNvx8zav2ntxvxdEtE4jBMih+DSGJGa680QKH76pP/VbWE7QoxhOGSAkdbr3cJBMxMf3tDJixb+Tkap1nJm2KFR9c/PMH1VI5w4GrHoGnUm1rw1SFtcURHGaHWuh/JDvMXWha5NyL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763479883; c=relaxed/simple;
	bh=Ur5OnjkcWV0HnFuajO1ue6FaL7ZDHQWqYbqoVnCiNes=;
	h=Date:From:To:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=dtwYxNxAlBopW+nitBwodP+n1EEPEGFZgesMC7EjwP4nLjqCy96gBO+uRNWg4kTZDhOgLKACOFPyh1KyqSqGR2JJ+9JV50uFqB1je0/e6QI6VVkbD/hk3U7Wdk3wmcSJZ+S9k/KPaLCE8O8MP/0Rd6BS7a79q2gypHNlIqgO/Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=UAcfaLz2 reason="signature verification failed"; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="UAcfaLz2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=EwmsXPZAMITJE/sWJTEsnjxCNKXkpaEvU5eDStPThVM=; b=U
	AcfaLz2d4//tBhRA77SxUc1U+XMuk9kGnhywUS/DqpIdi/O/X+ydZFrz7EBUxzGR
	/PpsFxs0+FJshbdXrFRlYLK7ZNmAStjsJGdlrMrRCa3QS4AqwszGhC/ER55wQTmd
	kCvtQZUTYAhcyw9dHeyn1cVPIgl/RaqQ5aEjNnMzWA=
Received: from jerryjun123$163.com ( [116.30.126.115] ) by
 ajax-webmail-wmsvr-40-135 (Coremail) ; Tue, 18 Nov 2025 23:31:14 +0800
 (CST)
Date: Tue, 18 Nov 2025 23:31:14 +0800 (CST)
From: JerryJun  <jerryjun123@163.com>
To: "Jan Kiszka" <jan.kiszka@siemens.com>,
	"xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Re:Re: schedule delay 15ms
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20250723(a044bf12) Copyright (c) 2002-2025 www.mailtech.cn 163com
In-Reply-To: <78da3e59-a848-4019-aa53-639f2ef22f33@siemens.com>
References: <4c6fa8a7.4dce.19a76af1422.Coremail.jerryjun123@163.com>
 <d14c720e-021e-4fc8-8aba-340903db0fdf@siemens.com>
 <25a5a707.3daf.19a7b5f1c16.Coremail.jerryjun123@163.com>
 <077351d6-f855-4034-ba1c-3c9f2b713743@siemens.com>
 <17aa2896.2b1e.19a8043a959.Coremail.jerryjun123@163.com>
 <78da3e59-a848-4019-aa53-639f2ef22f33@siemens.com>
X-NTES-SC: AL_Qu2dAfictkAs4iKQYOkXkkkTge8/W8ayu/8l3YJePZk0hiXg5zssVlRjHEro8eWjOjuuojSPfQhV9+ZzZ6xYVIGTigwYkkgaCmpWanxwpq2a
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Message-ID: <7fd14fcf.a9b1.19a97976af9.Coremail.jerryjun123@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:hygvCgD3YOxCkRxpnYUlAA--.2413W
X-CM-SenderInfo: xmhu25pmxqijqt6rljoofrz/1tbiJhcKLGkcjnADywADsX
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

ClN0cmFuZ2VseSBlbm91Z2gsIHRoaXMgZGVsYXkgd2Fzbid0IHByZXNlbnQgb24gdGhlIDQuMTku
ODktaXBpcCBrZXJuZWwgLSBpdCBvbmx5IGVtZXJnZWQgYWZ0ZXIgdXBncmFkaW5nIHRvIDUuMTAu
MTk5LWRvdmV0YWlsLCBkZXNwaXRlIG5vIGNoYW5nZXMgYmVpbmcgbWFkZSB0byB0aGUgcG93ZXIg
bWFuYWdlbWVudCBwb2xpY3kgb3IgdGhlcm1hbCB0aHJvdHRsaW5nIHNldHRpbmdzIGR1cmluZyB0
aGUgdXBkYXRlLiBDb3VsZCB0aGlzIGJlIHJlbGF0ZWQgdG8gcG90ZW50aWFsIGluc3RhYmlsaXR5
IGluIHRoZSBIUEVUIG9yIFRTQyBjbG9jayBzb3VyY2VzPyBBbmQgZG9lcyB1cGdyYWRpbmcgdG8g
YSBuZXcga2VybmVsIHZlcnNpb24gYWxzbyBuZWNlc3NpdGF0ZSBhIEJJT1MgdXBkYXRlPwoKQXQg
MjAyNS0xMS0xNCAxMzozODozNiwgIkphbiBLaXN6a2EiIDxqYW4ua2lzemthQHNpZW1lbnMuY29t
PiB3cm90ZToKPk9uIDE0LjExLjI1IDAzOjQ4LCBKZXJyeUp1biB3cm90ZToKPj4gCj4+IMKgIFdl
IGFkZGVkIHNvbWUgdHJhY2UgZXZlbnQgaW5mb3JtYXRpb24sIGJ1dCBmcm9tIHRoaXMgZ2FwIHBv
aW50ICg2MjA4LjY5NTk0OC0+IDYyMDguNzA4NzI2KSwgaXQgYXBwZWFycyB0aGF0IHRoZSBDb2Jh
bHQga2VybmVsIHdhcyBmcm96ZW4gYW5kIG5vIGludGVycnVwdCBoYW5kbGluZyBvY2N1cnJlZC4K
Pj4gwqAgwqBpbmNsdWRlIHRyYWNlIHBvaW50IGV2ZW50cyA6Cj4+IMKgIMKgIGlycV92ZWN0b3Jz
OmNhbGxfZnVuY3Rpb25fZW50cnkgICAgICAgICAgICAgICAgICAgIAo+PiDCoCDCoCBpcnFfdmVj
dG9yczpjYWxsX2Z1bmN0aW9uX2V4aXQgICAgICAgICAgICAgICAgICAgICAKPj4gwqAgwqAgaXJx
X3ZlY3RvcnM6Y2FsbF9mdW5jdGlvbl9zaW5nbGVfZW50cnkgICAgICAgICAgICAgCj4+IMKgIMKg
IGlycV92ZWN0b3JzOmNhbGxfZnVuY3Rpb25fc2luZ2xlX2V4aXTCoCDCoAo+PiAKPgo+SWYgdGhl
cmUgYXJlIG5vIGludGVycnVwdCBpbiB0aGF0IHBoYXNlIHdoaWxlLCBlLmcuLCBzb21lIHRpbWVy
Cj5pbnRlcnJ1cHQgc2hvdWxkIGhhdmUgb2NjdXJyZWQsIHRoZW4geW91IHNob3VsZCBkZWZpbml0
ZWx5IGNoZWNrIGZvcgo+aGFyZHdhcmUvZmlybXdhcmUgcmVsYXRlZCBkZWxheXMgdGhhdCB0aGUg
T1MgY2Fubm90IGluZmx1ZW5jZS4gT3IgZm9yCj5wb3dlci1zYXZpbmcgLyB0aGVybWFsLXRocm90
dGxpbmcgY2F1c2VzLgo+Cj5KYW4KPgo+PiDlnKggMjAyNS0xMS0xMyAxMzozMTo1NO+8jCJKYW4g
S2lzemthIiA8amFuLmtpc3prYUBzaWVtZW5zLmNvbT4g5YaZ6YGT77yaCj4+PiBPbiAxMy4xMS4y
NSAwNTowMCwgSmVycnlKdW4gd3JvdGU6Cj4+Pj4KPj4+PiBXZSBjb25kdWN0ZWQgdGVzdHMgb24g
dGhlIGtlcm5lbCB2ZXJzaW9uIHY1LjEwLjI0NS1jaXA2NS1kb3ZldGFpbDEuIFRoZSB0ZXN0IHJl
c3VsdHMgYXJlIGF0dGFjaGVkLiBEdXJpbmcgdGhpcyBwZXJpb2QsIHdlIGFsc28gcGVyZm9ybWVk
IGxhdGVuY3kgdGVzdHMsIHdoaWNoIHNob3dlZCBhIDEwbXMgZGVsYXkgYXQgNzE3NC4zMTM0MTQg
LT4gNzE3NC4zMjMwODYuICBpcnEgMTE0IGlzIG5ldCBkcml2ZXIgaW50ZXJydXB0IOOAggo+Pj4+
Cj4+Pgo+Pj4gICAgICAgICBzd2FwcGVyICAgICAwIFswMDNdICA3MTc0LjMxMzQxNDogICAgICAg
ICAgICAgICAgICAgICBpcnE6aXJxX3BpcGVsaW5lX2VudHJ5OiBpcnE9MTE0Cj4+PiAgICAgICAg
IHN3YXBwZXIgICAgIDAgWzAwM10gIDcxNzQuMzIzMDg2OiAgICAgICAgICAgICAgICAgICAgIGly
cTppcnFfcGlwZWxpbmVfZW50cnk6IGlycT0zMzAyNwo+Pj4KPj4+IFNvLCB0aGF0IGlzIHRoZSBn
YXAuIERpZCB5b3UgYWxzbyB0dXJuIG9uIGlycV9waXBlbGluZV9leGl0PyBJJ20gbm90IAo+Pj4g
c2VlaW5nIHRoYXQgZXZlbnQgaW4gdGhlIHRyYWNlLiBGdXJ0aGVybW9yZSwgSSBhbHdheXMgZm9y
IGdldCBhYm91dCAKPj4+IHRoYXQsIGl0IGlzIHVzZWZ1bCB0byBoYXZlIGlycV92ZWN0b3JzIGV2
ZW50cyBiZWNhdXNlIHRob3NlIGluY2x1ZGUgCj4+PiB0aW1lciBpcnFzLiBCdXQgaXQgaXMgdW5s
aWtlbHkgdGhhdCB3ZSBtaXNzZWQgYW55IGluIHRoYXQgZ2FwIGJlY2F1c2UgCj4+PiB0aGV5IHRl
bmQgdG8gdHJpZ2dlciBhY3Rpdml0aWVzIGxpa2UgY29iYWx0X2NvcmU6Y29iYWx0X3RpbWVyX2V4
cGlyZS4KPj4+Cj4+PiBXaGF0IGlzIG1vcmUgbGlrZWx5IGhlcmUgaXMgdGhhdCB5b3VyIGhhcmR3
YXJlIG9yIGZpcm13YXJlIGlzIG5vdCAKPj4+IGxldHRpbmcgSVJRcyB0aHJvdWdoLiBXZSBjb3Vs
ZCBjb25maXJtIHRoYXQgaWYgdGhlIGlzc3VlIGlzIHJlcHJvZHVjaWJsZSAKPj4+IHdoaWxlIGhh
dmUgZnVuY3Rpb24gdHJhY2luZyBlbmFibGVkLiBUaGF0IGNvbWVzIHdpdGggaGlnaCBvdmVyaGVh
ZCwgYnV0IAo+Pj4gdGhlIGRldGFpbGVkIHJlc3VsdCBjYW4gdGVsbCB1cyB3aGF0IHRoZSBrZXJu
ZWwgZGlkIHdoaWxlIHRoZXJlIHdlcmUgbm8gCj4+PiBpbnRlcnJ1cHRzLgo+Pj4KPj4+IFRoZXJl
IGlzIGFsc28gbmF0aXZlIHRvb2xpbmcgYnkgdGhlIGtlcm5lbCB0byBkZXRlY3QgImhhcmR3YXJl
IG5vaXNlIiwKPj4+IHNlZSBodHRwczovL2RvY3Mua2VybmVsLm9yZy90b29scy9ydGxhL3J0bGEt
aHdub2lzZS5odG1sLiBEdWUgdG8gaXRzIAo+Pj4gbmF0dXJlLCB0aGlzIG5vaXNlIHdvdWxkIGFm
ZmVjdCBYZW5vbWFpIGVxdWFsbHkuCj4+Pgo+Pj4gSmFuCj4+Pgo+Pj4gLS0gCj4+PiBTaWVtZW5z
IEFHLCBGb3VuZGF0aW9uYWwgVGVjaG5vbG9naWVzCj4+PiBMaW51eCBFeHBlcnQgQ2VudGVyCj4K
Pgo+LS0gCj5TaWVtZW5zIEFHLCBGb3VuZGF0aW9uYWwgVGVjaG5vbG9naWVzCj5MaW51eCBFeHBl
cnQgQ2VudGVyCg==
