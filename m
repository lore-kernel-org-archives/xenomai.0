Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E8435B1F4
	for <xenomai@lists.linux.dev>; Tue,  5 Mar 2024 05:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709618290; cv=none; b=gJIaHZyagvuVg1lSINI3OvlHznsPUMpSXFFi2akHUqEw0GO28u8ZFfSkI35OJUiWe5D+ZWxC1yw+P3RfZFAXBFSsKvU7/Wh2BnmuBapjjcQJT4ZDEBX6s3Pwaiedj2ZN8aLN20D7o1PoVtvilBgHe3PXUnkCiM5Ilhv/N4OGm3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709618290; c=relaxed/simple;
	bh=t/EY+ug7dKldPicKbtCYEX7fsk6iyH31fd9mLNKsoQE=;
	h=Date:From:To:Subject:Content-Type:MIME-Version:Message-ID; b=tL9yBsOxJh9MLMxaxoWuBB0AIXdNKRP29sLaFsHJ3RFGQhInUVRCfSGsCjojFneRux3r3yWS66mLedgQAdHmtiS3emNzQNruk2WRMClFSV2YvfiNpIl86H55BX6oe/6zK2Dy674UzVQqCKmIsUH5hDEbndzhvsF8CXXPYmda+zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=QcdUGE/V reason="signature verification failed"; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="QcdUGE/V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=bUU0ThLlZUMP5QPDXqDWnakrPr+eqYQ9ltbDh3yhYpA=; b=Q
	cdUGE/Vkxiyq2YSPQqfvhYXHcpQStKUwCH+UDbyxWV7XPJ4GLJ3dEPp16HBcvp6l
	HfxOVwFIoeynywRySM+Icpb891pOyilemq9SD3Sku5ZCvxvkHLhFDkxiFQIYYqn3
	Wk4U5AuqYsNnyxxeoQxP6e9Nz+UrAuB4d0SwYOspPc=
Received: from suntaoworks$163.com ( [120.224.142.42] ) by
 ajax-webmail-wmsvr-40-105 (Coremail) ; Tue, 5 Mar 2024 13:58:04 +0800 (CST)
Date: Tue, 5 Mar 2024 13:58:04 +0800 (CST)
From: =?UTF-8?B?5a2Z5rab?= <suntaoworks@163.com>
To: xenomai@lists.linux.dev
Subject: xenomai in vmwear
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2024 www.mailtech.cn 163com
X-NTES-SC: AL_Qu2bC/qat0oj4iObYekZk0YXj+c/W8K1vvsg1YdfPJs0tyTO6gMDbGF8OlHz1tmPFzC2rgawSTdi8MZjWbF2XJP18p8PF7Sk83a8D4OHz5hz
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Message-ID: <abbbd8a.85e2.18e0d30c733.Coremail.suntaoworks@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:_____wD3v3dstOZlph4FAA--.19213W
X-CM-SenderInfo: xvxq3txrzr2yrv6rljoofrz/1tbiTw6YYmXAkvau9AAGsm
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CgpkZWFyIG1haW50YWluZXJzLGkgdXNlIHhlbm9tYWkoMy4xLngpK2xpbnV4IGtlcm5lbCg0LjEu
MTgpK2lwaXBlK2RlYmlhbjgrdm13ZWFyK3Ztd2VhciB0b29sIGZvciBkZXZlbG9waW5nLml0IHdv
cmtzIGZpbmUud2hlbiBpIGNoYW5nZSB0byBkZWJpYW45LCBpdCBjYW4ndCBmdWxsIGRlc2t0b3Ao
aGFzIGxpbWl0IGRwaSkuaSDCoHdvbmRlciB3aHk/IHNhbWUga2VybmVsLHNhbWUgcGF0Y2hlcyxz
YW1lIHZtd2Vhcixvbmx5IHN5c3RlbSBvcGVyYXRpb24gaXMgZGlmZmVyZW50LiBpIGFsc28gY29u
ZmlybSB0aGF0IHhvcmcgb2YgZGViaWFuOCBhbmQgZGViaWFuOSDCoGlzIGFsc28gc2FtZS5oZWxw
IG1lLHRoYW5rcy4=
