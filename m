Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA1BE1F8199
	for <xenomai@lists.linux.dev>; Wed, 16 Oct 2024 09:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729071686; cv=none; b=r5nJnpOr1Scw7yks+l5/AEZZdF66GeUmAlYuuvg5bJw9z35/OcZop+uVXbPGQGvPM6y/Q6bVNxexEE6qua7y0oPNrriUJ6o/1KL3vwbJx32elhnV6MPOITubRwhP9gPg9/AQlBDTanrldxfBaisVuW4uQtr9YHvo+hgjOJCGrqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729071686; c=relaxed/simple;
	bh=E0EG97VoUSdROB+mZBob+Erdjw7mHMzsXKGtLz7IPoc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=mfctVC24CefuJ9ZJkS8U7doKIUIJmWk0ZtAhOPtWCZhOSUoN4mWk8RirsCDzkOiyQit8yNsfVgeuu1wVmP1y5NIoztsJpuZIP+HvvEAfqlmSCE1jWMN2dUgN9v6rZyiYFizGL6vo/KJ72HKmwKyxpma4TEyT+JNXipETqwf2Xq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=DqEmbL9i; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="DqEmbL9i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=E0EG97VoUSdROB+mZBob+Erdjw7mHMzsXKGtLz7IPoc=; b=D
	qEmbL9iOCijtVjHJBgcU2WB1VGLir/X/dn58REky/T5MhgCkl2VhFwpMHPyD0z8j
	y1/ZIFEm+2h3x+DrPFLzUhMX/CGHWcKtisimWJT8Op4O1uls9yl9qAXt1TPqhkcO
	oieeaUPwriXwOIJnT7keGBjWJ/cA534W9u4qhWHTLU=
Received: from mars_liu2023$163.com ( [103.161.254.5] ) by
 ajax-webmail-wmsvr-40-138 (Coremail) ; Wed, 16 Oct 2024 17:41:16 +0800
 (CST)
Date: Wed, 16 Oct 2024 17:41:16 +0800 (CST)
From: mars_liu  <mars_liu2023@163.com>
To: "Jan Kiszka" <jan.kiszka@siemens.com>
Cc: xenomai <xenomai@lists.linux.dev>
Subject: Re: how to add cpu load in testing latency
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20240801(9da12a7b)
 Copyright (c) 2002-2024 www.mailtech.cn 163com
In-Reply-To: <75e938ae.7216.192754de7fe.Coremail.mars_liu2023@163.com>
References: <3c07ae1c.6c55.19232479f35.Coremail.mars_liu2023@163.com>
 <d3b53281-610b-42d3-8e56-02f5e64838cc@siemens.com>
 <75e938ae.7216.192754de7fe.Coremail.mars_liu2023@163.com>
X-NTES-SC: AL_Qu2ZC/ycvk4s4CacZukfmkoVh+c5WMK2vfUm3YBfP5F4jBDoyBwkQHBMOX7I39COBx6zrheYXTtf+/ZffLhkZ6sizCl7OVPwpvaxx3LBxG8L9A==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Message-ID: <6b911f10.9d32.19294b3fce8.Coremail.mars_liu2023@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:iigvCgDHL888ig9neZEPAA--.58293W
X-CM-SenderInfo: 5pdu2sholxjiist6il2tof0z/xtbB0hx6D2cPbRr6xgAEsc
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CkhpIEphbiwKCgoKUmVjZW50bHkgSSBoYXZlIGJlZW4gbGVhcm5pbmcgaG93IHRvIGFkZCBjcHUg
bG9hZCB3aGVuIHBlcmZvcm1pbmcgbGF0ZW5jeSB0ZXN0cy4KCgpLZWVwaW5nIHRoZcKgIGxhdGVu
Y3kgbW9kZSBhdCBpdCdzIGRlZmF1bHQgc2V0dGluZyBvZiAwLgoKCkkgZm91bmQgdGhlIGZvbGxv
d2luZyBkZXNjcmlwdGlvbiBpbiB0aGUgeGVub21haSBkb2N1bWVudGF0aW9uOgpEb2hlbGwgc2Ny
aXB0IGFsbG93cyB0byBnZW5lcmF0ZSBhIHN5bnRoZXRpYyBsb2FkIChuZXR3b3JrIGxvYWQsIGRp
c2sgSS9PIGxvYWQsIGNwdSBsb2FkLCBhbmQgTGludXggc3lzY2FsbHMgY292ZXJhZ2Ugd2l0aCBM
VFApLgoKCkhvdyBkb2hlbGwgdG8gZ2VuZXJhdGUgY3B1IGxvYWQ/CkRvZXMgZG9oZWxsIGdlbmVy
YXRlIGNwdSBsb2FkIGJ5IGV4ZWN1dGluZyAiZGQgaWbvvJ0vZGV2L3plcm8gb2bvvJ0vZGV2L251
bGwiPwoKCkkgdHJpZWQgdG8gZXhlY3V0ZSAiZGQgaWYuLi4iIHRvIGdlbmVyYXRlIGNwdSBsb2Fk
IGR1cmluZyB0aGXCoCBsYXRlbmN5IHRlc3QsIGFuZCB0aGUgbGF0ZW5jeSB0ZXN0IHJlc3VsdCBh
cmUgd29yc2UgdGhhbiBleGVjdXRlICJzdHJlc3MgLS1jcHUgeCIuCgoKV2hhdCdzIHRoZSBkaWZm
ZXJlbmNlIGJldHdlZW4gdGhlICJkZCBpZiIgYW5kICJzdHJlc3MgLS1jcHUiIGZvciBnZW5lcmF0
ZSBjcHUgbG9hZC4KCgpBZGRpdGlvbmFsbHksIEknbSBzZWVraW5nIGd1aWRhbmNlIG9uIHdoaWNo
IGFwcHJvYWNoIG9yIGFueSBhbHRlcm5hdGl2ZSBtZXRob2RzIHlvdSByZWNvbW1lbmQgYWRvcHRp
bmcgZm9yIGF1Z21lbnRpbmcgQ1BVIGxvYWQgd2hlbiBjb25kdWN0aW5nIGxhdGVuY3kgdGVzdHMg
d2l0aGluIFhlbm9tYWkuCgoKVGhhbmtzIGZvciB5b3VyIHRpbWUgYW5kIGluc2lnaHRzLCBiZXN0
IFJlZ2FyZHMKCgpNYXJzX2xpdS4KCgogICAgCi0tLS0gUmVwbGllZCBNZXNzYWdlIC0tLS0KICAg
IAoKICAgICAgICAKCiAgICAgICAgICAgIAogICAgICAgICAgICAgICAgRnJvbQogICAgICAgICAg
ICAgICAgbWFyc19saXU8bWFyc19saXUyMDIzQDE2My5jb20+CiAgICAgICAgICAgIAogICAgICAg
ICAgICAKICAgICAgICAgICAgICAgIERhdGUKICAgICAgICAgICAgICAgIDEwLzEwLzIwMjQgMTU6
MjEKICAgICAgICAgICAgCiAgICAgICAgICAgIAogICAgICAgICAgICAgICAgVG8KICAgICAgICAg
ICAgICAgIEphbiBLaXN6a2E8amFuLmtpc3prYUBzaWVtZW5zLmNvbT4KICAgICAgICAgICAgCiAg
ICAgICAgICAgIAogICAgICAgICAgICAgICAgQ2MKICAgICAgICAgICAgICAgIHhlbm9tYWk8eGVu
b21haUBsaXN0cy5saW51eC5kZXY+CiAgICAgICAgICAgIAogICAgICAgICAgICAKICAgICAgICAg
ICAgICAgIFN1YmplY3QKICAgICAgICAgICAgICAgIFJlOlJlOiBob3cgdG8gYWRkIGNwdSBsb2Fk
IGluIHRlc3RpbmcgbGF0ZW5jeQogICAgICAgICAgICAKICAgICAgICAKCgoKQXQgMjAyNC0wOS0y
NyAyMTo0MTowMSwgIkphbiBLaXN6a2EiIDxqYW4ua2lzemthQHNpZW1lbnMuY29tPiB3cm90ZToK
Pk9uIDI3LjA5LjI0IDA5OjAwLCBtYXJzX2xpdSB3cm90ZToKPj4gCj4+IAo+PiBoaSB4ZW5vbWFp
LAo+PiAKPj4gaSdtIHRyeWluZyB0byB0ZXN0IGxhdGVuY3kgd2l0aCBmdWxsIGNwdSBsb2FkIC4K
Pj4gCj4+IGl0IGhhcyA0IGNwdSBjb3JlcyxhbmQgdGhlcmUgYXJlIHR3byBtb2RlIGNhdXNlIGZ1
bGwgY3B1IGxvYWQgOgo+PiAxLiAKPj4gZm9yIG51bSBpbiBgc2VxIDRgIAo+PiBkbwo+PiBkZCBp
Zj0vZGV2L3plcm8gb2Y9L2Rldi9udWxsIGJzPTE2TQo+PiBkb25lIAo+PiAyLgo+PiBzdHJlc3Mg
LS1jcHUgNCAKPj4gCgpJIG1heSBoYXZlIG1peGVkIHVwIHRoZSB3b3JkICdtb2RlJyBhYm92ZS4K
CnRoZSBhcmd1bWVudCBmb3IgJ2xhdGVuY3kgLXQnIGlzIGFsd2F5cyAwKGRlZmF1bHQpIGluIHRo
aXMgdGVzdCAuCgp0aGUgJ21vZGUnIGkgbWVhbiBhIG1ldGhvZCBhYm92ZSB0aGF0IGdlbmVyYXRl
IGNwdSBsb2FkIC4KCnNob3VsZCBpIHVzZSAnc3RyZXNzIC0tY3B1JyBvciAnZGQgaWYgLi4uLi4u
JyB0byBnZW5lcmF0ZSBjcHUgbG9hZCBmb3IgJ2xhdGVuY3kgLXQgMCcgPyAKClJlZ2FyZHMKCgo=

