Received: from mta-65-228.siemens.flowmailer.net (mta-65-228.siemens.flowmailer.net [185.136.65.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B27364058
	for <xenomai@lists.linux.dev>; Fri, 28 Aug 2026 15:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787931310; cv=none; b=jQy8ea1sanvy+T/E3UmKpNFHZXQzPIEnpWMSZDQ/U77XIMyAX1ZYPepc+AvmnbCB0u0WkKegAH4dZltghS9zjdz8anE7k4GyT5Y753SgcLlqFfPdaWAbT0T1MqsIWuvy3dF8wDRlR+qdzXSZG27/uxn+QR504lrGrKkQDDrZzvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787931310; c=relaxed/simple;
	bh=g/8sqeL/kiHeu/Jr2Aqc6cDuamr3xFbyvPPjuqX4m3E=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qanIJ01Kyq5qQR76kzm79K4jbgR4ZwOl319tB4AAsBfGrcfIBBrrwVC1AzrPZj07aRZUtDzZdd6iPQEYSeJA05yTesksZyWlSqf+DhmIVlV2F31iG7HxfIYlJCpOLXm7SNveoua/7rLBoqR4nKs1Dq4+WxvHtfxPKkwUtusWi6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=TCx7Qqxw; arc=none smtp.client-ip=185.136.65.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="TCx7Qqxw"
Received: by mta-65-228.siemens.flowmailer.net with ESMTPSA id 20260828153457e565aea686000207f0
        for <xenomai@lists.linux.dev>;
        Fri, 28 Aug 2026 17:34:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=di4O7zzJVqfx9wTvJaoI/l617svy7rdQiNtbQ8PJgBs=;
 b=TCx7QqxwRs77h1LHnCSB5FQSgoZ9oSWItmfyRsEcYrkpq6VMjpeODG0TUx+0ALPgyGi6uv
 3yW3pLxgnDKfeQyrgeLNuZTkGEc10aeHEf3wFBoh/BedIfzTX0CEZJWJrM+nlHBhnptW2JKj
 56UiENcbTqWwaevFdmtWg2fI1EN6rUlKuupBi/+PcoNpIggYUDd+OsaON/C69pBx9VVo7ok8
 9rbZWfAYzXGF4dXExgTo304yn/5YGJycHg3Z7BzUCnXJZEgmvzZaJXRiZS9LVuaR3kd0WXwm
 EU9A0RT8cOKuQcd6a4xsVPEA/azZ6TtIq9iC5nFtCkXZZUcoEBqPyNgQ==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Subject: [xenomai-images][PATCH 3/5] Update Isar revision
Date: Fri, 28 Aug 2026 17:34:54 +0200
Message-ID: <f5dfdf1fd8749160ec47f73ec60da270bb71b17e.1787931296.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1787931296.git.jan.kiszka@siemens.com>
References: <cover.1787931296.git.jan.kiszka@siemens.com>
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

This will allow us to switch to rootless builds.

We need to adjust the dependency chain for the arch-all package
xenomai-kernel-source as Isar changed its logic here.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kas.yaml                            | 2 +-
 recipes-xenomai/xenomai/xenomai.inc | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kas.yaml b/kas.yaml
index 1eb2469..268ecc9 100644
--- a/kas.yaml
+++ b/kas.yaml
@@ -22,7 +22,7 @@ repos:
 
   isar:
     url: https://github.com/ilbers/isar.git
-    commit: 22ee5352eab6c38ac395da60895d09bacfe7b201
+    commit: 436bc96f3869b4a139357afbabb039caf4df7c5c
     layers:
       meta:
 
diff --git a/recipes-xenomai/xenomai/xenomai.inc b/recipes-xenomai/xenomai/xenomai.inc
index 9dfef32..fc03ee5 100644
--- a/recipes-xenomai/xenomai/xenomai.inc
+++ b/recipes-xenomai/xenomai/xenomai.inc
@@ -14,7 +14,7 @@ inherit print-revision
 
 MAINTAINER = "Xenomai <xenomai@lists.linux.dev>"
 
-PROVIDES += "xenomai-kernel-source"
+PROVIDES += "xenomai-kernel-source-archall"
 PROVIDES += "xenomai-runtime"
 PROVIDES += "xenomai-runtime-dbgsym"
 PROVIDES += "xenomai-testsuite"
-- 
2.47.3

