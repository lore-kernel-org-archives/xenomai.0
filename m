Received: from m15.mail.126.com (m15.mail.126.com [45.254.50.223])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A06F55390
	for <xenomai@lists.linux.dev>; Fri, 22 Dec 2023 03:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=126.com header.i=@126.com header.b="Ca+Q+Xh/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=Dbm+II1nXnSIYmJKKr8FTk27A4LXAjUXA6iXF2g20Gc=; b=C
	a+Q+Xh/tw9G34fmFsl/+8pmnhL9qIO7JAE36EggjRrJfglGQ4BSKPEYfkf7ULOj2
	vKODA+U0woRi+mX1oG+UnTuANPUCQe2lZU8LvNufRw+4pZl919Hq/7PbsL3KPT/6
	HRedOVPqQYpMg2Dg1oT32Mg/cb7m3GD9JNMfd6wa8I=
Received: from yxianyao$126.com ( [103.161.254.5] ) by
 ajax-webmail-wmsvr-41-105 (Coremail) ; Fri, 22 Dec 2023 11:05:14 +0800
 (CST)
Date: Fri, 22 Dec 2023 11:05:14 +0800 (CST)
From: "Yao Yongxian" <yxianyao@126.com>
To: xenomai@lists.linux.dev
Subject: The linux-evl and libevl stable version
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2023 www.mailtech.cn 126com
X-NTES-SC: AL_Qu2bAf6au0sq4iCbY+kfm0sSheY2WcK4uf0l1YJUOp9wjDnj9zA9Qm1RPEvr2tmuBhK3gAqFbh5Q8dpnWLF3Z5A1Fo4oOaWz0arIfZNaLGw9ZA==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Message-ID: <5990240f.1ddd.18c8f7bf237.Coremail.yxianyao@126.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:_____wD330vr_IRlq50oAA--.14984W
X-CM-SenderInfo: p10lt0x1drqiyswou0bp/1tbiGB5Ns2VLZBM2MQADsl
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CkhpIEFsbKOsCgpIYXZlIHRoZSBzdGFibGUgdmVyc2lvbnMgb2YgdGhlIGxpbnV4LWV2bCBhbmQg
bGliZXZsLCB3aGljaCBjYW4gYmUgdXNlZCBpbiB0aGUgcHJvZHVjdCBiZWVuIG9mZmljaWFsbHkg
cmVsZWFzZWQ/CgpUaGFua3MuCgotLQpZYW8gWW9uZ3hpYW4=
