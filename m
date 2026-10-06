Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D15E26AA91
	for <xenomai@lists.linux.dev>; Tue,  6 Oct 2026 07:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791270575; cv=none; b=dsQVl7hY745yfDnZ+r5qIxfLUxJRDGStMdlcu52X2+LnCi9O+BkZGj93tgEG3a01WS0gB5LwQxzyFOTd/99abZSzqzw/SElc5bYR8yDZtk25sWi722tcnp/dpZNrEW4qrn1fzm0GlXG1mdmk0y8wK3xpYKSGkiI6dbdwB1qWkVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791270575; c=relaxed/simple;
	bh=F7Pn2KikjirEXY+yq7v1pSOhLfrCqYqJa+ZDxpMpSCo=;
	h=From:To:MIME-Version:Date:Subject:Message-ID:Content-Type; b=gfCJooibeZDp6238MYzoYaIjGKQxvnCe+i+1nHtLftV/O16NoYol4rYucM6OEMwcMbnAxVgGxmrt9Gs7rqzHnK0BrdpjIiLXeiZ/xcVbcxU8jdzkwTSoECUV3f8l4ubGOHOWvcgKQaaB2gwRH1xDBzwdOwY7YqMkcgBBkSCjdS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eventlab.fr; spf=pass smtp.mailfrom=eventlab.fr; dkim=permerror (0-bit key) header.d=eventlab.fr header.i=@eventlab.fr header.b=t5z5HyAq; arc=none smtp.client-ip=212.27.42.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eventlab.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eventlab.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=eventlab.fr header.i=@eventlab.fr header.b="t5z5HyAq"
Received: from mail.thom.fr.eu.org (unknown [82.64.149.25])
	by smtp6-g21.free.fr (Postfix) with ESMTPS id 35632780107
	for <xenomai@lists.linux.dev>; Tue,  6 Oct 2026 09:09:30 +0200 (CEST)
Authentication-Results: smtp6-g21.free.fr;
	dkim=permerror header.d=eventlab.fr header.i=@eventlab.fr header.a=ed25519-sha256 header.s=default header.b=t5z5HyAq;
	dkim-atps=neutral
Received: from localhost ([127.0.0.1])
	by mail.thom.fr.eu.org (8.15.2/8.15.2/Debian-22+deb11u3) with ESMTP id 69679RYe388639
	for <xenomai@lists.linux.dev>; Tue, 6 Oct 2026 09:09:28 +0200
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/simple; d=eventlab.fr;
	s=default; t=1791270568;
	bh=F7Pn2KikjirEXY+yq7v1pSOhLfrCqYqJa+ZDxpMpSCo=;
	h=From:To:Date:Subject;
	b=t5z5HyAqUSuKSw37rYbdHBcDDlA9fQCZC14WCjpF2Hve2QnKgnQ90bTU+sU5HMgCu
	 DJCDQeQmGkvmKwmPDS4/QruwQVGhR42vW9/155LJ4NKvKF/MYq5Ji5uDHGPTB6jRmD
	 pw4bw9c3iWCjB9VYqG9qLvKtZpshWDXn8WCs4vgRiln7v7Z5SAjJT0rRCarru0iTei
	 z03L0oC7kfQ0VZ5kxhduv1+tYq00JuQYyLZBXi/afGpFBDL2SV/Fhs32bM7SgqFrNp
	 ZtkzibS4aKJ/5M3uTJRdNRm11XkxJf5ZFPHDD8PVxfsFpsuTY0bVfobZO5fNcnd6ja
	 ynPnQCjuWkLEw==
From: =?utf-8?q?Fran=C3=A7ois_Legal?= <francois.legal@eventlab.fr>
To: xenomai@lists.linux.dev
User-Agent: SOGoMail 5.0.1
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Tue, 06 Oct 2026 09:09:27 +0200
Subject: Issue using recvmsg
Message-ID: <1208-6ac49e80-43-2c92e940@166990351>
X-Forward: 217.109.173.233, 194.9.103.72
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 1.4.3 at tls-srv-02
X-Virus-Status: Clean

Hello,

still porting my system from Xenomai 3.2 + linux 5.4 Ipipe to Xenomai 3=
.3 + linux 6.12 dovetail, I'm having what looks like a weird build issu=
e :
I'm using the recvmsg call to get network message + ancillary data. On =
my new system, it returns -1 + errno set to 88 (ENOTSOCK). So I dug a l=
ittle, and it happens that recvmsg64 gets called, which does not seem t=
o be wrapped by libcobalt to xenomai SC.

The fix for this is decorating the recvmsg call with a =5F=5FRT() or =5F=
=5FCOBALT() macro

Is it expected ?

Fran=C3=A7ois

