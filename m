Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0002828CF49
	for <xenomai@lists.linux.dev>; Thu, 10 Apr 2025 14:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744294603; cv=none; b=ZviKJUmcmJaFZjXUedrJ78hyoXGBD2b4ootpZsYp2XNf21FS6i+YBII3jPJqwaEheUM6vno9IwYs+h4BwlxbYzJOoqTkZSrTBfyMp5lQ0MP4GuXSH3TNXdjMkEZpJVoAO1mYQvxg9MB6b9xBHxoDqOFb1Lrs/ef5bTrngc9KHOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744294603; c=relaxed/simple;
	bh=k7okshfhlrQbV1GZER97f0IRQ8u6SANdcGtZRgCoKIc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MXZNLuFcWzFZWzJni+WyyQY9fgqmCUgkoaqKNBNS1YI1orDWe8QW1KN7ZN90qoeyTqbV2N2yuBjzZj9d4FCYxwHLzB8nufs49qWruaB3w2gJm/rGdzQ0mun9iv4gjqIq0SPEX8BvPc/yxo8rthHGtrrwGYJr47LE1m9BRkmFvxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=Q2G373bG; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="Q2G373bG"
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20250410141631e28245467e5844529b
        for <xenomai@lists.linux.dev>;
        Thu, 10 Apr 2025 16:16:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=/NwUOe8WZVhLaUcBjRgjMQPhax8IoO79KbQHOLzSfJY=;
 b=Q2G373bGrWBA6Eu3BEtoMSth5d5r+GsyqAFKovo2x6eTpmxkXNZY8nifwUZTlZOKmZyYdo
 kZamEKa2D+qwTxXgzOtIT6jyhN3o22ms2GBYR9mYGR5JyUF17Ng2Zc6mgifRg5Ppn00Aetny
 9k9o0OjsPRGhzE77oXzFuKaVSfueivsmbPG/c0IdnHWH6uXKkmy33yi8vqW2bK6VzAz3nktM
 8+5uyyDoEGNV/rW9iDDm5p7YT4LeecM6FSgExjiGvIRa993aCMB7b+WvGJ11JUQVAd0FsG6c
 OjvimmXwuoUSKY+1eoa+6EWaejThHohwdo6d/gKuWsVoyrgP6d0/0iUg==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Subject: [xenomai-images][PATCH 6/7] linux-xenomai4: Enable selection of latest releases
Date: Thu, 10 Apr 2025 16:16:29 +0200
Message-ID: <74937736504393ccff1968defdd5d2cafd0c0ba2.1744294590.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1744294590.git.jan.kiszka@siemens.com>
References: <cover.1744294590.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer

From: Jan Kiszka <jan.kiszka@siemens.com>

Analogously to linux-xenomai-3, we need to set the preferred versions
for linux-xenomai-4 in order to allow their selection via kas.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 opt-linux-6.1.yml  | 1 +
 opt-linux-6.12.yml | 1 +
 opt-linux-6.6.yml  | 1 +
 3 files changed, 3 insertions(+)

diff --git a/opt-linux-6.1.yml b/opt-linux-6.1.yml
index 76c2a8b..b1073c0 100644
--- a/opt-linux-6.1.yml
+++ b/opt-linux-6.1.yml
@@ -15,3 +15,4 @@ header:
 local_conf_header:
   linux-xenomai-version: |
     PREFERRED_VERSION_linux-xenomai-3 = "6.1%"
+    PREFERRED_VERSION_linux-xenomai-4 = "6.1%"
diff --git a/opt-linux-6.12.yml b/opt-linux-6.12.yml
index 8132364..b026467 100644
--- a/opt-linux-6.12.yml
+++ b/opt-linux-6.12.yml
@@ -15,3 +15,4 @@ header:
 local_conf_header:
   linux-xenomai-version: |
     PREFERRED_VERSION_linux-xenomai-3 = "6.12%"
+    PREFERRED_VERSION_linux-xenomai-4 = "6.12%"
diff --git a/opt-linux-6.6.yml b/opt-linux-6.6.yml
index 1b0bbb4..0de37f8 100644
--- a/opt-linux-6.6.yml
+++ b/opt-linux-6.6.yml
@@ -15,3 +15,4 @@ header:
 local_conf_header:
   linux-xenomai-version: |
     PREFERRED_VERSION_linux-xenomai-3 = "6.6%"
+    PREFERRED_VERSION_linux-xenomai-4 = "6.6%"
-- 
2.43.0

