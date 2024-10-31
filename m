Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24AB428FD
	for <xenomai@lists.linux.dev>; Thu, 31 Oct 2024 02:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730343072; cv=none; b=FucasnorihTDzAeM7O1HSc25ZMLsOzpe9ZdvTSZf2shONq2bSZntmbexeVWeCZfh9aHVf8ujK1kSTjcH615+QvAcMmQbXMNR2Z1SXLgOBlbmOuzDpfWBfMDV1QJR4OXMm5ynNWrWEvdGDQ9qY97hDaazcUBogT5DuL9aZ3FxqN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730343072; c=relaxed/simple;
	bh=rnIMwuf+Ihg1uWjFipaEKdVsNC7BJ/2IC0ZXEauHlrY=;
	h=Date:From:To:Subject:Content-Type:MIME-Version:Message-ID; b=gYprHFrSQLi2JBJZb7swv4K3/0TclQyhECEfUipIibO7/Y1pdKKF94L9jzOfIPltUPlCiwVxt25PvtdhPZXBJQBgw62IjCzmclM18vktp520+ri5REmpe5f5TKs4at9Qs2k/OsQKO5s7gP2eBM8cGXGJkDbmMGk/dZT/i0vYmMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=j+JmZPcL reason="signature verification failed"; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="j+JmZPcL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=535cNs5K3lbhEy/pkla4uElpjF4tWPHj1zOKZ1bgkIA=; b=j
	+JmZPcLfhnEekaW/FZRwdoN80w6Dj8yz7O3iZSnHK/QYCJXqavuOXZLDIaoQripS
	RXqvi6Kj5emUURF+dw2XPBl8cALRs1QtzniHgHq34e+WTK+yIrgLSeOCZRs/4t3s
	5lNHyTZCXXmcv6+vWaRjKW+OCqWE7Xg1DBqOsBaCmk=
Received: from suntaoworks$163.com ( [120.224.142.42] ) by
 ajax-webmail-wmsvr-40-127 (Coremail) ; Thu, 31 Oct 2024 10:51:04 +0800
 (CST)
Date: Thu, 31 Oct 2024 10:51:04 +0800 (CST)
From: =?GBK?B?y+/Mzg==?= <suntaoworks@163.com>
To: xenomai@lists.linux.dev
Subject: hand up when boot
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20240801(9da12a7b)
 Copyright (c) 2002-2024 www.mailtech.cn 163com
X-NTES-SC: AL_Qu2YAv+fvEgt4iCZbOkZk0YXj+c/W8K1vvsg1YdfPJs0lyTB+g4pbG56MVry9fmCECqmoQmrXDdl59VXepReU4Mb7xlMZpqgWqGNfKxRyyM2
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Message-ID: <10a77915.2e93.192e07bd1d7.Coremail.suntaoworks@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:fygvCgD3v62Y8CJnJ3kcAA--.3105W
X-CM-SenderInfo: xvxq3txrzr2yrv6rljoofrz/xtbBoRCIYmchwcEzTgACsi
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CmRlYXIgYWxsLEkgdXNlIGxpbnV4IGtlcm5lbCA1LjE1LjM2LCB4ZW5vbWFpIDMuMi40LCBkb3Zl
dGFpbCA1LjE1LjkgZm9yIHp5bnEgNzAyMCBkZXZlbG9waW5nLndoZW4gSSBvcGVuIGNvbmZpZ19z
bXAsIGl0IGhhbmRzIHVwIHdoZW4ga2VybmVsIGJvb3QuSXQncyBvayB3aGVuIGkgY2xvc2UgY29u
ZmlnX3NtcCBvciBjbG9zZSBjb25maWdfeGVub21haS56eW5xIDcwMjAgdXNlcyBhcm0gQTkgY29y
ZSxzbyBpIHBhdGNoIGJ5IC0tYXJjaD1hcm0uSSBjYW4ndCBmaW5kIGhvdyB0byBzb2x2ZSBpdCxw
bGVhc2UgaGVscCBtZS5UaGFua3Mu
