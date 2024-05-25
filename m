Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6AA73F8ED
	for <xenomai@lists.linux.dev>; Sat, 25 May 2024 11:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.40.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716638323; cv=none; b=T5GCUaAGa7fzeECEgWH6C2Nyfn6fSde5CoKs2vHcI3zvNG4T4oC2koxi9WdVkvvqD1Q1OYyvF6Bpy4Z9ZwQL1fhLRkyZK+hJS1CgY+q3xPNVKB6J9qDJcv3EEDdy0GPFQWtu/f4qgPZHNtO692YE77Q6NRfBBQI8ryIh04KIS1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716638323; c=relaxed/simple;
	bh=QKdZIAG9Llcr23IfyTf9iTbL34v1fhT1BtJ2qbpZUbI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UzKgc45ahamZu6R9MsOvzU66mjk9Lsn0SiISnS4MwRg9Yqo6QurwYaMInYXQ4HeAKdKJCep0p8imnb8fgM6i+GgBKyKDKY5po1nmShkrHw+SjldhQPv7bFHx0tBIBKKw34AVJJekqmIS7fTxj9EoeYuYeVaiWMRCKEAFoTe7SSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=195.201.40.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id C2F4764103F9;
	Sat, 25 May 2024 13:58:30 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id 9qA0fuCLjYD7; Sat, 25 May 2024 13:58:30 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 5F9E063DCAC9;
	Sat, 25 May 2024 13:58:30 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id SuBkrSrZGqND; Sat, 25 May 2024 13:58:30 +0200 (CEST)
Received: from foxxylove.corp.sigma-star.at (unknown [82.150.214.1])
	by lithops.sigma-star.at (Postfix) with ESMTPSA id 27ECC62348A5;
	Sat, 25 May 2024 13:58:30 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: xenomai@lists.linux.dev
Cc: upstream+xenomai@sigma-star.at,
	Richard Weinberger <richard@nod.at>
Subject: [PATCH 12/16] prepare-kernel.sh: Fix dovetail check
Date: Sat, 25 May 2024 13:58:02 +0200
Message-Id: <20240525115806.12101-13-richard@nod.at>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240525115806.12101-1-richard@nod.at>
References: <20240525115806.12101-1-richard@nod.at>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

$probe_header and $arch_probe_header are only set when --dovetail=3D is u=
sed,
otherwise they are unset and checking whether the kernel has dovetail
always succeeds.

Fix by remove the variables and use the header files directly.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 scripts/prepare-kernel.sh | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/scripts/prepare-kernel.sh b/scripts/prepare-kernel.sh
index 214a008e3..a8179518b 100755
--- a/scripts/prepare-kernel.sh
+++ b/scripts/prepare-kernel.sh
@@ -129,8 +129,6 @@ while test $# -gt 0; do
 	--dovetail=3D*)
 		pipeline_patch=3D`echo $1|sed -e 's,^--dovetail=3D\\(.*\\)$,\\1,g'`
 		pipeline_patch=3D`eval "echo $pipeline_patch"`
-		probe_header=3Dinclude/linux/dovetail.h
-		arch_probe_header=3Dinclude/asm/dovetail.h
 	;;
 	--arch=3D*)
 		linux_arch=3D`echo $1|sed -e 's,^--arch=3D\\(.*\\)$,\\1,g'`
@@ -257,7 +255,7 @@ if test x$verbose =3D x1; then
 	echo "Preparing kernel $linux_version$linux_EXTRAVERSION in $linux_tree=
..."
 fi
=20
-if test -r $linux_tree/$probe_header; then
+if test -r $linux_tree/include/linux/dovetail.h; then
 	if test x$verbose =3D x1; then
 	   echo "IRQ pipeline found - bypassing patch."
 	fi
@@ -283,7 +281,7 @@ else
 fi
=20
 for a in $target_linux_archs; do
-	if test \! -r $linux_tree/arch/$a/$arch_probe_header; then
+	if test \! -r $linux_tree/arch/$a/include/asm/dovetail.h; then
 		echo "$me: $linux_tree has no IRQ pipeline support for $a" >&2
 		exit 2
 	fi
--=20
2.35.3

