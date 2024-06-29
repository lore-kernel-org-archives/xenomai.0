Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18183BB48
	for <xenomai@lists.linux.dev>; Sat, 29 Jun 2024 13:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.40.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719668730; cv=none; b=f13FpPfTTK7OewKyxBaTa7ym+6SXFaabWwWQ2gHCXF/JIa7RngYfO3YXb6cn42aq78N92EPKQS4kMq1ReV0JwJ1ec6qhU12iFEtc6+aytGdfHtTvnfJ/J1fQHykI3p0ahEAuIoeAZaLgjfpFG740kTOXZ/RGPAFIAD7VGKxZbss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719668730; c=relaxed/simple;
	bh=D1TGtQrkR5fyyi8G3N1QT6m9MrFmM45sBiM95LGngkc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C1Rd3+7QLLIjteAmRrZjuIGMh7e44qpZ90bskqrkkquMjTiOXxQV3ju51KphGZ67w/BhCLiqe5KVTjOC5sqOpa3mvBDOwMMB6lhD8Qna5hfA5uGGQnnScZDayHGxDINL/SL20CyqGpdLw3BAJ8SNJX2yGplponLV31HZAIZ5yJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=195.201.40.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 9D5B661966A4;
	Sat, 29 Jun 2024 15:45:19 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id OVcg4r2nGf3d; Sat, 29 Jun 2024 15:45:19 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 4174A6195FC4;
	Sat, 29 Jun 2024 15:45:19 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id kNrX2vUBEPsv; Sat, 29 Jun 2024 15:45:19 +0200 (CEST)
Received: from foxxylove.corp.sigma-star.at (unknown [82.150.214.1])
	by lithops.sigma-star.at (Postfix) with ESMTPSA id 1789A6195FD3;
	Sat, 29 Jun 2024 15:45:19 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: xenomai@lists.linux.dev
Cc: upstream+xenomai@sigma-star.at,
	Richard Weinberger <richard@nod.at>
Subject: [PATCH 1/5] gitlab-ci.yml: Use CI_PROJECT_DIR variable
Date: Sat, 29 Jun 2024 15:45:00 +0200
Message-Id: <20240629134504.11148-2-richard@nod.at>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240629134504.11148-1-richard@nod.at>
References: <20240629134504.11148-1-richard@nod.at>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Using CI_PROJECT_DIR we can reduce the amount of
directory changes and configure the kernel relative to
the Xenomai project directory.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 .gitlab-ci.yml | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index fa9203525..c5c6c3a56 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -70,7 +70,7 @@ variables:
     - export PATH=3D/usr/lib/ccache:$PATH
     - ${CROSS_COMPILE}gcc --version
   script:
-    - export CCACHE_DIR=3D$(pwd)/.ccache
+    - export CCACHE_DIR=3D${CI_PROJECT_DIR}/.ccache
     - pushd ${KDIR}
     - make -j $(nproc) ${KERNEL_DEFCONFIG}
     # Generic settings
@@ -168,9 +168,7 @@ variables:
     - ./scripts/config -e XENO_DRIVERS_SPI_SUN6I
     - ./scripts/config -e XENO_DRIVERS_SPI_OMAP2_MCSPI_RT
     - ./scripts/config -e XENO_DRIVERS_SPI_DEBUG
-    - popd
-    - scripts/prepare-kernel.sh --linux=3D${KDIR}
-    - pushd ${KDIR}
+    - ${CI_PROJECT_DIR}/scripts/prepare-kernel.sh
     - make -j $(nproc) olddefconfig
     - make -j $(nproc) all
     - popd
--=20
2.35.3

