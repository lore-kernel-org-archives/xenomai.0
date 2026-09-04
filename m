Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD30E3D1AA6
	for <xenomai@lists.linux.dev>; Fri,  4 Sep 2026 11:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788522902; cv=none; b=WbcwtQuQX9jRKDfFZr9PAYhHdZFRSpr6wgaVthxFLIVgjpzB1fXdkg4bl/XrWCj4k4QzNC5TvieC3LLZoznG5n5SUqNFm1hqZl7tjbQofEOcIqz0MqTRFxuKpSpL3K7SZYN6DGI5Fvj79n6FF94ln6KdTjMBFHbmYUuEJqCJmXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788522902; c=relaxed/simple;
	bh=8II16x6rOjuj8Iic1HJLW4MgMxgW17eFZAhPJDkqPyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AKHZORtaKzm0XVFAtMfTKqenW6aUek984OwLj+Wz/EQCm80xglbqg7cR4IQyMHfzNH35XnxzSVc/fivI/VRIylFYKLZGTKTx+yZrfQrWU3qkMdpTx/hX+cRCg061DBse9KSlyV9EKv08kxJevhHfkLnq+O2hNy5M186eLHhUPHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=clara.kowalsky@siemens.com header.b=To8vIyNJ; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=clara.kowalsky@siemens.com header.b="To8vIyNJ"
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20260904115454e821887406000207e0
        for <xenomai@lists.linux.dev>;
        Fri, 04 Sep 2026 13:54:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=clara.kowalsky@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=BL9XF2OFtb7cnVRBBs6Lkuon8Ish14A6+VHRHJs5mKA=;
 b=To8vIyNJJYZSKev+ugztQlVE3/DfnlSE0gdu+YquMLr+ON4mk5Z38FQ62bAzzjdTetedmL
 L0AF6s4h8jkrIe+jfFyBiHbCXgMsXk7h8W5bXJ6B8txbqwGT6FpKKXBdfFb+rvfjYwwcyPAh
 XQZEvRxXMWSVM3Gf1jPUDtoT5MeMnswUnYWSfNSGvh9iGHe7Dq+Uy+qZbA4uewosrcXZqKjw
 u9K/Sasz1TEdZWXrBRNQwbGcKehQCsYEJJ/c7FtF7m1W7Q1cVMFO6jWmwe9uv1xakKGc8CwH
 Dy+SKYbXNaljiFTrJ91B93rA2HkDCVdVJe5M3M18kG7vUBuOaBay0RhA==;
From: Clara Kowalsky <clara.kowalsky@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Clara Kowalsky <clara.kowalsky@siemens.com>
Subject: [PATCH] docs(xeno3): Drop COBALT_DECL() to avoid duplicate search results
Date: Fri,  4 Sep 2026 13:54:40 +0200
Message-ID: <20260904115440.2981755-1-clara.kowalsky@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1047747:519-21489:flowmailer

Expanding COBALT_DECL() causes doxygen to index the declarations from
the headers in addition to the documented implementations of the Cobalt
functions.
As a result, functions appear twice in the doc search results, even
though they point to the same API documentation.
As the function documentation is attached to the implementation macros,
keep the implementation-side expansion and drop the declaration-side
macros.

Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
---
 doc/doxygen/xeno3prm-common.conf.in | 1 -
 1 file changed, 1 deletion(-)

diff --git a/doc/doxygen/xeno3prm-common.conf.in b/doc/doxygen/xeno3prm-common.conf.in
index ee4ede10d..33ba35ee9 100644
--- a/doc/doxygen/xeno3prm-common.conf.in
+++ b/doc/doxygen/xeno3prm-common.conf.in
@@ -648,7 +648,6 @@ PREDEFINED = DOXYGEN_CPP			\
         "DECLARE_BITMAP(symbol, nr)=unsigned long symbol[BITS_TO_LONGS(nr)]" \
 	"COBALT_IMPL(T,I,A)=T I A"		\
 	"COBALT_IMPL_TIME64(T,I,N,A)=T I A"	\
-	"COBALT_DECL(T,P)=T P"			\
 	"COBALT_SYSCALL(N,M,T,A)=T N A"		\
 	"COBALT_SYSCALL_DECL(N,T,A)=T N A"
 
-- 
2.55.0

