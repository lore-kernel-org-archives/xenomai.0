Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E0642571AD
	for <xenomai@lists.linux.dev>; Mon, 24 Feb 2025 23:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740440504; cv=none; b=eYVFrS6rZtObYolFKwvwhlbkCy/1ZxR92CCQeml5wEUGCF99G3wALVxeuijvN3cfmpQKO2j3TgCeFCqJ5WbPn83pNxn0peJONMzWjm4Lz5yORv0whtw4G80ZPcJs6s2c/70lCKhYBP/8sZ56jEL0lgHw2w/LO9892amOJKhN6Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740440504; c=relaxed/simple;
	bh=Azo31p8oYb53333sFLb5ZVt61h2QiT6V3zOSOzUIyEQ=;
	h=Date:From:To:Subject:Content-Type:MIME-Version:Message-ID; b=CSgFEfCupcjiRBj+k95NrTSCGDm5AACzC0n2qDZOfyy3pJsJ+/k/GazLdWd8pl5nVlEgc8WdxV7uKYEnr7od7UGQN+f8qbgci6Na3XhPSYOkL5QjgtTcSxg8vUBzvTNfQbc9BneS2DEKfALNxU83VxsvZJitmION801ahuexdvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=hEbY+wZc reason="signature verification failed"; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="hEbY+wZc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=LgjiNtWLyv94ItfYcbNkKODkhtok3m2hfd3VYJt1hM0=; b=h
	EbY+wZc2A6sNRUhOfFvs9HTJq4rDwyQPQbLXIQVmvMApCnj/Umi/GDdoR85xHBqQ
	TWVWeE1A3pZv0xqxu7SF5usjd3CgW/yh2KnCvvPdvRE9Gx3ZzFhpqLu1yCySb2so
	Ta+Iz+8ayd1Ycl7iuYibcW5ciwn7JX1zmpWLKZyXho=
Received: from jerryjun123$163.com ( [116.30.125.175] ) by
 ajax-webmail-wmsvr-40-136 (Coremail) ; Tue, 25 Feb 2025 07:41:36 +0800
 (CST)
Date: Tue, 25 Feb 2025 07:41:36 +0800 (CST)
From: JerryJun <jerryjun123@163.com>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: CXP -- migrating from alchemy to evl
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20240801(9da12a7b)
 Copyright (c) 2002-2025 www.mailtech.cn 163com
X-NTES-SC: AL_Qu2fAvifv0wi4COQZ+kfm0gag+05XMa3vf4v2Y9XP598jCnr3Acxb0FMBljazt+OFT6rrheYdxVr991bRphpZ7oNcwSRTJ/iVrN35+QghuLNdg==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Message-ID: <228ce6ee.15f.1953a566904.Coremail.jerryjun123@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:iCgvCgB3fqiwA71nyDZwAA--.41670W
X-CM-SenderInfo: xmhu25pmxqijqt6rljoofrz/1tbiUgT9LGe8+5zFqAABsX
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CmhpIHhlbm9tYWk6CldlIGhhdmUgcmVjZW50bHkgYmVlbiBkb25lIHRlc3RzIG9uIEVWTChYZW5v
bWFpIDQpIGFuZCBoYXZlIHJlY2VudGx5IGxlYXJuZWQgYWJvdXQgdGhlIENYUCAoQ29tbW9uIFhl
bm9tYWkgcGxhdGZvcm0pLgphcmUgdGhlcmUgYW55IHNwZWNpZmljIHBsYW5zIHJlZ2FyZGluZyB0
aGUgQ1hQPwpXZSB3b3VsZCBsaWtlIHRvIGtub3cgaWYgdGhlcmUgaXMgYSBzbW9vdGggbWlncmF0
aW9uIGRvY3VtZW50wqBmb3IgbWlncmF0aW5nIHRoZSBuYXRpdmUgWGVub21haSBpbnRlcmZhY2Us
CnRoZSBBbGNoZW15IEFQSSwgdG8gWGVub21haSA0LiBGb3IgZXhhbXBsZSwgc29tZXRoaW5nIHNp
bWlsYXIgdG8gIk1pZ3JhdGluZyBmcm9tIFhlbm9tYWkgMi54IHRvIDMueC4iwqA=
