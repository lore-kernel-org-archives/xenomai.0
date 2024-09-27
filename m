Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C4E6170A27
	for <xenomai@lists.linux.dev>; Fri, 27 Sep 2024 07:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727420419; cv=none; b=oqLee4oTa1ByNNpaCcnxgcZvIBPT+2JRhBNSB72c5A2qUpR+AES5Awsb4D7xwbKjER2aR9jEHRXadNmASHNJlvkz5+lUjE4mbSJkoeMposKHYXJHusHI4AqLdtRoWLl1osTRs9QyXi6fPe87HH1Zso5Y2A0KE/LScCbG4eboN0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727420419; c=relaxed/simple;
	bh=3ys4BdaO+xVvjfR/aGyPqX1FbVVOk4lQl6z8RmfrvOU=;
	h=Date:From:To:Subject:Content-Type:MIME-Version:Message-ID; b=VosnwmxD8Kqb5yYjOCA2O+vQ7+tSe53p8ClavnpZ035/TrqzU8aPDSqhSC9W3dItWdtmhaGSyX+k1l7Hab4UJYwWhjwnBPwAMMqdk/BEO23pzAjff4GIFFNb9eZZVBEqtF5oDgRgL4zwhr7q/5eVaiwbvWjSZv2OvER1eIuQ04g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=IFpjJzn4 reason="signature verification failed"; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="IFpjJzn4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=CGf4kxkEGoMrK88H752V5PUGQWb9B4eZdNTBtclSy5s=; b=I
	FpjJzn4CqY0IOE6VsZEZErn3cnrbmUroTs1B66FpD9myAvVxDVV5XQxCY2eGke0o
	5fJZuGhr6hg3FMfT7Pyl0N8M4enSzoabIXgw8LfI/zTGvUxVp42jRkV57xXJV9Hr
	zM/4JiLEoZZaCEAJ1dSyszi4/JbzJJb0yoeBLgHhi4=
Received: from mars_liu2023$163.com ( [103.161.254.5] ) by
 ajax-webmail-wmsvr-40-102 (Coremail) ; Fri, 27 Sep 2024 15:00:07 +0800
 (CST)
Date: Fri, 27 Sep 2024 15:00:07 +0800 (CST)
From: mars_liu <mars_liu2023@163.com>
To: xenomai <xenomai@lists.linux.dev>
Subject: how to add cpu load in testing latency
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20240801(9da12a7b)
 Copyright (c) 2002-2024 www.mailtech.cn 163com
X-NTES-SC: AL_Qu2ZBfiZv0wr4SWRY+kWmEsQju45WMW0uPwu3YZTOJs0tCTz3ioDbW9aAVXJ+s6XAhqhoAiXcxFR6OV2VrR5VY6wN6T72zR973GKvxxZ0jau
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Message-ID: <3c07ae1c.6c55.19232479f35.Coremail.mars_liu2023@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:ZigvCgDXj773V_ZmCOACAA--.27244W
X-CM-SenderInfo: 5pdu2sholxjiist6il2tof0z/1tbiqRhlD2bz5cCYDwAKs2
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CgpoaSB4ZW5vbWFpLAoKaSdtIHRyeWluZyB0byB0ZXN0IGxhdGVuY3kgd2l0aCBmdWxsIGNwdSBs
b2FkIC4KCml0IGhhcyA0IGNwdSBjb3JlcyxhbmQgdGhlcmUgYXJlIHR3byBtb2RlIGNhdXNlIGZ1
bGwgY3B1IGxvYWQgOgoxLiAKZm9yIG51bSBpbiBgc2VxIDRgIApkbwpkZCBpZj0vZGV2L3plcm8g
b2Y9L2Rldi9udWxsIGJzPTE2TQpkb25lIAoyLgpzdHJlc3MgLS1jcHUgNCAKCmxhdGVuY3kgdGVz
dCBjb21tYW5kIGlzICcvdXNyL2xpYi94ZW5vbWFpL3Rlc3RzdWl0ZS9sYXRlbmN5IC1QIDkwIC1w
IDEwMCAtYyAyIC1UIDQzMjAwJy4KCnRoZSB0ZXN0IHJlc3VsdHMgc2hvdyB0aGF0ICBsYXRlbmN5
IG9mIG1vZGUgMiBpcyBtdWNoIGJldHRlciB0aGFuIG1vZGUgMSAuCgpteSBxdWVzdGlvbiBpcyB3
aGljaCBtb2RlIG9mICBmdWxsIGNwdSBsb2FkIGlzIHN1aXRhYmxlLiAKClJlZ2FyZHMsIG1hcnNf
bGl1
