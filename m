Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D3BD1EB25
	for <xenomai@lists.linux.dev>; Fri, 29 Mar 2024 01:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711674031; cv=none; b=XqAQ/HN7J+fkmbw+i7nfLEs0Kc/M/E2bWmLa1pvz6Eeap5QNxR1SYhg2Y3Uj3gU2f2DX9u4p/b1WrsprvlA/6IrIPzQ5aBTS8VhXeSMe65TihpHVU0Tba2m385tWl0zky8p7zL84GfsKilovDEcTPo5cydrMxzhdj/MuqnJOXtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711674031; c=relaxed/simple;
	bh=WpMgHKlr/gqwQWTEaZn0p83Ft0byb2Dd7E/guUFZKcA=;
	h=Date:From:To:Subject:Content-Type:MIME-Version:Message-ID; b=iW4bkSCf21cD6ObRGSVrrHMpeMRVlGEDXNZQCO9kk9+I3dryj2/n87sDKZFhHvsGMl4zYfISuWnvOK19wZeMX/iNm4FO0B2tF/BEZqpQBB5pO/EgamYNW/H8d60QO7YWKpVle8dzdJ4jq+ObUii9MNpJvN7tcX9LTIezVjdGbXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=aVv7frbt; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="aVv7frbt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=WpMgHKlr/gqwQWTEaZn0p83Ft0byb2Dd7E/guUFZKcA=; b=a
	Vv7frbtB85oUwRkcvcqE0DY4QzU65WMpYzBTk699nqo5AbDnSs22XoM31/E/lMjB
	LOjamC5iECSWou9+aJYMssXG2MFP3EQz25m/42nRJ93fkQ5LkbLGO8EF+zEznF9P
	v57aNVJ1YjKzmlWK/214eFeHxbAJyCdoaUYp8BHY6g=
Received: from suntaoworks$163.com ( [120.224.142.42] ) by
 ajax-webmail-wmsvr-40-115 (Coremail) ; Fri, 29 Mar 2024 09:00:23 +0800
 (CST)
Date: Fri, 29 Mar 2024 09:00:23 +0800 (CST)
From: =?GBK?B?y+/Mzg==?= <suntaoworks@163.com>
To: xenomai@lists.linux.dev
Subject: how to get the reason why latency too large
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2024 www.mailtech.cn 163com
X-NTES-SC: AL_Qu2aA/qcu0gp5SabY+kZk0YXj+c/W8K1vvsg1YdfPJs0pCT26wM7ckVbLFz31vmNACqtiiKHUhxwz+9TRohjUIv1Db7X4QMOCsLC1JUo6eFJ
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Message-ID: <359099b9.fe1.18e87b8ded8.Coremail.suntaoworks@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:_____wD3_9eoEgZmrl0bAA--.39825W
X-CM-SenderInfo: xvxq3txrzr2yrv6rljoofrz/1tbiTxmvYmXAlIeP5QAGsB
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

RGVhciBhbGwsCkkgYW0gbmV3IHRvIHN5c3RlbSdzIG9wdGltaXphdGlvbi5JIGdvdCAuL3hlbm9t
YWkvYmluL2xhdGVuY3kgdG9vIGxhcmdlLCBidXQgSSBkb24ndCBrbm93IGhvdyB0byBkZWJ1Zy5M
aW51eCBrZXJuZWwgaXMgdG9vIGxhcmdlIGZvciBtZSxzbyBpcyB0aGVyZSBhbnkgdG9vbCB0byBz
aG93IG1lIHdoaWNoIG1vZHVsZSBjYXVzZXMgc3VjaCA/KG15IGVudmlyb25tZW4gaXMgOmxpbnV4
IGtlcm5lbCA1LjEwK2RvdmV0YWlsK3hlbm9tYWkzLjIueKOsQ1BVIGlzIEoxOTAwKQpUaGFua3Mu

