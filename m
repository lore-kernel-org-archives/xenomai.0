Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6606C1D88B1
	for <xenomai@lists.linux.dev>; Mon, 28 Oct 2024 13:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730123701; cv=none; b=UaaNMj395UBNl5N8eEWQbWZxPlplSiF0q25U/1hvUWePQpFm1zL3FUbSW3n7E/2//tZnoVAR06ma3bgi6RtnXXo1awCBwWvzH2ZaEUH93o0hAkIYjGQI+WOvtbNKa8qXyBqDTCXtAt7fpTsHcBVh9DxFGrXxZISyft6x6TG1Vig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730123701; c=relaxed/simple;
	bh=IbFnLTH8DmPddEffyCKpyPlBtIbk/r7DRaJlH3ipQjw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XduusMOzFbpIjC2b4stOrOn8sGN4Q6BY1l05xaOBP4o/sE7F/E1wBVLTnnXdthmMfyyQ8psLKPj8cjI9G7RlRvbiCY4/bRXtRdWeA3NiN3/xzWdpoKZFfXihdY8w3aDec9txq+5nmDTdWfXe5TPhLkiSvoYEXKhz8nN3NCCzuLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=bI20MWlf; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="bI20MWlf"
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20241028134446790750fd189f78ec95
        for <xenomai@lists.linux.dev>;
        Mon, 28 Oct 2024 14:44:46 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=CJUv7V3ioPpFWYFWIeUjgpQAbYAxm4dpPiQi1G6XNgE=;
 b=bI20MWlfsbchwSBdHOacMcLuUFY3aWqpstTR0rZWzNRYHpT/UyqD+Zagd3AGHSAfkm9xwt
 dAwmPj3z1tH/ZjyzeY5nKfxgMfJFjYaxyMbOEvedghKEFqXEAGuIXg2VKOlgOyLalSbOyGI3
 NgJYhS88uzeG+oTOSKkRR7n5ZzmYVRMB+in7ej+QL9Gp/JgbgugNsm8NMQSjSawArNw41bdI
 jrJBxlfsvdwktYOOM5mwz55WmaVCF7rCr48v7W6T2fOI+GG/Q9g+XZv0lz7kMGp8OzyoiqYj
 xqQ2LuHk/gzSOECRV01/w/vJla2KOTQaYN45erIpr8Y/+axVdySW7bLw==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Subject: [xenomai-images][PATCH 5/6] xenomai: Update stable releases
Date: Mon, 28 Oct 2024 14:44:43 +0100
Message-ID: <3c7ea6c34e9801969dc4ed4bbffb1f4db4f5383b.1730123084.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1730123084.git.jan.kiszka@siemens.com>
References: <cover.1730123084.git.jan.kiszka@siemens.com>
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

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 conf/distro/include/xenomai-version.inc                   | 8 ++++----
 .../xenomai/{xenomai_3.0.14.bb => xenomai_3.0.15.bb}      | 0
 .../xenomai/{xenomai_3.1.4.bb => xenomai_3.1.5.bb}        | 0
 .../xenomai/{xenomai_3.2.4.bb => xenomai_3.2.6.bb}        | 0
 4 files changed, 4 insertions(+), 4 deletions(-)
 rename recipes-xenomai/xenomai/{xenomai_3.0.14.bb => xenomai_3.0.15.bb} (100%)
 rename recipes-xenomai/xenomai/{xenomai_3.1.4.bb => xenomai_3.1.5.bb} (100%)
 rename recipes-xenomai/xenomai/{xenomai_3.2.4.bb => xenomai_3.2.6.bb} (100%)

diff --git a/conf/distro/include/xenomai-version.inc b/conf/distro/include/xenomai-version.inc
index bed78e8..e036c39 100644
--- a/conf/distro/include/xenomai-version.inc
+++ b/conf/distro/include/xenomai-version.inc
@@ -1,7 +1,7 @@
 #
 # Xenomai Real-Time System
 #
-# Copyright (c) Siemens AG, 2019-2023
+# Copyright (c) Siemens AG, 2019-2024
 #
 # Authors:
 #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
@@ -11,13 +11,13 @@
 
 XENOMAI_DEFAULT_KERNEL_VERSION = "6.1%"
 
-XENOMAI_3_0_VERSION_LIST = "3.0 3.0% 3.0.% 3.0.14 stable-3.0.x"
+XENOMAI_3_0_VERSION_LIST = "3.0 3.0% 3.0.% 3.0.15 stable-3.0.x"
 XENOMAI_3_0_KERNEL_VERSION = "4.4%"
 
-XENOMAI_3_1_VERSION_LIST = "3.1 3.1% 3.1.% 3.1.4 stable-3.1.x"
+XENOMAI_3_1_VERSION_LIST = "3.1 3.1% 3.1.% 3.1.5 stable-3.1.x"
 XENOMAI_3_1_KERNEL_VERSION = "5.4%"
 
-XENOMAI_3_2_VERSION_LIST = "3.2 3.2% 3.2.% 3.2.4 stable-3.2.x"
+XENOMAI_3_2_VERSION_LIST = "3.2 3.2% 3.2.% 3.2.6 stable-3.2.x"
 XENOMAI_3_2_KERNEL_VERSION = "6.1%"
 
 # If PREFERRED_VERSION_xenomai contains any item from XENOMAI_3_0_VERSION_LIST use
diff --git a/recipes-xenomai/xenomai/xenomai_3.0.14.bb b/recipes-xenomai/xenomai/xenomai_3.0.15.bb
similarity index 100%
rename from recipes-xenomai/xenomai/xenomai_3.0.14.bb
rename to recipes-xenomai/xenomai/xenomai_3.0.15.bb
diff --git a/recipes-xenomai/xenomai/xenomai_3.1.4.bb b/recipes-xenomai/xenomai/xenomai_3.1.5.bb
similarity index 100%
rename from recipes-xenomai/xenomai/xenomai_3.1.4.bb
rename to recipes-xenomai/xenomai/xenomai_3.1.5.bb
diff --git a/recipes-xenomai/xenomai/xenomai_3.2.4.bb b/recipes-xenomai/xenomai/xenomai_3.2.6.bb
similarity index 100%
rename from recipes-xenomai/xenomai/xenomai_3.2.4.bb
rename to recipes-xenomai/xenomai/xenomai_3.2.6.bb
-- 
2.43.0

