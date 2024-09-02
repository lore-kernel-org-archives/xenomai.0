Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89B6200136
	for <xenomai@lists.linux.dev>; Mon,  2 Sep 2024 13:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725282695; cv=none; b=o5jM+Cd9DGpoiJ9XRCaRwMdwcMuapdn1UTepxTcIJnvW6R4gEw6g7Y1D2cQs0cJfdrndYI1gEs4TrS+hti6LkShQHXMuXZuB1TdpWK/owryW3eNTIoRgDAho8/PFct7ZBDGyEGorYQfMOFpJUywmmMfcSkVyA5FlLCbdneDOnKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725282695; c=relaxed/simple;
	bh=GkGe2MbLAmBgcVqoW5bbBNHTYIb3EzquREFFmZa7HOA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jk/iQzkdo6BKvvnZZ1ZxxlDeTL6j2dcNIbsBPuI7L6sttAr4+7Kl8vlvpPxMENgX0tIxHSd1hk+JbSKdSO0iFVH5Y0067SBk2msBZSfDr5UHowCSGQqVuDio9JkA4yDogOEvxKzkBXvHVTikGtK+AEdfjLY2ba0f19veCsuljN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at; spf=pass smtp.mailfrom=sigma-star.at; dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b=qT5U+4Fl; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b="qT5U+4Fl"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-374ba74e9b6so2058831f8f.0
        for <xenomai@lists.linux.dev>; Mon, 02 Sep 2024 06:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1725282691; x=1725887491; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ygUatbpumzocyN/aWwq4fsKNrUZNnY1PLNHUlk8CfxI=;
        b=qT5U+4FlIggjeQUhGRQdrR327uSOrSC4DaIeaPjZ2PKl1Xbp/hFAY7RYS6h2Ifee2P
         bVWHB4GmrnXw/uBdW6DErOG7HWph1sVPcnkk5UjX2vIvq0QQHFZoRxalSBTvbErIsdcL
         3jDnEFSYEfHsEbZPpXyoxoDVbyry+/UHFZ2q3S8uQ9MJVUrnPo1m4eUPPZiQsa2J9Uv2
         dPqxIlBHFy7zgk7UnRB+78LqrjhXNoyi3pFWuwV4CQ9mX9NqOKBRn1CIF8eB8S5z7sAj
         8fzFGuJ/q618aV7bMVnTNq+9RqT60R0q52kwYkSmaT4B4c2zGNCU45+2XLJMzs0NbYAp
         KkUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725282691; x=1725887491;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ygUatbpumzocyN/aWwq4fsKNrUZNnY1PLNHUlk8CfxI=;
        b=tPpdB1tWj8Lud2INu1KXpON9wccIdHhGoiaHjgT8HimO9uxo/VXPBAdy+1HwsoBePf
         B0wSPhye0sGeDMOiZdZrs0ZPgpnRGeASZIMw4r2PYg/dT+87Pvs1910qnRYbDbTSq8gR
         bGGk+POMWJpfyehcTpnQqW9B95dIHP1kQsmZ0tN2TQrfCPKxhLpY8Q4LIdJCXXajStmQ
         ZEqxZc9/g/sT285XQuN6tE7Kxl6b3JaEl7iZs7Z+CgvqfojFlBgz2E7j7bYc/bDZeUQZ
         9SnF0cBKw523LQG45OUHjxAABFIb4LxtFzWxWAKmYwTpNoFSGD3M2zN3aGjrJk8nFRwt
         SKpw==
X-Gm-Message-State: AOJu0YykyYWF+E+EREs2JlIOOIgDJfAtWo+NugNrEgndYcnIVzFnbDtL
	jNfVulQS88GBg2axhP9/45nGniSJR05o7SkDasT6ZD07/KiDZVgFPxldZDiWYSzHKItZ1NXk2W+
	Kkxc=
X-Google-Smtp-Source: AGHT+IHZyaTNR1sKRz/AjAucXPOS4gjlYfGzhef2HhMXtkoU/8DRHCgaLbfafIunrCJhUIaHsWThuQ==
X-Received: by 2002:a5d:58c7:0:b0:374:c658:706e with SMTP id ffacd0b85a97d-374c65870aemr3751044f8f.39.1725282690699;
        Mon, 02 Sep 2024 06:11:30 -0700 (PDT)
Received: from probook-s.corp.sigma-star.at ([82.150.214.1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3749ee9ba83sm11511430f8f.54.2024.09.02.06.11.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 06:11:29 -0700 (PDT)
From: Simon Graber <simon.graber@sigma-star.at>
To: xenomai@lists.linux.dev
Cc: upstream+xenomai@sigma-star.at,
	Simon Graber <simon.graber@sigma-star.at>
Subject: [PATCH v4 4/4] Add documentation for env vars
Date: Mon,  2 Sep 2024 15:11:24 +0200
Message-ID: <20240902131124.37844-5-simon.graber@sigma-star.at>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240902131124.37844-1-simon.graber@sigma-star.at>
References: <20240902131124.37844-1-simon.graber@sigma-star.at>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Usage message in lib/boilerplate/setup.c now prints
XENO_CPU_AFFINITY and XENO_SESSION_NAME.

The usage of the session arg/env var are also
described in README.INSTALL.adoc.

Signed-off-by: Simon Graber <simon.graber@sigma-star.at>
---
 doc/asciidoc/README.INSTALL.adoc |  7 ++++---
 lib/boilerplate/setup.c          | 22 +++++++++++++---------
 2 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/doc/asciidoc/README.INSTALL.adoc b/doc/asciidoc/README.INSTALL.adoc
index d2b7e6f78..52bef566d 100644
--- a/doc/asciidoc/README.INSTALL.adoc
+++ b/doc/asciidoc/README.INSTALL.adoc
@@ -428,9 +428,10 @@ Generic configuration options (both cores)
 When this option is enabled, the system creates a file hierachy at
 `<user>/<session>/<pid>` under the registry root path, where you
 can access the internal state of the active real-time objects. The
-session label is obtained from the --session runtime switch. If no
-session name is specified, `anon@<pid>` will be used. E.g. looking at
-the properties of a VxWorks task could be done as follows:
+session label is obtained from the `--session` runtime switch, which
+takes precedence over the environment variable `XENO_SESSION_NAME`.
+If neither of these are specified, `anon@<pid>` will be used. E.g.
+looking at the properties of a VxWorks task could be done as follows:
 
 If not specified in the configuration switch, the registry root path
 will be +/var/run/xenomai+.
diff --git a/lib/boilerplate/setup.c b/lib/boilerplate/setup.c
index 9573a546f..7bb24f6f4 100644
--- a/lib/boilerplate/setup.c
+++ b/lib/boilerplate/setup.c
@@ -370,17 +370,21 @@ void xenomai_usage(void)
 		}
 	}
 
-        fprintf(stderr, "--cpu-affinity=<cpu[,cpu]...>	set CPU affinity of threads\n");
-        fprintf(stderr, "--[no-]sanity			disable/enable sanity checks\n");
-        fprintf(stderr, "--verbose[=level] 		set verbosity to desired level [=1]\n");
-        fprintf(stderr, "--silent, --quiet 		same as --verbose=0\n");
-        fprintf(stderr, "--trace[=level] 		set tracing to desired level [=1]\n");
-        fprintf(stderr, "--version			get version information\n");
-        fprintf(stderr, "--dump-config			dump configuration settings\n");
+	fprintf(stderr, "--session=<label>[/<group>]	enable shared session\n");
+	fprintf(stderr, "--cpu-affinity=<cpu[,cpu]...>	set CPU affinity of threads\n");
+	fprintf(stderr, "--[no-]sanity			disable/enable sanity checks\n");
+	fprintf(stderr, "--verbose[=level]		set verbosity to desired level [=1]\n");
+	fprintf(stderr, "--silent, --quiet		same as --verbose=0\n");
+	fprintf(stderr, "--trace[=level]		set tracing to desired level [=1]\n");
+	fprintf(stderr, "--version			get version information\n");
+	fprintf(stderr, "--dump-config			dump configuration settings\n");
 #ifdef CONFIG_XENO_MERCURY
-        fprintf(stderr, "--no-mlock			do not lock memory at init\n");
+	fprintf(stderr, "--no-mlock			do not lock memory at init\n");
 #endif
-        fprintf(stderr, "--help				display help\n");
+	fprintf(stderr, "--help				display help\n");
+	fprintf(stderr, "\nEnvironment variables (arguments take priority):\n"
+			"XENO_SESSION_NAME=<label>[/<group>]	enable shared session\n"
+			"XENO_CPU_AFFINITY=<cpu[,cpu]...>	set CPU affinity of threads\n");
 }
 
 static int set_affinity_from_env(void)
-- 
2.46.0

