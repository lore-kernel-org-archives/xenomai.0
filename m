Received: from m1556.mail.126.com (m1556.mail.126.com [220.181.15.56])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 778AB2F47
	for <xenomai@lists.linux.dev>; Mon, 10 Oct 2022 15:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=ZzA+u
	Y1KR4JWU3QcV7DfnaAEgp+cssVLQn3mYixOpNU=; b=LbqyAP7dETziW4YJ4bf85
	zJLijoL0mdIuymDJVAevYQ8JGnnwyGzADroh+JtomxxohKkXM56syCyR8QTBlYgs
	ZrNsR8Tfelvgv7EHXUMAwBxNk+Zyaq2oOzUWSlFjk9ATxnNZ+yC/vW7W/oqFHsQn
	XQ3mUwjNbhSauPSveKZ7mg=
Received: from yxianyao$126.com ( [113.118.224.64] ) by ajax-webmail-wmsvr56
 (Coremail) ; Mon, 10 Oct 2022 22:37:10 +0800 (CST)
X-Originating-IP: [113.118.224.64]
Date: Mon, 10 Oct 2022 22:37:10 +0800 (CST)
From: "Yxian.Yao" <yxianyao@126.com>
To: "Jan Kiszka" <jan.kiszka@siemens.com>
Cc: xenomai@lists.linux.dev
Subject: Re:Re: some kernel exceptions
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20220113(9671e152)
 Copyright (c) 2002-2022 www.mailtech.cn 126com
In-Reply-To: <ae43e7c9-e35f-6f9a-ca2e-baceec231a50@siemens.com>
References: <54a0470d.7082.183c217d486.Coremail.yxianyao@126.com>
 <1ff093a6-a231-898c-aee6-3bfb19178ae1@siemens.com>
 <76f26fbc.727a.183c23b0834.Coremail.yxianyao@126.com>
 <ae43e7c9-e35f-6f9a-ca2e-baceec231a50@siemens.com>
X-NTES-SC: AL_QuydB/iavU4o5imfYOkWkkkVj+Y3UMa3u/Ug3Y5TP5E0virI0yUDUG9pPX3M6eCmMCGmoAioVDVl4+5wXqRxQrDd6mzy/nzf6m/qvRqYz2/L
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Message-ID: <6baf052f.6f75.183c25409c4.Coremail.yxianyao@126.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:OMqowAD3_xsYLkRjme56AA--.13045W
X-CM-SenderInfo: p10lt0x1drqiyswou0bp/1tbiHRiWs1pEHMt2-gAAsh
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CgpIaSBKYW4sCj5BdCAyMDIyLTEwLTEwIDIyOjEzOjUxLCAiSmFuIEtpc3prYSIgPGphbi5raXN6
a2FAc2llbWVucy5jb20+IHdyb3RlOgo+Cj5ObywgSSBtZWFudCBvZiB5b3UgYXJlIGNhbGxpbmcg
InBlcmYiIGluIG9yZGVyIHRvIHByb2ZpbGUgc29tZQo+YXBwbGljYXRpb25zLiBUaGUgcHVyZSBh
Y3RpdmF0aW9uIG9mIHRoZSByZWxhdGVkIGtlcm5lbCBmZWF0dXJlcyBpcyBub3QKPmNvbnNpZGVy
ZWQgcHJvYmxlbWF0aWMsIGJ1dCBzb21lICJwZXJmIiBmZWF0dXJlIGFyZSBpZiBhY3RpdmVseSB1
c2VkLgoKTXkgYXBwbGljYXRpb24gc29mdHdhcmUgZG9lcyBub3QgdXNlIHBlcmYuIApJIHVwZGF0
ZSB0aGUgZHVhbCBrZXJuZWwgYWZ0ZXIgaW5zdGFsbGluZyBEZWJpYW4gMTAuMywgCmluc3RhbGwg
dGhlIHhlbm9tYWkgY29iYWx0IGxpYnJhcnksIGFuZCB0aGVuIHJ1biBteSBhcHBsaWNhdGlvbiBz
b2Z0d2FyZS4gCkhvdyBjYW4gSSBkZXRlcm1pbmUgd2hldGhlciBvdGhlciBhcHBsaWNhdGlvbnMg
aW4gdGhlIHN5c3RlbSB1c2UgcGVyZj8KQXJlIHRoZXNlIGtlcm5lbCBleGNlcHRpb25zIHJlbGF0
ZWQgdG8gcGVyZj8KCgo+SWYgeW91IGRvIG5vdCBuZWVkIHRob3NlIGZlYXR1cmVzLCB5b3UgbWF5
IGFsc28gdHJ5IGRpc2FibGluZyB0aGVtLCBpZgo+dGhhdCBjaGFuZ2VzIHRoZSBwaWN0dXJlLiBB
bHNvIGNvbXBhcmUgeW91ciBjb25maWcgaW4gdGhpcyByZWdhcmQgdG8gdGhlCj5jb25maWcgd2Ug
dGVzdCBpbiB4ZW5vbWFpLWltYWdlcyAoanVzdCBhIHJlZmVyZW5jZSwgbm90IGFzIHRoZSBvbmx5
Cj5wb3NzaWJseSB2YWxpZCBjb25maWcsIGJ5IGZhcikuCgpXaGVyZSBjYW4gSSBnZXQgdGhlIHhl
bm9tYWktaW1hZ2VzIGFuZCB0aGUgY29uZmlnPwpJbiBhZGRpdGlvbiwgdGhlIGtlcm5lbCBoYXMg
YSBsb3Qgb2YgY29uZmlndXJhdGlvbiBpdGVtcy4gCkhvdyBjYW4gSSBkZXRlcm1pbmUgd2hpY2gg
b25lcyBzaG91bGQgYmUgdHVybmVkIG9uIGFuZCBvZmY/CklzIHRoZXJlIGEgZGV0YWlsZWQgaW5z
dHJ1Y3Rpb24gbWFudWFsPwoKClRoYW5rcy4KCg==
