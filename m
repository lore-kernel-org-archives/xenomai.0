Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.6])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FFB6134A9
	for <xenomai@lists.linux.dev>; Mon,  8 Jan 2024 09:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=126.com header.i=@126.com header.b="KWP5aSS1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=cUQJ8nCHlKuJ8kzG2HbU++P61zMQ/xLu2Mza4plafac=; b=K
	WP5aSS1MT3r8RblfHd9WnaVqtJS383BKPLp8+3HwacwDtBEr9tIEeWlG2mda9gDF
	rs80dpegUq8eaZOO5f19SsmtofcPjTjNiknxHhUqathnjPxjkXcR6/Ctzjf7Sq6h
	X838f7DD/mWqOjxskBvf6xjhrYEZGy/xbTPJHAQhzY=
Received: from yxianyao$126.com ( [103.161.254.5] ) by
 ajax-webmail-wmsvr-41-110 (Coremail) ; Mon, 8 Jan 2024 17:53:21 +0800 (CST)
Date: Mon, 8 Jan 2024 17:53:21 +0800 (CST)
From: "Yao Yongxian" <yxianyao@126.com>
To: "Jan Kiszka" <jan.kiszka@siemens.com>
Cc: xenomai@lists.linux.dev, "Philippe Gerum" <rpm@xenomai.org>
Subject: Re:Re: The linux-evl and libevl stable version
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2024 www.mailtech.cn 126com
In-Reply-To: <5def1e14-e11f-4966-9f26-18ce62378592@siemens.com>
References: <5990240f.1ddd.18c8f7bf237.Coremail.yxianyao@126.com>
 <c8491c64-f8d7-4136-8552-8ac1fb111170@siemens.com>
 <6e6d5f0a.3f41.18ce78d31f5.Coremail.yxianyao@126.com>
 <5def1e14-e11f-4966-9f26-18ce62378592@siemens.com>
X-NTES-SC: AL_Qu2bBvubuE4r5ymfbekfm0sSheY2WcK4uf0l1YJUOp9wjDHj/hstRVVpNnfRyO22IQGsszK9cwpv9fhzc5hCVIIuv8rCvXPfKyrR8uoFOnkrGA==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Message-ID: <5cc1dbe.7e90.18ce87db63d.Coremail.yxianyao@126.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:_____wD3H+ISxptlUngjAA--.50884W
X-CM-SenderInfo: p10lt0x1drqiyswou0bp/1tbiGAhfs2VLZTIW1AAEsD
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CgpBdCAyMDI0LTAxLTA4IDEzOjQxOjQ4LCAiSmFuIEtpc3prYSIgPGphbi5raXN6a2FAc2llbWVu
cy5jb20+IHdyb3RlOgo+T24gMDguMDEuMjQgMDY6MzAsIFlhbyBZb25neGlhbiB3cm90ZToKPj4g
Cj4+IFdlIHBsYW4gdG8gdXNlIERlYmlhbjExLngodGhlIERlYmlhbiBrZXJuZWwgaXMgYmFzZWQg
bGludXgtNS4xMC54IExUUykgb24gb3VyIHByb2R1Y3QuCj4+IAo+PiBJcyB0aGVyZSBjb21wYXRp
YmlsaXR5IGlzc3VlcyBiZXR3ZWVuIGRlYmlhbjExJ3MgZ2xpYmMgbGlicmFyeSBhbmQgbGludXgt
ZXZsLTYuNi4geCBMVFM/Cj4+IAo+Cj5JIGRvbid0IGV4cGVjdCBhbnksIGp1c3Qgd2Ugd29uJ3Qg
dGVzdCBvbiB0aGF0IGFueW1vcmUuCj4KPldoeSBhcmUgeW91IHN0YXJ0aW5nIGEgbmV3IGRldmVs
b3BtZW50IHdpdGggYSAzLXllYXJzLW9sZCBiYXNlbGluZT8KCj4KCkRlYmlhbiAxMSBoYXMgYmVl
biB1c2VkIG9uIG91ciBwcm9kdWN0cyBmb3Igc2V2ZXJhbCB5ZWFycywgYW5kIHdlIG9ubHkgd2Fu
dCB0byB1cGdyYWRlIHRoZSBrZXJuZWwgdG8gdGhlIGxhdGVzdCB2ZXJzaW9uIHdpdGhvdXQgdXBn
cmFkaW5nIHRoZSBvcGVyYXRpbmcgc3lzdGVtIGRpc3RyaWJ1dGlvbi4KCkJ1dCB3ZSBhcmUgbm90
IHN1cmUgaWYgdGhlcmUgd2lsbCBiZSBjb21wYXRpYmlsaXR5IGlzc3Vlcz8KCi0tLS0KWWFvIFlv
bmd4aWFuCgoK
