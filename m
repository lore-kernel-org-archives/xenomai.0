Received: from smtpfb1-g21.free.fr (smtpfb1-g21.free.fr [212.27.42.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B2C653365
	for <xenomai@lists.linux.dev>; Mon,  1 Jul 2024 06:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719816914; cv=none; b=jylOrlXAPpevjBNxWBz72I2byp5OadNg7ky1mcQ6WQ6JUjhA0hhPtzIhyCHwcBhfZklMjaMLyl7GdcjYjCH9XmNHkvpnqoCZrHVDEZx/0kJD2e4U2hMYdJQFFCqAfZ+SKDNMHNaLFXkSTjMuOfSUorUrc32tXq5bnW/BmTSC7/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719816914; c=relaxed/simple;
	bh=XmyERkqgIbycZIr1hr9HhXrb0Lg3msKWsCkFvD6s9Ak=;
	h=From:To:MIME-Version:Date:Subject:Message-ID:Content-Type; b=D+Ztk9yvx5W3+xsaJuGi+X4FmQfcBEJo1wijPbtgYhe/n+J7sEmxpq+1uUK6inub1KY8aIXK6vjmKmftvK3GcXEkZR6IILKU1qMkAf8MLMTvvzo3JcGWe+WydLxrzt2ibVZRkCMOsISN0de8UH/cxA60q8KIh+KYTEwUnFjop6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thom.fr.eu.org; spf=pass smtp.mailfrom=thom.fr.eu.org; dkim=permerror (0-bit key) header.d=thom.fr.eu.org header.i=@thom.fr.eu.org header.b=Navmn1ez; arc=none smtp.client-ip=212.27.42.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thom.fr.eu.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thom.fr.eu.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=thom.fr.eu.org header.i=@thom.fr.eu.org header.b="Navmn1ez"
Received: from smtp5-g21.free.fr (smtp5-g21.free.fr [212.27.42.5])
	by smtpfb1-g21.free.fr (Postfix) with ESMTP id 7C08F839118
	for <xenomai@lists.linux.dev>; Mon,  1 Jul 2024 08:48:05 +0200 (CEST)
Received: from mail.thom.fr.eu.org (unknown [82.64.149.25])
	by smtp5-g21.free.fr (Postfix) with ESMTPS id 488F75FF88
	for <xenomai@lists.linux.dev>; Mon,  1 Jul 2024 08:47:58 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mail.thom.fr.eu.org (8.15.2/8.15.2/Debian-22) with ESMTP id 4616lv1j124828
	for <xenomai@lists.linux.dev>; Mon, 1 Jul 2024 08:47:57 +0200
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/simple; d=thom.fr.eu.org;
	s=default; t=1719816477;
	bh=XmyERkqgIbycZIr1hr9HhXrb0Lg3msKWsCkFvD6s9Ak=;
	h=From:To:Date:Subject;
	b=Navmn1ezAB0iC2pzN4ZlgkmyBYiy8u9qWSRoIT7GPnKR4nXkeESf2lrcnDxLRhlPo
	 Blf5r5NrVL6mxA8Rvk7677qHxAi8CvpPMLZCnv1IqIX/dFjJFACzOOFoznxtOHtItF
	 5OfW6QUHSr/w7jQUV7AjnY+GOJMEcLO26Wu9phdjHKEr5G5r0MAWc85vLOOb3RKGYe
	 DLozydqExqzLSxblt1n0o32vOlPSGVjni99XhihADINTrAXItdObeKs8ntgmB5iMYb
	 TQ8tZQqmzkQARmicN8jlgC7L/1LVsVddHQfKJurnzRiwpSlBTmy7ui/Ywr9qN2TDlX
	 gK5eppPQ7GDgg==
From: =?utf-8?q?Fran=C3=A7ois_Legal?= <devel@thom.fr.eu.org>
To: xenomai@lists.linux.dev
User-Agent: SOGoMail 5.0.1
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Mon, 01 Jul 2024 08:47:57 +0200
Subject: Thread safety of cobalt syslog/syslogv call
Message-ID: <10fc-66825100-3-27de53c0@198494754>
X-Forward: 217.109.173.233, 165.225.204.113
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 0.103.10 at tls-srv-03
X-Virus-Status: Clean

Hello,

I was wondering whether or not the syslog/vsyslog calls in cobalt runti=
me libs are thread safe. I observer strange behaviour in my logs under =
heavy log load.

Thanks

Fran=C3=A7ois

