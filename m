Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1B215687D
	for <xenomai@lists.linux.dev>; Wed,  3 Apr 2024 21:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.40.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712180908; cv=none; b=FnjW9LzJvs7bGSLhYvavYQurfKEF+0RsDbs+EN/the/yqsZ9HJ3PpKYrjJAbZ2WgHPWHvT6DU0UiOt4l8yHahHBSkOJ9duW07Y29t2AYWaTGccorc02zRXjEtEKl2vf99GrxjG9uFFIZ1LZkklz0GEpoxFN8x3HilgFfL79r2dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712180908; c=relaxed/simple;
	bh=Ar0d6LSqyn1xBJzmLwvs7Tz4JX8VpPj3+jyG5BJfUag=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TNM6oyIoUw9ypoTAnC3+75DXAi9S/xN95Ui5vfNtx/tfSO+rtyZnfz5+JmQbCm3BwT4vpw12DjUyaghbqaUvwVnlIOzfE/FHVng58jZ7l5Q76d1EoanAx3eLk67icRJkFYkWijq8iTCcW+qCW7fnh8IPR+vII3MnhJsKVqXxIIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=195.201.40.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 7593E647A814
	for <xenomai@lists.linux.dev>; Wed,  3 Apr 2024 23:48:18 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id UPKtX3AUE5_w; Wed,  3 Apr 2024 23:48:18 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 14240647A81F;
	Wed,  3 Apr 2024 23:48:18 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 30Ry1ekedwMv; Wed,  3 Apr 2024 23:48:17 +0200 (CEST)
Received: from blindfold.corp.sigma-star.at (84-115-238-31.cable.dynamic.surfer.at [84.115.238.31])
	by lithops.sigma-star.at (Postfix) with ESMTPSA id CA79C647A800;
	Wed,  3 Apr 2024 23:48:17 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: xenomai@lists.linux.dev
Cc: Richard Weinberger <richard@nod.at>
Subject: [PATCH 1/2] prepare-kernel.sh: Remove patch_ed function
Date: Wed,  3 Apr 2024 23:48:10 +0200
Message-Id: <20240403214811.8979-1-richard@nod.at>
X-Mailer: git-send-email 2.26.2
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The function is unused since 09f8992a55be ("ksrc: rename as kernel").

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 scripts/prepare-kernel.sh | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/scripts/prepare-kernel.sh b/scripts/prepare-kernel.sh
index c9aeeb4fad8d..ed168773247f 100755
--- a/scripts/prepare-kernel.sh
+++ b/scripts/prepare-kernel.sh
@@ -66,18 +66,6 @@ patch_append() {
     fi
 }
=20
-patch_ed() {
-    file=3D"$1"
-    if test "x$output_patch" =3D "x"; then
-        ed -s "$linux_tree/$file" > /dev/null
-    else
-        if test `check_filter $file` =3D "ok"; then
-            patch_copytempfile "$file"
-            ed -s "$temp_tree/$file" > /dev/null
-        fi
-    fi
-}
-
 patch_link() {
     recursive=3D"$1"         # "r" or "n"
     link_file=3D"$2"         # "m", "n" or some file (basename) from $ta=
rget_dir
--=20
2.26.2

