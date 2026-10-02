Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3BA38D686
	for <xenomai@lists.linux.dev>; Fri,  2 Oct 2026 15:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790953928; cv=none; b=OKX3m+me8JbMOABFJDXq67aB0W5nnH1BxUs3CpX7XCun8SZoEyJSHztRm/qw94imG+1TYH1K/gPp42tgLSqKwCM1jU/B+Lg0TFfU/3ixd9iaR0WJN5T9ck4nYZ3IGTNLVDTMDm9asxvHqGC8+/tN1C7RoesI9wC8jovKasoFeeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790953928; c=relaxed/simple;
	bh=mwUVK1PITb88Q8nhCdbR8Lk7DorA6ZsGjs2gmIoB+3M=;
	h=From:To:MIME-Version:Date:Subject:Message-ID:Content-Type; b=tS7PFoz2MH57sX7flafVVzQo3nXlDnX2lyrQBJ1wW3nktKuaD68ERQ1UJ0GglXVHj8v/+nNY7tvGF7DpLH2xHv8h9/WdDCYIPISEZMv+vWUTUixnFp2LJTyXi5n1n65eD5YAtBEoipw2bDG7SX2s4lWBQcAgQv0XJDu02k2m6v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eventlab.fr; spf=pass smtp.mailfrom=eventlab.fr; dkim=permerror (0-bit key) header.d=eventlab.fr header.i=@eventlab.fr header.b=SPJGWw9T; arc=none smtp.client-ip=212.27.42.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eventlab.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eventlab.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=eventlab.fr header.i=@eventlab.fr header.b="SPJGWw9T"
Received: from mail.thom.fr.eu.org (unknown [82.64.149.25])
	by smtp6-g21.free.fr (Postfix) with ESMTPS id B4554780371
	for <xenomai@lists.linux.dev>; Fri,  2 Oct 2026 17:12:01 +0200 (CEST)
Authentication-Results: smtp6-g21.free.fr;
	dkim=permerror header.d=eventlab.fr header.i=@eventlab.fr header.a=ed25519-sha256 header.s=default header.b=SPJGWw9T;
	dkim-atps=neutral
Received: from localhost ([127.0.0.1])
	by mail.thom.fr.eu.org (8.15.2/8.15.2/Debian-22+deb11u3) with ESMTP id 692FBxL7222984
	for <xenomai@lists.linux.dev>; Fri, 2 Oct 2026 17:11:59 +0200
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/simple; d=eventlab.fr;
	s=default; t=1790953919;
	bh=mwUVK1PITb88Q8nhCdbR8Lk7DorA6ZsGjs2gmIoB+3M=;
	h=From:To:Date:Subject;
	b=SPJGWw9T2rDiUESaS/tISj20oxggSLJhxMdg+5hoUNMD+tnp/vhrawux8MEgiREI9
	 mvx6dQ+XOfipEL5h0cGm7Q4U28oczHBILdIl3XjkTDdMypEAuf1tQdjFTlone9gTPU
	 Dp2O135HfanSjGrk3RE7P+MaaWOaWYwuM7z765xk2licOFBTBPIoVGo0QKBfBf8/e0
	 waXzcC9jda1VwHv4aNuVRE7IJg/LSrGeNLN++p2x9jyvdZ92b+c2Ntho+xjJsl3O/d
	 QzhdiYpjwQwPITiEHXnOdm2Jqv3iPixVQCZoCfqqffUQkP/D0ic5X64RE/r8R4PESn
	 s+tHmrd59Jjkg==
From: =?utf-8?q?Fran=C3=A7ois_Legal?= <francois.legal@eventlab.fr>
To: xenomai@lists.linux.dev
User-Agent: SOGoMail 5.0.1
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Fri, 02 Oct 2026 17:11:59 +0200
Subject: Problem with timer on zynq 7000 platform
Message-ID: <1209-6abfc980-4f-5a2d1100@131627188>
X-Forward: 217.109.173.233, 194.9.103.72
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 1.4.3 at tls-srv-02
X-Virus-Status: Clean

I ended up switching to Xenomai 3.3 + dovetail (linux 6.12 for now) to =
fix my monotonic clock diverging between userland and kernel.

But now another problem arises. I'm using posix timer to trig certain a=
ctions. And since the switch, those actions don't fire any more.
For example, if I set up a timer to fire at next second, it does not. C=
hecking /proc/xenomai/timer/coreclk, I kind of see something happen :
CPU  SCHED/SHOT            TIMEOUT     INTERVAL    NAME
0    294672/247088         3ms253us    -           [host-timer/0]
0    6/0                   -           -           [watchdog]
1    227779/211523         3ms247us    -           [host-timer/1]
1    38/0                  -           -           [watchdog]
1    1/0                   4789309920  949011081s  cobalt=5Ftimer=5Fhan=
dler

I guess the last lime correspond to my timer, but the timeout does not =
really match my expectation, and the interval should be 0.

It looks like I'm having a time vs time64 issue, but I not sure how to =
get through this.

Fran=C3=A7ois

