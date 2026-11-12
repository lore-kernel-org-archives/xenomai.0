Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.27.42.6
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794494065;
	b=OINe29fxoUYhU58dpmM+BhEwVJIcMJcvxvfF2DYDTXRmJAfI3z1CF0WbGCmjbN86xDOx
	 S/5HWZO/eOOUSMb/t0Qg5Cwb5y9O98rWV1Qfb7RLyuRL2pfpo3lGcvzKIKlJvg9E+cKt0
	 d5Befn3g/CdaROa+RuveMssmEv6qD51wjbu2k4pd/2ZI2wJiysfIUFceG+pdOX96CvWK+
	 ZXghDM231ceLSgSFRYC87zlU3QAjNosg+sw33HC4JHwxsrgWgrlouYwrD4Ays8EwsX7mQ
	 gwLfAABe+82IKG6I8tGBvRR98KiBhbPFn+KOEmP5IW74Vwis8r2NnktsCqv0HsAmU1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794494065;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:User-Agent:
	 MIME-Version:Date:Subject:Message-ID:X-Forward:Content-Type:
	 Content-Transfer-Encoding:X-Virus-Scanned:X-Virus-Status;
	bh=E7J9vWKPk6v7jVSjCXmpbJGwnG0a+8Tm3mFz7n99j/s=;
	b=0BruAkgkSDjKrYacFhXhzi0z+3Q6+Tj3v0Q4Isoe90KSi6vvgQG2gaeZM6kTEOQJChnk
	 rsEdGTTAWMzfJUmYqMVELkzoGCNu5/0da2M5AuBf74EE9Dh5mnDn1jffPe3rjpWoundHN
	 NoXEJt2O8wrCWVJY37zf48wcgUnUDQSNNg/7b5QkHdTnvvZ4dL/bDZL6ALYAeuXqDyByE
	 1Gw1E+viZEw3BfEj3eL5fh0i+azW2yg9KNv3eMwe54om3A+NN5bTU3hPGuRSSXVjKH+6d
	 vg1WoyRHqkCxtPRbnEF0q/54mRahWcW+vl6sh9yD0T+xcPRussUycjjvWkb1AMQUinw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=eventlab.fr;
	spf=pass smtp.mailfrom=eventlab.fr;
	dkim=permerror header.d=eventlab.fr header.i=@eventlab.fr header.a=ed25519-sha256 header.s=default header.b=abOCfAPb;
	arc=none smtp.remote-ip=212.27.42.6
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB0D606B2F8
	for <xenomai@lists.linux.dev>; Thu, 12 Nov 2026 14:34:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9EB0D606B2F8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eventlab.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eventlab.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror header.d=eventlab.fr header.i=@eventlab.fr header.a=ed25519-sha256 header.s=default header.b=abOCfAPb
Received: from mail.thom.fr.eu.org (unknown [82.64.149.25])
	by smtp6-g21.free.fr (Postfix) with ESMTPS id 1724978035B
	for <xenomai@lists.linux.dev>; Thu, 12 Nov 2026 15:34:15 +0100 (CET)
Authentication-Results: smtp6-g21.free.fr;
	dkim=permerror header.d=eventlab.fr header.i=@eventlab.fr header.a=ed25519-sha256 header.s=default header.b=abOCfAPb;
	dkim-atps=neutral
Received: from localhost ([127.0.0.1])
	by mail.thom.fr.eu.org (8.15.2/8.15.2/Debian-22+deb11u3) with ESMTP id 6ACEYF042914973
	for <xenomai@lists.linux.dev>; Thu, 12 Nov 2026 15:34:15 +0100
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/simple; d=eventlab.fr;
	s=default; t=1794494055;
	bh=Z6s9F7v+/USg/fZgwcmxsHTeCA0YTTk71LLqDiSeAYA=;
	h=From:To:Date:Subject;
	b=abOCfAPbATwngwoCGqD2Te6D08UQr5WlDwRnSdFgJUAcMTqHU1sqnveaU0/UD7Eos
	 Bn5aWJmU+b70xSaRH8YE0hYR3fVlATGYb6Wzd3g2I4jYEgg3kFyORyOpU3dSeQa7Oj
	 US5iAFLqOnUQtfFYrcdErqZmaakUI5CYqSRTFu/E4CUHweUaPwzefw2rH8D5lrrBlw
	 W+zD8qW5Lq1IE8cIEbrqnHRl8XQdekSFyRcnJnSBBrpUiWAhMVuvogicluYd9v6Pny
	 AD8pUmX+26rwe8uEc9Z75vOmjOpZmLvhDcx6iS1/4yyDepsowRAp2kUi22gbPQjBa0
	 vKvpW3NCWQJpg==
From: =?utf-8?q?Fran=C3=A7ois_Legal?= <francois.legal@eventlab.fr>
To: "Xenomai" <xenomai@lists.linux.dev>
User-Agent: SOGoMail 5.0.1
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Post: <mailto:xenomai@lists.linux.dev>
List-Help: <mailto:xenomai+help@lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
List-Owner: <mailto:xenomai+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Date: Thu, 12 Nov 2026 15:34:15 +0100
Subject: New issue with 64 bits wrapper
Message-ID: <115efd-6af5ce80-25-36f80d40@101055092>
X-Forward: 217.109.173.233, 194.9.103.72
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 1.4.3 at tls-srv-02
X-Virus-Status: Clean

Still in the process of porting my app to linux 6.12/x3.3, I've got a b=
uild issue regarding mmap.
Arch is arm.

if I build a function that calls mmap without =5F=5FSTD decoration, it =
gets translated to 
bl	0 <mmap64>
by the compiler.
However, when I use the =5F=5FSTD decoration, it gets translated to
bl	0 <=5F=5Freal=5Fmmap>

which itself fails because the real mmap expects the offset be a 32 bit=
s integer, which is it not.

So I wondering whether the definitions in cobalt/sys/mman.h
COBALT=5FDECL(void *, mmap,
	    (void *addr, size=5Ft length, int prot, int flags, int fd,
	     off=5Ft offset));

#if defined(=5FLARGEFILE64=5FSOURCE) || defined(=5FGNU=5FSOURCE)
COBALT=5FDECL(void *, mmap64,
	    (void *addr, size=5Ft length, int prot, int flags, int fd,
	     off64=5Ft offset));
#endif

should be replaced with

COBALT=5FDECL=5FTIME64(void *, mmap, mmap64,
	    (void *addr, size=5Ft length, int prot, int flags, int fd,
	     off=5Ft offset));


Thanks in advance

Fran=C3=A7ois

