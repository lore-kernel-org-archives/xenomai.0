Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DFBA50AC24
	for <xenomai@lists.linux.dev>; Fri, 18 Sep 2026 15:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789745006; cv=none; b=LtgN9JHISRf4k+/nrzpu5RnP9zdS8F94NHCdm73ppnWA0DCZaS7lQQVs8/6/1kiYPgkl2EeMHh9dq3+lbNMEqYFscLSd5cPMLyfcG7hbBETE3UfFNRT2TBh0E/GZ6crWArvVJjAkDfO5vUykEK0ogT1xdiV6Pb7Mvxrr0cixYdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789745006; c=relaxed/simple;
	bh=CVz9ir2pElNhuVDqMzf+lg4fet9/gjYSZUboV6wXll0=;
	h=From:To:MIME-Version:Date:Subject:Message-ID:Content-Type; b=pD0l3momxzgjevAFHAwYVLgkPgBxWAzgEcpsleQn3wFomUE9k0KB2jTA/AJxQkA7N3JD8S0PgZGL7sZrJ2hj5pM+VCSYNFeNtu7s86BqpEO7hUs52AcOKedqNDULZRo2tbLu/BNFdg32qilnh0Eocez/3iPVIoCl2+rMBl2HVTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eventlab.fr; spf=pass smtp.mailfrom=eventlab.fr; dkim=permerror (0-bit key) header.d=eventlab.fr header.i=@eventlab.fr header.b=ZUwz2LuB; arc=none smtp.client-ip=212.27.42.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eventlab.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eventlab.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=eventlab.fr header.i=@eventlab.fr header.b="ZUwz2LuB"
Received: from mail.thom.fr.eu.org (unknown [82.64.149.25])
	by smtp6-g21.free.fr (Postfix) with ESMTPS id C983C780515
	for <xenomai@lists.linux.dev>; Fri, 18 Sep 2026 17:23:19 +0200 (CEST)
Authentication-Results: smtp6-g21.free.fr;
	dkim=permerror header.d=eventlab.fr header.i=@eventlab.fr header.a=ed25519-sha256 header.s=default header.b=ZUwz2LuB;
	dkim-atps=neutral
Received: from localhost ([127.0.0.1])
	by mail.thom.fr.eu.org (8.15.2/8.15.2/Debian-22+deb11u3) with ESMTP id 68IFNIiH3768580
	for <xenomai@lists.linux.dev>; Fri, 18 Sep 2026 17:23:19 +0200
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/simple; d=eventlab.fr;
	s=default; t=1789744999;
	bh=CVz9ir2pElNhuVDqMzf+lg4fet9/gjYSZUboV6wXll0=;
	h=From:To:Date:Subject;
	b=ZUwz2LuBh5tu36poV1uYb3brxzWd0WBq8B/4jEvNQwr+H3E3fAk96sv3J+c024h+i
	 T55cIBFBcKEwGvw0pCLYxSZCzicrNil7qMdMPwQvA7NC01sFtP/SVbMe1afR2wkj9i
	 bicuD0fCwQHTQ/hbeizCZT6unESAMQ02jrZAKWuQb5OK1HweL2r/B1BRYsLCbEzHkF
	 BCq1T48r8aAOh6l4//mp/K+HTK8NG+yUaUlcdo0CbJwY2ek1ponoDjOGTvpwi1FNxg
	 BZpyM56GOSIxK6MF+syYsrKGm1hVjD1b33/JSXj0gdEV1Dz1KfRiuHlWcC1KUEgmTm
	 uhK7BVGpaUJ/Q==
From: =?utf-8?q?Fran=C3=A7ois_Legal?= <francois.legal@eventlab.fr>
To: xenomai@lists.linux.dev
User-Agent: SOGoMail 5.0.1
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Fri, 18 Sep 2026 17:23:18 +0200
Subject: RTDM Monotonic clock diverging from userland monotonic clock
Message-ID: <1209-6aad5780-37-5a2d1100@173656648>
X-Forward: 217.109.173.233, 194.9.103.72
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 1.4.3 at tls-srv-02
X-Virus-Status: Clean

Hello,

working on a xenomai 3.2 + linux 5.4 platform using network packets tim=
estamping in kernel, I need to compare the network packets timestamp (r=
etrieved with rtdm=5Fclock=5Fread=5Fmonotonic()) to userland monotonic =
clock (clock=5Fgettime(CLOCK=5FMONOTONIC, & time).

This seem to work fine when no network time synchronisation is used, bu=
t whenever I start a PTP time sync daemon on the platform, the time fro=
m kernel and from userland start to diverge quickly.

I'm surprised because clock monotonic should not be modified by time sy=
nchronisation scheme.

Can anybody help me ?

Thanks in advance

Fran=C3=A7ois

