Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A0F71EF95D
	for <xenomai@lists.linux.dev>; Thu, 14 Nov 2024 07:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731570466; cv=none; b=CfsbgH/3MsKoRbNqucU6o4KOhGUQbGdkway+6qOdGuV1wJPPoBgHUFDS/EF3wH+dhSmAIrDWuASwhs4nLUxzYy3UgyojNo4m7o4JpXPJObkAaZeyOWzQHWHy81R8CvpuL7YC2eZH0LYRf5rV99RT5Xn37f7Zhfym4GCJ1VXPO9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731570466; c=relaxed/simple;
	bh=6RTJX57ehOzgL1eK5Yst97+EhJwE2vPKHAvculNXTXM=;
	h=Date:From:To:Subject:Content-Type:MIME-Version:Message-ID; b=hGCW07dowh9KbGdSXab1rhL96p/oJxk4IaU8jDAULfqS0nZqHby+7QHIAIRURDximT8EQ4YDeibPl5G8dwPV9DpzEHgboeK7DsqhX/gXwoy0oszxIC4FMGeekuQncjKKYwZZTvTYEQ6M6Sf01VNBZMYWTu1ZMOZ/BhuMXN15VcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=FN8nosBb reason="signature verification failed"; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="FN8nosBb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=YijM7PdcFGCN108yv5pTdQ3WuB8kgMqErr/jLiRnxcA=; b=F
	N8nosBbHECSMnKqg0Xv9qZx+o9ikegMq8rnFAeM8LHnjUPgTvwSvWdoRHXK5rCnE
	GUkMDUvPtYbdculzPWtNzP+c+k0wj9osjbt/L1RflLTCwfvlcaIA+g1xzHSCKYXT
	gfYk/aybkoIgh41zTwHYd9tJ6oQ6wcJji4roeScjZQ=
Received: from suntaoworks$163.com ( [120.224.142.42] ) by
 ajax-webmail-wmsvr-40-109 (Coremail) ; Thu, 14 Nov 2024 15:47:35 +0800
 (CST)
Date: Thu, 14 Nov 2024 15:47:35 +0800 (CST)
From: =?GBK?B?y+/Mzg==?= <suntaoworks@163.com>
To: xenomai@lists.linux.dev
Subject: xenomai latency shows negative value
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20240801(9da12a7b)
 Copyright (c) 2002-2024 www.mailtech.cn 163com
X-NTES-SC: AL_Qu2YA/mcv0wu4yabYOkZk0YXj+c/W8K1vvsg1YdfPJs0uyTN8CUYbW9/LUf0+s6rMgWhoAiyWhRkwc9qV6lhc6+fqDeYgxIZ6eNDd1UrXj0K
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Message-ID: <18194dcc.758d.19329a45455.Coremail.suntaoworks@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:bSgvCgDXf+UXqzVntdAmAA--.58983W
X-CM-SenderInfo: xvxq3txrzr2yrv6rljoofrz/xtbBoRmXYmc1h4FeiQADsN
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CmRlYXIgYWxsLApJIHJ1biB4ZW5vbWFpIGxhdGVuY3kgdG9vbCBvbiBteSBkZXZpY2UgbGlrZSAi
Li9sYXRlbmN5IC10IDEgLXAgMTAwIiwgdGhlICJsYXQgYmVzdCIgc2hvd3MgbmVnYXRpdmUgdmFs
dWUuSSBhdXRvdHVuZSBpdCBsaWtlICJlY2hvIDAgPiAvcHJvYy94ZW5vbWFpL2xhdGVuY3kiLCBp
dCBjaGFuZ2VzIG5vdGhpbmcuUGxlYXNlIGhlbHAgbWUuCkJlc3QgcmVnYXJkcywKU3VudGFv
