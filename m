Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773956FB0
	for <xenomai@lists.linux.dev>; Wed, 10 Jan 2024 04:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="gZBtpwFJ"
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20240110044603c5bf8e569bf953dca4
        for <xenomai@lists.linux.dev>;
        Wed, 10 Jan 2024 05:46:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=1PTQbiNELu6QLQ4kupAmbhuIDAzfA4xvTR5MdlHJyzk=;
 b=gZBtpwFJ6OKFKlQwGZiyP9UBJumGzQpu1dpnsFy/lsyeH1tmr6ljm+PphLlDjgY8cxd6G6
 F30+kwWJ353eYSTE2UIo2VUXpXYaJeN1GEaG1LsOMejBisBq9ZbNfVyi4RArHnLOarg6SAyM
 t/JkyUCRYkdC3JpyqOiQ+IbAUNuqc=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Subject: [xenomai-images][PATCH v3 02/10] Replace incorrect string strip method with replace
Date: Wed, 10 Jan 2024 05:45:54 +0100
Message-Id: <f92f86eb56e6b9ea74515d8fc4a272764e4b1f81.1704861962.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1704861962.git.jan.kiszka@siemens.com>
References: <cover.1704861962.git.jan.kiszka@siemens.com>
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

We want the leading 'AUTOINC+' string stripped off but that is not
reliably done by Python's strip() method with works per character.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 recipes-kernel/linux/linux-xenomai.inc | 2 +-
 recipes-xenomai/xenomai/xenomai.inc    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/recipes-kernel/linux/linux-xenomai.inc b/recipes-kernel/linux/linux-xenomai.inc
index ca63fea..4761d01 100644
--- a/recipes-kernel/linux/linux-xenomai.inc
+++ b/recipes-kernel/linux/linux-xenomai.inc
@@ -30,7 +30,7 @@ TEMPLATE_FILES += "rules.tmpl"
 
 def get_commit(d):
     try:
-        return bb.fetch2.get_srcrev(d).strip('AUTOINC+')
+        return bb.fetch2.get_srcrev(d).replace('AUTOINC+', '')
     except bb.fetch2.FetchError:
         return ""
 
diff --git a/recipes-xenomai/xenomai/xenomai.inc b/recipes-xenomai/xenomai/xenomai.inc
index 0a32981..26ee654 100644
--- a/recipes-xenomai/xenomai/xenomai.inc
+++ b/recipes-xenomai/xenomai/xenomai.inc
@@ -25,7 +25,7 @@ PACKAGE_ARCH:compat-arch = "${COMPAT_DISTRO_ARCH}"
 # use bitbake get_srcrev to get the current commit id
 def get_commit(d):
     try:
-        return bb.fetch2.get_srcrev(d).strip('AUTOINC+')
+        return bb.fetch2.get_srcrev(d).replace('AUTOINC+', '')
     except bb.fetch2.FetchError:
         return ""
 
-- 
2.35.3

