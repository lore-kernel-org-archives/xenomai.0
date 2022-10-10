Received: from m1556.mail.126.com (m1556.mail.126.com [220.181.15.56])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE91C3207
	for <xenomai@lists.linux.dev>; Mon, 10 Oct 2022 15:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=dbFzV
	7C8mF6lt51dBMOyFpaPhB0/Q5mj81oLfUdr2n0=; b=JoxrPaBWt99U4Pk+zseNp
	Aoz2FhRC4GlgBbjzM3u5Mb8PztuK6vuSfSfmVDT89OOCUYj3fQWDCzVHJKwfJ4qh
	y/UTo1pvJ7D3dskT5voaz2ux4rZQcYCh333/6vn2jJFo/e601l6XY4sl/g2gl8U9
	dFZly9HCLUOA+oO2oKBekI=
Received: from yxianyao$126.com ( [113.118.224.64] ) by ajax-webmail-wmsvr56
 (Coremail) ; Mon, 10 Oct 2022 23:30:30 +0800 (CST)
X-Originating-IP: [113.118.224.64]
Date: Mon, 10 Oct 2022 23:30:30 +0800 (CST)
From: "Yxian.Yao" <yxianyao@126.com>
To: "Jan Kiszka" <jan.kiszka@siemens.com>
Cc: xenomai@lists.linux.dev
Subject: Re:Re: some kernel exceptions
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20220113(9671e152)
 Copyright (c) 2002-2022 www.mailtech.cn 126com
In-Reply-To: <c66ea2f5-6a7b-8420-f1ee-cd8abe7ad13d@siemens.com>
References: <54a0470d.7082.183c217d486.Coremail.yxianyao@126.com>
 <1ff093a6-a231-898c-aee6-3bfb19178ae1@siemens.com>
 <76f26fbc.727a.183c23b0834.Coremail.yxianyao@126.com>
 <ae43e7c9-e35f-6f9a-ca2e-baceec231a50@siemens.com>
 <6baf052f.6f75.183c25409c4.Coremail.yxianyao@126.com>
 <c66ea2f5-6a7b-8420-f1ee-cd8abe7ad13d@siemens.com>
X-NTES-SC: AL_QuydB/iaukAo5iObZOkWkkkVj+Y3UMa3u/Ug3Y5TP5E0virI0yUDUG9pPX3M6eCmMCGmoAioVDVl4+5wXqRxQrC+ddlyOSZ4gwwgfcnvC3aV
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Message-ID: <16329230.7168.183c284db3e.Coremail.yxianyao@126.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:OMqowAA3SWmZOkRj4_N6AA--.34301W
X-CM-SenderInfo: p10lt0x1drqiyswou0bp/1tbifh2Ws1pEIECFywABs3
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CkhpIEphbiwKCj5UaGUgd2FybmluZ3Mgc3RhcnQgd2l0aCBwZXJmLCBidXQgSSBtaWdodCBoYXZl
IGJlZW4gdG9vIHF1aWNrIHRvIHNob290Cj5hdCBpdC4gVGhlIHJlYWwgaXNzdWUgaXMgZGVmaW5p
dGVseSB0aGUgcGFnZSBmYXVsdC4gWW91IGRvbid0IGhhdmUgYQo+c3RhY2sgYmFja3RyYWNlIGZv
ciB0aGUgZmlyc3Qgb25lPwoKTm8sIHRoZXNlIGFyZSB0aGUgbGFzdCBtZXNzYWdlcyB0aGF0IHRo
ZSBrZXJuZWwgb3V0cHV0cy4gClRoZSBzZWNvbmQgZXhjZXB0aW9uIGlzIHRoZSBzYW1lIGFzIHRo
ZSBmaXJzdCBvbmWjvwpUaGUgbG9ncyBhcmUgcHJpbnRlZCB3aXRoICJCVUc6IHVuYWJsZSB0byBo
YW5kbGUga2VybmVsIHBhaW50aW5nIHJlcXVlc3QgYXQgMDAwMDAwMDAwMDBhMjJlOCIKCgo+QWxz
byBub3RlIHRoYXQgeW91ciBrZXJuZWwgaXMgbm90IGp1c3Qgb2xkIC93cnQgdG8gaXRzIGJhc2Ug
dmVyc2lvbgo+KDQuMTkpLCBpdCdzIGFsc28gbm90IHVzaW5nIHRoZSBsYXRlc3QgSS1waXBlIHBh
dGNoIGZvciB0aGF0Cj4oaXBpcGUtY29yZS00LjE5LjI1Mi1jaXA3OC14ODYtMjMpLgoKV2hhdCBp
cyB0aGUgZGlmZmVyZW5jZSBiZXR3ZWVuIGNpcCBhbmQgbm8gY2lwIG9uIGlwaXBlIGNvcmU/CgoK
PlRoZSBrZXkgc3dpdGNoZXMgYXJlIHdhcm5lZCBhYm91dC4gQnV0IHRoYXQgZG9lcyBub3QgZXhj
bHVkZSB0aGF0IHNvbWUKPnNsZWVwaW5nIGJ1ZyBpcyBvbmx5IHN1cmZhY2VkIGJ5IHR1cm5pbmcg
b24gb3Igb2ZmIHNvbWUgZmVhdHVyZSB0aGF0Cj5vdGhlcnMgdXN1YWxseSBkbyBub3QgdG91Y2gu
CgoKSG93IHRvIGZ1cnRoZXIgZGV0ZXJtaW5lIHdoYXQgY2F1c2VkIGl0PwoKVGhhbmtzLgoKCgo=

