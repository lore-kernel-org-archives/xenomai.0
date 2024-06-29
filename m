Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18A878C83
	for <xenomai@lists.linux.dev>; Sat, 29 Jun 2024 13:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.40.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719668731; cv=none; b=qh6hWCPawtskV3oJKQvCUyjgnq6kpTIw/46fVvTK3bC2jSxifIDl+I+h0pJY8HJKJU8OuQnvYoa7uPNMpSNeoqseRAG/3nF2k38/vvc3BU31fp6WJwNehDbXIZZVMKfmIxmmPe5gs6vACEKg7BueIREwZ8aKPJ5JKtlgNHkK3Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719668731; c=relaxed/simple;
	bh=HZ7W+0wqDAZqTS/7w29xpbB4GmSTDNdi3d6Sr0xVNbQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H7HTsDK6095NHwmJnTUcn5pCVdKEyIuQMHSEKi9dSdl655g2vGbsYFs7+3sZCyr/hdsSn8jGkj9H7fcyFuEaJxBisn2Cjfirp63TKwZ5opRJr/UGfTbIhsPoeyr+HdoLrdmL/WzSnYD4KkfAqioEHuT7RoIwsZOI70w+R9F1b1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=195.201.40.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 2DEB361966A2;
	Sat, 29 Jun 2024 15:45:20 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id AfN2OrdVVDOc; Sat, 29 Jun 2024 15:45:19 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id C40D861966BC;
	Sat, 29 Jun 2024 15:45:19 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ESmxZvZl0HA0; Sat, 29 Jun 2024 15:45:19 +0200 (CEST)
Received: from foxxylove.corp.sigma-star.at (unknown [82.150.214.1])
	by lithops.sigma-star.at (Postfix) with ESMTPSA id 7F3DC61966A2;
	Sat, 29 Jun 2024 15:45:19 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: xenomai@lists.linux.dev
Cc: upstream+xenomai@sigma-star.at,
	Richard Weinberger <richard@nod.at>
Subject: [PATCH 4/5] doxygen: Remove generated config file up make clean
Date: Sat, 29 Jun 2024 15:45:03 +0200
Message-Id: <20240629134504.11148-5-richard@nod.at>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240629134504.11148-1-richard@nod.at>
References: <20240629134504.11148-1-richard@nod.at>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 doc/doxygen/Makefile.am | 1 +
 1 file changed, 1 insertion(+)

diff --git a/doc/doxygen/Makefile.am b/doc/doxygen/Makefile.am
index 964dfdf44..c897fdcc0 100644
--- a/doc/doxygen/Makefile.am
+++ b/doc/doxygen/Makefile.am
@@ -1,6 +1,7 @@
 HTML_DOCS =3D html/xeno3prm html/xeno3prm/search
 PDF_DOCS  =3D xeno3prm.pdf
 EXTRA_DIST =3D xeno3prm-common.conf.in xeno3prm-html.conf.in xeno3prm-la=
tex.conf.in
+CLEANFILES =3D xeno3prm-common.conf xeno3prm-html.conf xeno3prm-latex.co=
nf
=20
 if XENO_BUILD_DOC
=20
--=20
2.35.3

