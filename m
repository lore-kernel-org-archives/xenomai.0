Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A60F16DC3D
	for <xenomai@lists.linux.dev>; Fri, 30 Aug 2024 12:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725022585; cv=none; b=OeJjNOF0woyV5s/TVgDEBiJqbEkM0Sihyv8hhJRwy9uAT5Q2m3rV8SWro30e+LOlNIQM7LxQh9aoCj0e9gtOx47WWkThqrE1IKppK1U0nHf/r0pSy4oJtskuY3lf9ZMqXjPlF8cn8cII3B40DUnVTiwr370zDeGzOvAeR5aJP04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725022585; c=relaxed/simple;
	bh=LaZK2Ur82gznG/t9RstfY/HHCysm75zuRUFQcOxeCa4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SV3uReCkP87fg+4m1R7HEa9qaodyH6CTrRjmPkkpKLtM7zx6yhRXnepzC3+syMBWYpdcschOqP+i1dOfQrQqmG8h6V4Nysjbmod8oBjama+zPOS/EoYuGsAdpkB85pjkGNL3CHvd3aN2//Svv8DpQHDYHGKqpWKw99CFlUklS6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=Fabian.Scheler@siemens.com header.b=ClvighH8; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=Fabian.Scheler@siemens.com header.b="ClvighH8"
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20240830125612644c7b171ff329344f
        for <xenomai@lists.linux.dev>;
        Fri, 30 Aug 2024 14:56:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Fabian.Scheler@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=fv9hhXPht2oVz8dIeL3grkOW0YLTY15pyVmjC0rhCak=;
 b=ClvighH85PmImZ8dJUtSHsoattjpLqA1LU0swn6r6wUCWiQmOgzIHvNbRVnBx8KBVJY66i
 lafH5WhDMkklFcoPr9RDYWDw2wGWhiCC6x8rkAvxU9fWylE+SL6Jx2otdPvNidSXYwcDqwnS
 vwRiR0JIN2K4GsPnCbuFy5Rc+gOVQ/r1yQqFinnp+G5pTTJQkwQtH0fa80w1lOEcPuO1+JnR
 etfYcEcHnEyi4Q7/VQ8czLSRy+P5/og2Qqj3kR1B2/LHLRqqLGbdN5lODsnenueG/Q6NlCD2
 mDp6FxOIlNx3OF6jZNixv312SSDJplQC+F8zTRlIur92zktD6rOLsBKw==;
From: Fabian.Scheler@siemens.com
To: xenomai@lists.linux.dev
Cc: Fabian Scheler <Fabian.Scheler@siemens.com>
Subject: [xenomai-images][PATCH] linux-xenomai: x86: Enable IOMMU_SUPPORT and IRQ_REMAP
Date: Fri, 30 Aug 2024 14:55:21 +0200
Message-ID: <20240830125533.30195-1-Fabian.Scheler@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1325281:519-21489:flowmailer

From: Fabian Scheler <Fabian.Scheler@siemens.com>

Booting up the demo-image on an x86-testboard with IO-APIC failed due to these
missing options.

Signed-off-by: Fabian Scheler <Fabian.Scheler@siemens.com>
---
 recipes-kernel/linux/files/amd64_defconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/recipes-kernel/linux/files/amd64_defconfig b/recipes-kernel/linux/files/amd64_defconfig
index 4f58c34..a0a516f 100644
--- a/recipes-kernel/linux/files/amd64_defconfig
+++ b/recipes-kernel/linux/files/amd64_defconfig
@@ -3424,7 +3424,8 @@ CONFIG_CLKBLD_I8253=y
 CONFIG_MAILBOX=y
 CONFIG_PCC=y
 # CONFIG_ALTERA_MBOX is not set
-# CONFIG_IOMMU_SUPPORT is not set
+CONFIG_IOMMU_SUPPORT=y
+CONFIG_IRQ_REMAP=y
 
 #
 # Remoteproc drivers
-- 
2.46.0

