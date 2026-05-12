Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF8B3CC7CC
	for <xenomai@lists.linux.dev>; Tue, 12 May 2026 16:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778602847; cv=none; b=glMXjDgbsjUAVVi2E6Ii7op2OrIIJuQj5q92Fd6UJTbLKd9ZAeo33CJOELTPdmbdwZ6mRpSHho33YY+yEvsFHudkCsHVazDP+KMH3H5H4pcJLThoMZHeanF9Yi9BqjvLSUsRbIAbCUKBC78GX2SgFRW2MTl1HbsfNIwKx1oui/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778602847; c=relaxed/simple;
	bh=WXM7h99GcYYcB8+fS0SFjoMtPI54v6gIqfMwaj3ENOE=;
	h=From:To:MIME-Version:Date:Subject:Message-ID:Content-Type; b=KAtLG/WYogDT712RBuic8U9S5p6BKu3rVapNEJD6I3/23dfdb7JELMOzH8IaExiJMSxNPdqoTltL03gRze3XzB38uJCjQWScRni0xqdXltkWdfOVsq8Eq3PozmKyXbmZ74GJk9K09EcXm6bwXCg1w0VSgVFPfFYkKupRIRRh9/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thom.fr.eu.org; spf=pass smtp.mailfrom=thom.fr.eu.org; dkim=permerror (0-bit key) header.d=thom.fr.eu.org header.i=@thom.fr.eu.org header.b=SBr19kUm; arc=none smtp.client-ip=212.27.42.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thom.fr.eu.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thom.fr.eu.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=thom.fr.eu.org header.i=@thom.fr.eu.org header.b="SBr19kUm"
Received: from mail.thom.fr.eu.org (unknown [82.64.149.25])
	by smtp6-g21.free.fr (Postfix) with ESMTPS id 3A473780502
	for <xenomai@lists.linux.dev>; Tue, 12 May 2026 18:20:41 +0200 (CEST)
Authentication-Results: smtp6-g21.free.fr;
	dkim=permerror header.d=thom.fr.eu.org header.i=@thom.fr.eu.org header.a=ed25519-sha256 header.s=default header.b=SBr19kUm;
	dkim-atps=neutral
Received: from localhost ([127.0.0.1])
	by mail.thom.fr.eu.org (8.15.2/8.15.2/Debian-22+deb11u3) with ESMTP id 64CGKdBr1839009
	for <xenomai@lists.linux.dev>; Tue, 12 May 2026 18:20:39 +0200
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/simple; d=thom.fr.eu.org;
	s=default; t=1778602839;
	bh=WXM7h99GcYYcB8+fS0SFjoMtPI54v6gIqfMwaj3ENOE=;
	h=From:To:Date:Subject;
	b=SBr19kUmWFVHFZuEsh7liDe4PF0ryZJB29M09klhj6u23Yt5B83nN3IYl0vlQ2fbA
	 IUcJ/Hg9rMkQ+UQdSpqMvgwn35kO+0pcpGXgYec/5wVhUVSQ5oL3IvQawGHQ4uEAR/
	 mcwnwYwaWEtYKM2Z1HFJeJj6Bl0NfBEudpPV+pr5KNCg6nnuim2OfN3FgSWoRrRAc/
	 gmM52f3Jffb64Ag1fqRawSjmNig0jGWQEYeUqb/rHMV55kGxxNX2tUoDkrJEo4gPWM
	 a91HKsSKE0hE207WbYX4HmdcgnOt/Fdn8S7cK2uuxgFDw550QewjY1keinXBQCSpoJ
	 LcS19qcDF3EgA==
From: =?utf-8?q?Fran=C3=A7ois_Legal?= <devel@thom.fr.eu.org>
To: "xenomai" <xenomai@lists.linux.dev>
User-Agent: SOGoMail 5.0.1
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Tue, 12 May 2026 18:20:39 +0200
Subject: Getting time in realtime kernel driver
Message-ID: <131f-6a035380-221-a70b1c0@235187577>
X-Forward: 80.13.28.252, 194.9.100.114
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 0.103.10 at tls-srv-03
X-Virus-Status: Clean

Hello,

I think I already asked about the same question some time ago, but I th=
ink I did not get a working answer, so here I am again.

On xenomai 3.2 + Ipipe (linux 5.4), I need to be able to get in a RT dr=
iver the current linux wall clock (impacted from NTP or PTP).
I found out I get the correct value with ktime=5Fget=5Freal=5Fts64. Was=
 willing to use =5F=5Fktime=5Fget=5Freal=5Fseconds but this one is not =
precise enought for my application.

So my question is : is it safe to use ktime=5Fget=5Freal=5Fts64 from wi=
thin an RT driver ioctl function, and if not, which API in xenomai give=
s the exact same time as this one ?

Thanks

Fran=C3=A7ois

