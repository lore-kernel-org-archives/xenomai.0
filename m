Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFFC617A2F7
	for <xenomai@lists.linux.dev>; Wed, 21 May 2025 15:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747839688; cv=none; b=Q8rQljQKp2zwS5crVWekvwuHNToIhDcSX4lWsOqEeMyPFn/unpngfWp+RvmN9Hr+Xv8KqH/snBijOZiioWw2cRps+HE6L6E45j4/1j2FwrDoATaDw7G4uANFvOA39PdjzxsZrgRB2TWheWrenzJH+jj0BarvlbzqOrkBN0PdeSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747839688; c=relaxed/simple;
	bh=3+7fFSngKE8VFPQE/HVQLDSCmiecRQpwDkkvkR8dK7A=;
	h=Date:From:To:Cc:Subject:Content-Type:MIME-Version:Message-ID; b=rKIx0V7qSqbTsVxZBW3Y5LXnZeC9mAYxbzHCioaMcJX6IKolvsOnsdZzVEpauyQfCeL/KCPKbSsEZwWHa3dp8rHN2PdrWqgB3LAGdk4TdO+Go0eisepzATH291T1ATbTedppvwnKtxwiEoPQhqosEq8NR2o0Hd4G1qbhvBc2sIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=Memnc1aq reason="signature verification failed"; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="Memnc1aq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=xCTgSF4jIe1iNkVNm7n/SZSwZXXAuWdrZKM/aOCl/is=; b=M
	emnc1aqYccfGCPlBV8TuCQ/5Bzp2byn+wZCA4gbjo+YbJGBhteMb2R/xwnbNYCGE
	8H2PY8I6Cw59LJeNkUbKh52BRqR0Kq42EoH8FHOgRj+uiG6ph19ak6YmglaKM+Q9
	tSu8DqbOjNM5T8T/YKlFFjFU4gCmf4uMPQwkKCb7NQ=
Received: from aspirestro$163.com (
 [2409:8a00:1890:1854:90eb:5d35:3ae8:effb] ) by ajax-webmail-wmsvr-40-140
 (Coremail) ; Wed, 21 May 2025 23:01:19 +0800 (CST)
Date: Wed, 21 May 2025 23:01:19 +0800 (CST)
From: "Haiyang He" <aspirestro@163.com>
To: "Jan Kiszka" <jan.kiszka@web.de>
Cc: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Feedback on https://v3.xenomai.org/tips/porting-posix/
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20240801(9da12a7b)
 Copyright (c) 2002-2025 www.mailtech.cn 163com
X-NTES-SC: AL_Qu2fBfSYtk4s7yedY+lS3DJA/oVlJbXT05dalP4Ad+4hty/Sxi8yc0BhGlXK+sONZf+cJHstoEN4KAnRb25c
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Message-ID: <a985855.ac8e.196f35cfd11.Coremail.aspirestro@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:jCgvCgD3v_vA6i1opSwKAA--.55882W
X-CM-SenderInfo: pdvsx2xhvw20i6rwjhhfrp/xtbBYwBUcWgt0QiUxAAKsA
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CkRlYXIgWGVub21haSBQcm9qZWN0IFRlYW0sCgpJIHJlY2VudGx5IHZpc2l0ZWQgdGlwcy9wb3J0
aW5nLXBvc2l4IHBhZ2UgYW5kIHdhcyByZWFkaW5nIHRocm91Z2ggdGhlIGNvbnRlbnQuCgpTb21l
IGNvbnRlbnQgb24gdGhlIHdlYnBhZ2UgbWF5IG5vdCBiZSBjb25zaXN0ZW50IHdpdGggdGhlIFhl
bm9tYWkgc291cmNlIGNvZGVzLgoKMS4gIkZvciBtb3JlIGluZm9ybWF0aW9uIHRyeSB3cmFwLWxp
bmsuc2ggqENoZWxwLiIKCndyYXAtbGluay5zaCBkb2VzIG5vdCBzdXBwb3J0ICItaGVscCIgYXJn
LGFuZCByZXBvcnQ6Cgp3cmFwLWxpbmsuc2g6IDIxMjogLWhlbHA6IG5vdCBmb3VuZAoKMi4gIlhl
bm9tYWkgY29tcGlsYXRpb24gZmxhZ3MgZGVmaW5lIGEgcHJlcHJvY2Vzc29yIG1hY3JvIChfX1hF
Tk9fXykgd2hpY2ggYWxsb3dzIHlvdSB0byBrbm93IHdoZXRoZXIgb3Igbm90IHlvdSBhcmUgY29t
cGlsaW5nIHRoZSBhcHBsaWNhdGlvbiBmb3IgWGVub21haS4iCgpUaGUgb3V0cHV0IG9mICJ4ZW5v
LWNvbmZpZyAtLWNmbGFncyAtLXNraW49cG9zaXgiIGRvZXMgbm90IGNvbnRhaW4gbWFjcm8gKF9f
WEVOT19fKS4KCiQgREVTVERJUj1gcHdkYCB1c3IveGVub21haS9iaW4veGVuby1jb25maWcgLS1j
ZmxhZ3MgLS1za2luPXBvc2l4Ci1JL3Jvb3QveGVub21haS94ZW5vbWFpLXYzLjIuNC1pbnN0YWxs
L3Vzci94ZW5vbWFpL2luY2x1ZGUvY29iYWx0IC1JL3Jvb3QveGVub21haS94ZW5vbWFpLXYzLjIu
NC1pbnN0YWxsL3Vzci94ZW5vbWFpL2luY2x1ZGUgLW1hcmNoPWFybXY4LWEgLURfR05VX1NPVVJD
RSAtRF9SRUVOVFJBTlQgLWZhc3luY2hyb25vdXMtdW53aW5kLXRhYmxlcyAtRF9fQ09CQUxUX18g
LURfX0NPQkFMVF9XUkFQX18KCjMuICJUbyBnZXQgeW91ciBhcHBsaWNhdGlvbiB0aHJlYWRzIHRv
IGJlIHJlYWxseSBjb25zaWRlcmVkIGFzIHJlYWwtdGltZSB0aHJlYWRzIGJ5IFhlbm9tYWkgc2No
ZWR1bGVyLCB5b3Ugd2lsbCBoYXZlIHRvIGdldCB0aGVtIHRvIHVzZSB0aGUgcmVhbC10aW1lIHNj
aGVkdWxpbmcgcG9saWN5IChjYWxsZWQgU0NIRURfRklGTykuICIKCkkgY2hlY2sgdGhlIGNvYmFs
dF9zY2hlZF9wb2xpY3lfcGFyYW0oKSBmdW5jdGlvbiwgc2NoZWRfY2xhc3MgaXMgeG5zY2hlZF9j
bGFzc19ydCBmb3IgYm90aCBTQ0hFRF9GSUZPIGFuZCBTQ0hFRF9SUi4KCgpCUiwKSGFpeWFuZyBI
ZS4KCg==
