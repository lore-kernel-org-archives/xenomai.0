Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54CBF3655EA
	for <xenomai@lists.linux.dev>; Thu,  3 Sep 2026 08:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788424509; cv=none; b=d3TuKNJJoOqncT47i1/kVSKvTj+IezLA1vZfmAirS4upu6G5Gn+XV0xLBETSXImbO3fCJ2D1h5P+knn5akENQVysg7nkzcQEjirOlAmt6WjrgnJXpcFAnjb3ea7/YGm+kR7lzL3xRAThgBakRRNtbqDUlufF6+CowGUFULTlzIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788424509; c=relaxed/simple;
	bh=o0Ys5++bNpK/9lYSq3iJIxg74SC/aMaiaaA53w0FBD0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CJWnw/aSRHq1xxTOD7B7gZU+NQ3f3O0YjVfIJOEISahTPy35vYLSdcfjbdD1+mx6G5b7q5ko3ugyjbk60TCqr3mQmN4rbLkgJxNAP/vHX/XEksiCSh/K0fKN2AqTwnsNNmqT32J+vHUnrzYi4l6wVl3vlDrwK4Oq7AGL3po7zX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=clara.kowalsky@siemens.com header.b=OPCfvGYo; arc=none smtp.client-ip=185.136.65.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=clara.kowalsky@siemens.com header.b="OPCfvGYo"
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20260903083456abeaef5dd50002074c
        for <xenomai@lists.linux.dev>;
        Thu, 03 Sep 2026 10:34:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=clara.kowalsky@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=0Zen1vaEiEiEQfrDSmYSy5wGj3fBfBE5u3pizYtBD9c=;
 b=OPCfvGYoEhtFa7um8dQYZK8QLSdDiFT+SUdKT4h5dIJ+VDRHl6JuxhE8M1uswjGuvKa7Ya
 FlGoqf7LAKdu4QHRNfapBBA163Ipp0n8xZvOOtd9ptHJTW+ltBnIDRpa367QuWq/8GcImxND
 FYGA5U4e4JLoGabV57NX6XYHzTlvddpo5xnOstel9Nxp8SoEtzCyUuVaKjtvNpd9jDvIT7qR
 tBANVIFbRQieLlPaWEjWSu0KF6qKeKbzRz9AkeU474FQLsdGje/it6xEhBHw/mefyXSWsT5f
 7t/0Bj3a5GID9/sIlSWdBqaqXs6IkOgrF7W0T1NFSKjNbSE6jUhsQhYw==;
From: Clara Kowalsky <clara.kowalsky@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Clara Kowalsky <clara.kowalsky@siemens.com>
Subject: [PATCH 2/3] docs: Fix a2x warning for PDF builds
Date: Thu,  3 Sep 2026 10:34:46 +0200
Message-ID: <20260903083447.2220024-2-clara.kowalsky@siemens.com>
In-Reply-To: <20260903083447.2220024-1-clara.kowalsky@siemens.com>
References: <20260903083447.2220024-1-clara.kowalsky@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1047747:519-21489:flowmailer

The documentation PDF build passes "-D" to a2x, raising warnings such
as

a2x: WARNING: --destination-dir option is only applicable to HTML and manpage based outputs

Drop the unsupported option for PDF builds.
See #18.

Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
---
 doc/asciidoc/Makefile.am | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/asciidoc/Makefile.am b/doc/asciidoc/Makefile.am
index 782c7a23f..669decaeb 100644
--- a/doc/asciidoc/Makefile.am
+++ b/doc/asciidoc/Makefile.am
@@ -91,7 +91,7 @@ html/%: %.adoc Makefile
 	$(A2X) -f manpage -D man1 $(ASCIIDOC_MAN_OPTS) $<
 
 %.pdf: %.adoc Makefile
-	$(A2X) -f pdf -D . $(ASCIIDOC_PDF_OPTS) $<
+	$(A2X) -f pdf $(ASCIIDOC_PDF_OPTS) $<
 
 $(tmpdir)/%.txt: %.adoc Makefile plaintext.conf plaintext.xsl
 	@$(mkdir_p) $(tmpdir)
-- 
2.55.0

