Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001DF37A3B4
	for <xenomai@lists.linux.dev>; Thu, 30 Oct 2025 15:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761839619; cv=none; b=ADLNCDChrdD1Qgl4ZbbBPvKfhXrtsH9osodpKWa4TVN2E004+6oxN3J/2ddN1za8qNSLG27+HI4N4E1GS5iB+30znwpLhqETme3CTWX7o20KvrOV1tZhG1VQS0ayOyZy3kzWJh3HazhPjb33j/3OgXKPk/+BR/3TBv9Za8PszzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761839619; c=relaxed/simple;
	bh=H7arCiXmfn3gBhB/XPpJa9tKBtr+LvwBV0xXQlYNZLg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UluQKUAYmN2Y7uftm1VllV5tPtpjeYd+DEY17YNJDFrsJWvpTG3blcKLBnQo4bL75Z7G8xGkCJmWH/mp0/y0+vLmvfkkgp2tre6eU+FaQPX4WyxCkorJXtleNs+JtKTmIHiC0VRBcl/ANdS9fQVvzdWHxPljYs7qh6DYT6alx9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QgH1uG97; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QgH1uG97"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-475dab5a5acso6692345e9.0
        for <xenomai@lists.linux.dev>; Thu, 30 Oct 2025 08:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761839616; x=1762444416; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=33RXIABPaLT/1hFbPjp3vv+qvLu2CzlAC4YH6w0xho0=;
        b=QgH1uG97yIShQ6R6hnSSz1L/ni/QgCUAnGuFBlWeJIb7VxRSgZIZ1mq2NDxg6zfG6f
         JqPwpr5cZ4UM8aHC+8SEyXUr8ZvpB4+KehsC8p4syUlZ6X5t5tx03fWugrLMjQFTJCPV
         cWvsoWOs3fVWELJVQP20HJYYwr4Ugfcb2ZQIpGrBu6NuQoCuaO/N2pBC2gEsM+ZBMk0q
         7UalsXcS5Mj1yrTPEOzOPLeunLJRR0XpRoxu021OMM09E++oRh6ZGa0nXvzHVXCJkF6c
         pEChn4Cjdy7sV/VYpwyiE5pOGYThx/t8/nz5/YmhP8VllEI99AaUCeKS4LsoQzZ0WyBI
         yJ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761839616; x=1762444416;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=33RXIABPaLT/1hFbPjp3vv+qvLu2CzlAC4YH6w0xho0=;
        b=d6aDRFo9M3M29O2QEd4MYM8CxKAGH0qE7pSGSGCrdGVYIBBNx95tUyYT7U7tKwJTaw
         MaYYnI+XspqhgX0ImlDufFZ024rPUS2vU+NLSAybN9FCZAbID8geTORv7udfJnIhQ62j
         X+QLEB2u4vt+3/nh9LDZ8JoodAtTbO84jT1C4EimnOf9aCPJueHeNfJCEDPR5fKHDMC+
         Yi+yZYLVv5uJJltuB3IK1FSdIhXpGAZ2cdXvSk2Gkf++/abjdHiQ4hi7XYLIzFMPWtX0
         7g2MNIHpTdsPzAkJCMRFVTe0X/C10kl4qf7GMhhz7hC9LdTLGX9bUExgN5RxIMsIMlUt
         QW6w==
X-Gm-Message-State: AOJu0Ywc4hlsBWptoaWQy6gQX3Q8CQLkA8FhE0JgiOPF3UAGS+x+q+3e
	nMSWGCngW1U3NCxPSWr3gtDLe5NsWaR+sIhZ2e7vdsYBzm7pPHP7rLO4Oh0+Q0NUsd8=
X-Gm-Gg: ASbGncsd6jKN/i7bYzkWKNWKyGHifFB+AS3E+cn8/I1B2H1ZpU3F13qU1JXEhTIs6RV
	MWKj9m3pYFlPBaKBjzvRk2W+CvmTIoIqMaKpBJRuWTg+Cw/uME+wB3gZvC3Fe7GQBIyFzzOMLMm
	2mxGmstad2YRQ5avnCt7LXsXuaVkt81HWXTAm8TQw2Hzyo48zmE9+UYzXGcC0rrCLamoGhTCZA/
	IkgCmWA2Hgv3RjtXANcxyulc595/fdpeVEr4Klmr7dyshkNGOIccacfGESZsimPd17Ob6Xg+3Vj
	LLLwHKpSdZXwkxIoHxlpmEiCyd2FGYEzN1StjdYe8xSgUzkmjvQaoGIkJFj7oznP2Eq0WGfvly/
	S1ZZKPpVQUG93kt2HlBOabKrc4fP+XpaDMV9orvW4IZ+kFAEdF+7EydPZDd2/S40qvTSufcD8np
	tvUQYevJl2adWFAFdYF1nXguj6can1JDRc3/hJbK/lesXpOlJA3M6bvfC1
X-Google-Smtp-Source: AGHT+IEuLno+QgX/JDjNEw4DIB6XU/wbi8+YbtCMFCzzu3HaPSHgb2B40zydUOTw1dwzPUstOnVJkQ==
X-Received: by 2002:a05:600c:1912:b0:477:1622:7f78 with SMTP id 5b1f17b1804b1-477308a5e56mr1955175e9.40.1761839615836;
        Thu, 30 Oct 2025 08:53:35 -0700 (PDT)
Received: from pop-os.sigmatek.local (83-215-235-230.stat.cablelink.at. [83.215.235.230])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952cbb20sm32608509f8f.18.2025.10.30.08.53.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 08:53:35 -0700 (PDT)
From: m.kurz92@gmail.com
To: xenomai@lists.linux.dev
Cc: Markus Kurz <m.kurz92@gmail.com>
Subject: [PATCH 0/2] docs(xeno3): improve doxygen build
Date: Thu, 30 Oct 2025 16:53:27 +0100
Message-Id: <20251030155329.1337840-1-m.kurz92@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Markus Kurz <m.kurz92@gmail.com>


I adjusted the size of the search bar in the API documentation of
xenomai 3 and also removed some obsolete configuration variables from
the doxygen config files. Furthermore, I corrected to the correct paper
type config.

I tested it using a fork of xenomai and xenomai-docs and deployed the
static website to have a similar outcome to how it will be used.

The website with the applied patches can be seen here:
https://xenomai-doc-ac7b99.gitlab.io/v3/html/xeno3prm/index.html

Markus Kurz (2):
  docs(xeno3): adjust the size of the search bar
  docs(xeno3): fix warnings in doxygen build

 doc/doxygen/search-style.css        | 25 +++++++++++++++++++++++++
 doc/doxygen/xeno3prm-common.conf.in | 22 ----------------------
 doc/doxygen/xeno3prm-html.conf.in   | 22 +++++++++++++---------
 doc/doxygen/xeno3prm-latex.conf.in  | 10 ++++++----
 4 files changed, 44 insertions(+), 35 deletions(-)
 create mode 100644 doc/doxygen/search-style.css

