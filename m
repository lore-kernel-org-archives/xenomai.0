Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.6])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98B1022301
	for <xenomai@lists.linux.dev>; Wed, 13 Dec 2023 09:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=126.com header.i=@126.com header.b="pFQEX+kq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=djKfySMHj+R+iROYi9BfDNEiHe5Svr7v4RQCYDjQ6y0=; b=p
	FQEX+kqdm1uLKKkQllMfOi7RdVh6vsSbOUBuDTH1TVEM9uRjUiuefam7UsG8djt5
	5/5Gcb8daJP+NyUFXtwrKN/SJusJljM4FxVeQ814PJmSQQoBehs0deFDpFryCERl
	keXUENxG4L1t0zaMK0oQklMVlCjY7MtnUmUZzn/47g=
Received: from yxianyao$126.com ( [103.161.254.5] ) by
 ajax-webmail-wmsvr-41-101 (Coremail) ; Wed, 13 Dec 2023 16:58:47 +0800
 (CST)
Date: Wed, 13 Dec 2023 16:58:47 +0800 (CST)
From: "Yao Yongxian" <yxianyao@126.com>
To: xenomai@lists.linux.dev
Subject: What are the differences between different versions?
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2023 www.mailtech.cn 126com
X-NTES-SC: AL_Qu2bAPieuEEp4SmeZ+kfm0sSheY2WcK4uf0l1YJUOp9wjCXj9yIfU3VJG2Lb/fKvAi2gvhKdSAdQ9cZVZqtbbYwGPxe9p9JAOK1osAp5y1udqA==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Message-ID: <208a3551.545f.18c62666921.Coremail.yxianyao@126.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:_____wDn7zVJcnllvQ8UAA--.30225W
X-CM-SenderInfo: p10lt0x1drqiyswou0bp/1tbiOgZFs2VEt7T03gAFsH
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CkhpIEFsbCwKClRoZXJlIGFyZSBzZXZlcmFsIExpbnV4IGRvdmV0YWlsIHZlcnNpb25zIGluIHRo
ZSBjb2RlIHJlcG9zaXRvcnksIHN1Y2ggYXM6Cgp2NS4xMC4xOTUtZG92ZXRhaWwxLHY1LjEwLjE5
NS1kb3ZldGFpbDEtcmViYXNlLAp2NS4xMC4xOTUtZG92ZXRhaWwyLHY1LjEwLjE5NS1kb3ZldGFp
bDItcmViYXNlLCBldGMuCgpJIGFtIGNvbmZ1c2VkIGFib3V0IHdoYXQgdGhlIGRpZmZlcmVuY2Vz
IGJldHdlZW4gdGhlc2UgdmVyc2lvbnM/wqAKV2hpY2ggdmVyc2lvbiBjYW4gYmUgdXNlZCBvbiB0
aGUgcHJvZHVjdD8KCi0tIApZYW8gWW9uZ3hpYW4K
