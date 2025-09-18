Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E165306B03
	for <xenomai@lists.linux.dev>; Thu, 18 Sep 2025 15:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758210977; cv=none; b=jj+trH2/NIMsENyrn/WB5KTypNiRhOwzZICowss7JbIWB429kmXFK3LIcTBj43fwy9hcBxPvJDTsA+lw0GuGyIlB40tO7gZHKCoHAZ7jB0q1/NcApCDvx8OBOIgUv1rzz/uNRbpKnbYqSxYBFUFa2Vh/J5GNSRQbYmw1LhZwmzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758210977; c=relaxed/simple;
	bh=SenwkQz/Ce3Eq5U91/t8+vk42Dwc2gOxCH1sC4j/V44=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bt4YA0ktRijXtsgfKavw8ZOWqrWAYwEQJdiAQ0iZLoM4gQFgB690r2yu6yCpZEo+KboUNpG7GLJz+RU87zwrgtTkqr/ifSJi5eksVY4BPzRQNFQmElWEP3/cs4D2Vr3VTs9+mulROfAHcZn4r9Yo5kXLEv5AcdV0N+kehG2OS9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=c9Z2nsDt; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="c9Z2nsDt"
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20250918155613a232224674000207b9
        for <xenomai@lists.linux.dev>;
        Thu, 18 Sep 2025 17:56:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=njkGO0sYS8iZO/A6ONHCPl89yE/Nq5ZMRdFrn21MhXg=;
 b=c9Z2nsDtYciSKqzgNdSjyzvdoHAnj4GbZn7aMM0eIPoIbc2eNTQyPMZ5catx9mn8X+23s6
 PugL2gib9HzICsSVuNk60Rh90T8HuOcRTN5KzlIOpItLsIeKkl1lgacJe8NoiQElc0w844h8
 wX1SKkAOgR/gJzspag4zJrZcbCc6XVVN9yPxGau6j99qjZ0MVUqzFkx4xu+D5AGFwANlFqGY
 GR1olYEx462U2YVDm6miwneroAcG5Lu78zVM3rBJ2DWXL0vc6fn6PTYNNc0ZBGFwKqYaiPG9
 DyKuoQxYsMSq+bc+8PDF5vjmAP/TYA0kqb3/JqYAVDvE9lwi6XmMr1cQ==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Subject: [xenomai-images][PATCH 08/13] kas: Use same local_conf_header section name for version settings
Date: Thu, 18 Sep 2025 17:55:50 +0200
Message-ID: <ca8d2003936a2fa7c794b1fb9d618bef49e75acc.1758210955.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1758210955.git.jan.kiszka@siemens.com>
References: <cover.1758210955.git.jan.kiszka@siemens.com>
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

Makes file maintenance simpler and more consistent. No functional
changes expected.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 opt-linux-4.19-head.yml    | 4 ++--
 opt-xenomai-3.1.x-head.yml | 2 +-
 opt-xenomai-3.2.x-head.yml | 2 +-
 opt-xenomai-3.3.x-head.yml | 2 +-
 opt-xenomai-next.yml       | 2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/opt-linux-4.19-head.yml b/opt-linux-4.19-head.yml
index e9272b1..d0b9b72 100644
--- a/opt-linux-4.19-head.yml
+++ b/opt-linux-4.19-head.yml
@@ -1,7 +1,7 @@
 #
 # Xenomai Real-Time System
 #
-# Copyright (c) Siemens AG, 2019
+# Copyright (c) Siemens AG, 2019-2025
 #
 # Authors:
 #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
@@ -13,6 +13,6 @@ header:
   version: 14
 
 local_conf_header:
-  linux-xenomai-latest: |
+  linux-xenomai-version: |
     PREFERRED_VERSION_linux-xenomai-3 = "9999-%"
     LATEST_GIT_BRANCH = "4.19"
diff --git a/opt-xenomai-3.1.x-head.yml b/opt-xenomai-3.1.x-head.yml
index 622b217..fc2f30c 100644
--- a/opt-xenomai-3.1.x-head.yml
+++ b/opt-xenomai-3.1.x-head.yml
@@ -15,6 +15,6 @@ header:
 local_conf_header:
   debian-release: |
     DEBIAN_RELEASE = "bookworm"
-  xenomai-3-1-x: |
+  xenomai-version: |
     PREFERRED_VERSION_xenomai = "stable-3.1.x"
     PREFERRED_VERSION_xenomai-compat = "stable-3.1.x"
diff --git a/opt-xenomai-3.2.x-head.yml b/opt-xenomai-3.2.x-head.yml
index 24098ef..fa13e2a 100644
--- a/opt-xenomai-3.2.x-head.yml
+++ b/opt-xenomai-3.2.x-head.yml
@@ -15,6 +15,6 @@ header:
 local_conf_header:
   debian-release: |
     DEBIAN_RELEASE = "bookworm"
-  xenomai-3-2-x: |
+  xenomai-version: |
     PREFERRED_VERSION_xenomai = "stable-3.2.x"
     PREFERRED_VERSION_xenomai-compat = "stable-3.2.x"
diff --git a/opt-xenomai-3.3.x-head.yml b/opt-xenomai-3.3.x-head.yml
index c65ce1f..1cab9b9 100644
--- a/opt-xenomai-3.3.x-head.yml
+++ b/opt-xenomai-3.3.x-head.yml
@@ -15,6 +15,6 @@ header:
 local_conf_header:
   debian-release: |
     DEBIAN_RELEASE = "bookworm"
-  xenomai-3-3-x: |
+  xenomai-version: |
     PREFERRED_VERSION_xenomai = "stable-3.3.x"
     PREFERRED_VERSION_xenomai-compat = "stable-3.3.x"
diff --git a/opt-xenomai-next.yml b/opt-xenomai-next.yml
index 1d8885a..be63175 100644
--- a/opt-xenomai-next.yml
+++ b/opt-xenomai-next.yml
@@ -13,6 +13,6 @@ header:
   version: 14
 
 local_conf_header:
-  xenomai-latest: |
+  xenomai-version: |
     PREFERRED_VERSION_xenomai = "next"
     PREFERRED_VERSION_xenomai-compat = "next"
-- 
2.51.0

