Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37152584
	for <xenomai@lists.linux.dev>; Thu, 27 Apr 2023 12:06:34 +0000 (UTC)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 202304271156249dac46d35100ad3779
        for <xenomai@lists.linux.dev>;
        Thu, 27 Apr 2023 13:56:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=MtADlc4Gm4P7MY9uzkIjN/peWJB6cfNlMurFf1MAoHo=;
 b=OUDGlz+ENvzsgpKfdJvHILDgQh4pmbkgM6zloUV/iAcZpbONbSRJJ4tt2U2P1BMtiv3LcR
 Nu+kdWwtg2Ww2GaXtQitbXD1g3G7T2R4KVoYW/cuxr1YyHxoNHjZHAOPWdtPITAt5qJi9XiC
 DergKd1vEfW6SKYRSexOWYOXW5LAE=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Thu, 27 Apr 2023 13:56:18 +0200
Subject: [PATCH xenomai-images 1/2] recipes-xenomai/xenomai.inc: Split up
 PROVIDES
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230426-flo-testsuite-extraction-v1-1-6f026bba9c39@siemens.com>
References: <20230426-flo-testsuite-extraction-v1-0-6f026bba9c39@siemens.com>
In-Reply-To: <20230426-flo-testsuite-extraction-v1-0-6f026bba9c39@siemens.com>
To: jan.kiszka@siemens.com, xenomai@lists.linux.dev
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 recipes-xenomai/xenomai/xenomai.inc | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/recipes-xenomai/xenomai/xenomai.inc b/recipes-xenomai/xenomai/xenomai.inc
index bad4ff4..ca71d8c 100644
--- a/recipes-xenomai/xenomai/xenomai.inc
+++ b/recipes-xenomai/xenomai/xenomai.inc
@@ -11,7 +11,12 @@
 
 inherit dpkg
 
-PROVIDES += "xenomai-kernel-source xenomai-runtime xenomai-runtime-dbgsym libxenomai1 libxenomai-dev libxenomai1-dbgsym"
+PROVIDES += "xenomai-kernel-source"
+PROVIDES += "xenomai-runtime"
+PROVIDES += "xenomai-runtime-dbgsym"
+PROVIDES += "libxenomai1"
+PROVIDES += "libxenomai-dev"
+PROVIDES += "libxenomai1-dbgsym"
 
 PACKAGE_ARCH:compat-arch = "${COMPAT_DISTRO_ARCH}"
 

-- 
2.39.2

