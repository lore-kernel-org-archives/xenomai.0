Received: from m15.mail.126.com (m15.mail.126.com [45.254.50.224])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F2F379C2
	for <xenomai@lists.linux.dev>; Mon,  8 Jan 2024 05:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=126.com header.i=@126.com header.b="dSrQegJo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=M5weTIa3ewm390QrMYF0C9OfCtDIEXQOsHi5MzJ5RAI=; b=d
	SrQegJoGj3WHU7i1QcfpJr0MdFv3aM/44IU+qtyGobTp3K/euQ6LdL6ZZqa4MRT6
	69wXPjuNc1pKSft19S+uKJoYjQG5+kH+T4VIWAzX5sZg0kCXK7d/rwVX71f2C0qX
	Hi1tRsPLs+RRQ29/0EWGPd5r6t6A5HI1xPbgNIKlZY=
Received: from yxianyao$126.com ( [103.161.254.5] ) by
 ajax-webmail-wmsvr-41-106 (Coremail) ; Mon, 8 Jan 2024 13:30:39 +0800 (CST)
Date: Mon, 8 Jan 2024 13:30:39 +0800 (CST)
From: "Yao Yongxian" <yxianyao@126.com>
To: "Jan Kiszka" <jan.kiszka@siemens.com>
Cc: xenomai@lists.linux.dev, "Philippe Gerum" <rpm@xenomai.org>
Subject: Re:Re: The linux-evl and libevl stable version
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2024 www.mailtech.cn 126com
In-Reply-To: <c8491c64-f8d7-4136-8552-8ac1fb111170@siemens.com>
References: <5990240f.1ddd.18c8f7bf237.Coremail.yxianyao@126.com>
 <c8491c64-f8d7-4136-8552-8ac1fb111170@siemens.com>
X-NTES-SC: AL_Qu2bBvqSvkAo7ySfZ+kfm0sSheY2WcK4uf0l1YJUOp9wjDvj2R0BTHJOIlr36NC1LjCCoRWaQShv28Fxc4dEW50wqmpXVP3gHdvd/Fv+h0WiBQ==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Message-ID: <6e6d5f0a.3f41.18ce78d31f5.Coremail.yxianyao@126.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:_____wD3v2V_iJtlA9ILAA--.26788W
X-CM-SenderInfo: p10lt0x1drqiyswou0bp/1tbiWRJds2VLYPpjcAAGsE
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CkhpIEphbiwKCgpUaGFuayB5b3UgZm9yIHlvdXIgcmVwbHkuCgpXZSBwbGFuIHRvIHVzZSBEZWJp
YW4xMS54KHRoZSBEZWJpYW4ga2VybmVsIGlzIGJhc2VkIGxpbnV4LTUuMTAueCBMVFMpIG9uIG91
ciBwcm9kdWN0LgoKSXMgdGhlcmUgY29tcGF0aWJpbGl0eSBpc3N1ZXMgYmV0d2VlbiBkZWJpYW4x
MSdzIGdsaWJjIGxpYnJhcnkgYW5kIGxpbnV4LWV2bC02LjYuIHggTFRTPwoKLS0tLQpZYW8gWW9u
Z3hpYW4KCgpBdCAyMDI0LTAxLTAzIDAxOjIxOjQ4LCAiSmFuIEtpc3prYSIgPGphbi5raXN6a2FA
c2llbWVucy5jb20+IHdyb3RlOgo+T24gMjIuMTIuMjMgMDQ6MDUsIFlhbyBZb25neGlhbiB3cm90
ZToKPj4gSGkgQWxso6wKPj4gCj4+IEhhdmUgdGhlIHN0YWJsZSB2ZXJzaW9ucyBvZiB0aGUgbGlu
dXgtZXZsIGFuZCBsaWJldmwsIHdoaWNoIGNhbiBiZSB1c2VkIGluIHRoZSBwcm9kdWN0IGJlZW4g
b2ZmaWNpYWxseSByZWxlYXNlZD8KPj4gCj4KPmxpbnV4LWV2bCBpcyBwcm92aWRlZCBpbiB0aHJl
ZSBhY3RpdmUgYnJhbmNoZXM6Cj4gLSAyIGJhc2VkIG9uIGxhdGVzdCBMVFMga2VybmVscyAoY3Vy
cmVudGx5IDYuMSBhbmQgNi42KQo+IC0gMSB0cmFja2luZyB0aGUgbGF0ZXN0IGRldmVsb3BtZW50
IGtlcm5lbCAoY3VycmVudGx5IDYuNy1yYykKPgo+U28sIHlvdSBsaWtlbHkgd2FudCA2LjYgd2hl
biBzdGFydGluZyBhIG5ldyBwcm9kdWN0IGRldmVsb3BtZW50IHRvZGF5LAo+YW5kIHlvdSB3aWxs
IGhhdmUgMiB5ZWFycyBvZiBzdXBwb3J0IGZvciB0aGF0IGJhc2VsaW5lLgo+Cj5saWJldmwgaXMg
c2luZ2xlLWJyYW5jaGVkIGFuZCBkb2VzIG5vdCBmb3JrLW9mZiBzcGVjaWZpYyBzdGFibGUgYnJh
bmNoZXMKPnNvIGZhci4gWW91IGNhbiBmb2xsb3cgdGhlIEFQSSByZXZpc2lvbiBoaXN0b3J5IGF0
Cj5odHRwczovL3Y0Lnhlbm9tYWkub3JnL2NvcmUvdXNlci1hcGkvYXBpLXJldnMvLCBhbmQgeW91
IHdpbGwgc2VlIHRoYXQKPnRoaXMgaXMgZmFpcmx5IHN0YWJsZSBhbHJlYWR5LCBwcmltYXJpbHkg
YWRkaW5nIEFQSXMsIG5vdCBjaGFuZ2luZyBvcgo+cmVtb3ZpbmcgbXVjaCBhbnltb3JlLgo+Cj5S
ZWdhcmRpbmcgdGhlIG1hbmFnZW1lbnQgYW5kIHN0YWJpbGl0eSBvZiB0aGUgaW50ZXJmYWNlIGJl
dHdlZW4KPmxpbnV4LWV2bCBhbmQgbGliZXZsIChpLmUuIHRoZSBBQkkpLCBzZWUKPmh0dHBzOi8v
djQueGVub21haS5vcmcvY29yZS91bmRlci10aGUtaG9vZC9hYmkvLgo+Cj5Gb3IgbW9yZSBkZXRh
aWxzIChvciB0byBjb3JyZWN0IG1lKSwgUGhpbGlwcGUgbWF5IGhlbHAuCj4KPkphbgo+Cj4tLSAK
PlNpZW1lbnMgQUcsIFRlY2hub2xvZ3kKPkxpbnV4IEV4cGVydCBDZW50ZXIK
