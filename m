Received: from smtpfb1-g21.free.fr (smtpfb1-g21.free.fr [212.27.42.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C5F17BB30
	for <xenomai@lists.linux.dev>; Thu, 26 Sep 2024 10:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727345510; cv=none; b=HP4anjy0cVrcLRDda3QFOKXGJr062QsjjNmp1R3EAn2ylqDNTLY8id3dG0RUUbEUboS93vI4mma4bW7t0DcisStkNX8/DLTfq8iVvdAOZYUhnwFQ2jduhEfxGiFEcUgbv6Wcsw0vT/uKj+8uZHqfN7LMV0f7ycdmWm+7JJQXUI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727345510; c=relaxed/simple;
	bh=CyS6GDMnIMs77nU4hRrLVCVw/oaGoKTPdMlUo0wC+PI=;
	h=From:To:MIME-Version:Date:Subject:Message-ID:Content-Type; b=mqB3HZy8ABqgoascGm0sdLlvlh1XNPFxB6Bgt/iyI25/tJLfB/uPas7TvSSq3ISxvuPKm0KK4H8ofpVvf+iMagDAWiNZkGN4K3qx+nOxEFyevRhOVJxF5UnhtARlr+TMRLuZwhZFkCjobf9fIjuVclV+jrkviiMcqAj4ciEq1uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thom.fr.eu.org; spf=pass smtp.mailfrom=thom.fr.eu.org; dkim=permerror (0-bit key) header.d=thom.fr.eu.org header.i=@thom.fr.eu.org header.b=EjfX3U1+; arc=none smtp.client-ip=212.27.42.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thom.fr.eu.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thom.fr.eu.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=thom.fr.eu.org header.i=@thom.fr.eu.org header.b="EjfX3U1+"
Received: from smtp5-g21.free.fr (smtp5-g21.free.fr [212.27.42.5])
	by smtpfb1-g21.free.fr (Postfix) with ESMTP id 7EC7CDF825C
	for <xenomai@lists.linux.dev>; Thu, 26 Sep 2024 12:03:15 +0200 (CEST)
Received: from mail.thom.fr.eu.org (unknown [82.64.149.25])
	by smtp5-g21.free.fr (Postfix) with ESMTPS id 87F3F60128
	for <xenomai@lists.linux.dev>; Thu, 26 Sep 2024 12:03:08 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mail.thom.fr.eu.org (8.15.2/8.15.2/Debian-22+deb11u3) with ESMTP id 48QA36eU246722
	for <xenomai@lists.linux.dev>; Thu, 26 Sep 2024 12:03:07 +0200
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/simple; d=thom.fr.eu.org;
	s=default; t=1727344987;
	bh=CyS6GDMnIMs77nU4hRrLVCVw/oaGoKTPdMlUo0wC+PI=;
	h=From:To:Date:Subject;
	b=EjfX3U1+imb33Xs29E7UPtVHfN7mMqRwE+NiKg5Pn7CopzK1VvjPMCCgQS2E+5XGZ
	 6jI/oCD3EoV1rrwiOqxg8zPuPAFo6vJU5R0KJwYb1CckHLYWDMTRPFhlOCudAEttTC
	 eahSZMr9WnOXX+ghUqxIDw5m43HqncjmvX3gdDmc8s8nYWPaabclEGjGclHfzQl+ZI
	 k7YROV6c2i9pEsWLWd6Ciyc3KL+b3i4h0QV8RDhGZf/RtEolLPGCEEG4whqLz02w+E
	 lSobVX183ZknUtqfMN1hilS6dY0JCSpjzdlbSUDhHn/ua+6KLYEV6PYzvh0gaFJtqI
	 Y8E7prKTPFM/w==
From: =?utf-8?q?Fran=C3=A7ois_Legal?= <francois.legal@thom.fr.eu.org>
To: xenomai@lists.linux.dev
User-Agent: SOGoMail 5.0.1
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Thu, 26 Sep 2024 12:03:06 +0200
Subject: Get wallclock time from rtdm driver
Message-ID: <10db-66f53180-5-49b09a80@50985025>
X-Forward: 217.109.173.233, 147.161.180.114
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 0.103.10 at tls-srv-03
X-Virus-Status: Clean

Hello,

in my driver, I need to get the current wallclock value. I tried rtdm=5F=
clock=5Fread, but this seems to be the boot clock and not the wallclock=
 (the one that is updated by ntp/...)

What shall I use to get the actual wallclock value from my rt drivers (=
the equivalent from clock=5Fgettime (CLOCK=5FHOST=5FREALTIME)) ?

Thanks in advance

Fran=C3=A7ois

