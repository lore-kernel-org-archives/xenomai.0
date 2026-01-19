Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6BA2D838A
	for <xenomai@lists.linux.dev>; Mon, 19 Jan 2026 10:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768818161; cv=none; b=GqDC6MPuoxiE2oOne4/IqpCZvm3g+vl+64KOsRl8zVY06AR5Jxo6uP55LPXX86J1jNYywU/I7GJOzk+bbAAEataVDTBUtK78fw9sd2/5Hh+k6pXU0cyq8z3Jx53Lp2eIZCrm2p0gYWCoBTLk4jtzeeWCccIqSXMHYAHDjsU0qwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768818161; c=relaxed/simple;
	bh=s79/A+AacXcDYbjZj9htK0r/KWpZg7XqMCaJI3FwWLI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Yie5v6CBlPR9sAuM5TvtcrNsVnC6u2TJZysjD80mTqrUe1vn/Pk2F16uu2a/JKLCotPnv2ciitJesp1kQXa3EJvmGRIMW4DvAsrAQ9EDqPDR8bRkGkar6HnJyQnT597IFiiIYGTtTQ9ueFcAWz095xF+mmTLdOtdItJoLHeJNR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=WkW75fN8; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="WkW75fN8"
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 202601191022287ee173dc4e00020731
        for <xenomai@lists.linux.dev>;
        Mon, 19 Jan 2026 11:22:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=2siLXm30JHGNKz/6Vn0AQ7+TUG3PAm9Y/PJBjdoH9OA=;
 b=WkW75fN8YB9CBEdYT8/cDs3uD8ciBRDK4c30r1C0O6nI8jsELWi1BgEVMjG2Bog5VFfTwT
 ltBw0fxJrRtgt+g6V9XUCcJfPWvvDrIKfI/a8wi0x9TSR6PH+2745FA117Q2Z1aJKVrNA+Os
 NaK6chVt2rJkc2vdK/RwQMdL/kbt2acGLNpn12cZQhhcMD/b4R4dC6mEKrK2z7pR3tSIyv63
 6PMDbeSilBWrYeNlPKVR3mqt5IrefykTwFfAm8ztEkFV/MwT26ZuhYVGdjw8b6IiUDKwzntC
 BijEl1tTKoIMSizSErczU6gQL4CpSn5aa4jVo/FJl1cat1ThEpNRjTFw==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>,
	Florian Bezdeka <florian.bezdeka@siemens.com>,
	Quirin Gylstorff <quirin.gylstorff@siemens.com>
Subject: [PATCH xenomai-images] ci: Fix upload to aws for builds with no initrd
Date: Mon, 19 Jan 2026 11:22:27 +0100
Message-Id: <20260119102227.1149887-1-florian.bezdeka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Depending on kernel configuration and cache state it might happen that
the initrd is not being rebuild. In that case we crashed inside the
upload script and failed the build / test.

Checking for the existence of an initrd fixes this problem.

Suggested-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 scripts/deploy_to_aws.sh | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/scripts/deploy_to_aws.sh b/scripts/deploy_to_aws.sh
index c555a2c..2e0ee41 100755
--- a/scripts/deploy_to_aws.sh
+++ b/scripts/deploy_to_aws.sh
@@ -3,7 +3,7 @@
 #
 # Xenomai Real-Time System
 #
-# Copyright (c) Siemens AG, 2019-2021
+# Copyright (c) Siemens AG, 2019-2026
 #
 # Authors:
 #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
@@ -36,16 +36,22 @@ if [ ! -f "${kernel}" ]; then
     kernel_suffix="vmlinux"
 fi
 
-#KERNEL
+# KERNEL
 aws s3 cp "${kernel}" "${deploy_dir}/${isar_base_name}-${kernel_suffix}"
+
 # INITRD
-aws s3 cp "${images_dir}/${target}/${isar_base_name}-initrd.img" "${deploy_dir}/${isar_base_name}-initrd.img"
+initrd="${images_dir}/${target}/${isar_base_name}-initrd.img"
+if [ -f "${initrd}" ]; then
+    aws s3 cp "${initrd}" "${deploy_dir}/${isar_base_name}-initrd.img"
+fi
+
 # ROOTFS
 if ! ls "${images_dir}/${target}/${isar_base_name}".*.gz ; then
     gzip "${images_dir}/${target}/${isar_base_name}.*"
 fi
 image=$(ls "${images_dir}/${target}/${isar_base_name}".*.gz)
 aws s3 cp "${image}" "${deploy_dir}/$(basename "${image}")"
+
 # DTB
 dtb=$(ls "${images_dir}/${target}/"*.dtb 2> /dev/null || true )
 if [ -n "${dtb}" ] ; then
-- 
2.39.5

