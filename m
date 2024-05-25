Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64223D967
	for <xenomai@lists.linux.dev>; Sat, 25 May 2024 11:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.40.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716638320; cv=none; b=R9rJxBCGM7PZerw6qSm+89UIBh4BBb5RVGx2FL3wQUEtrHBLjfO3uXtsWT88P3RIAqvNBWJVkbQeLzWjJlWECHLu7MsG1vqviquijCgfoTwbWTV5J+fJ0xOBtMbJDxBpNVcd9MA/nBe41drXQ8pxNhJGDLftiCxTloVV+soPJ1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716638320; c=relaxed/simple;
	bh=FBxs9mFhgXIJNJWP2LmBfQWwcgSvY/ktZ3KvefZcaAg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ffRCeLpp7/hGaGTw3p3qwrHDZx7IGoo38e75JY6DzQ1dAhhD1Jjc8D1z2N9eZsvjbS8vxMEmKPcH9X7mYnsMCdacrNsmyOI1VfEOIcK/Zc6eDz5oKwJ5iQjI6wbHW2Xs6elU9V27wXDxLFWNs6hUT1pcrTPFY98OaLIYZbuR6Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=195.201.40.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 7275064103F0;
	Sat, 25 May 2024 13:58:29 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id zHzwJ5h-mX9f; Sat, 25 May 2024 13:58:28 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id D911E63DCAC9;
	Sat, 25 May 2024 13:58:28 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id GozTkQVQ7Xmf; Sat, 25 May 2024 13:58:28 +0200 (CEST)
Received: from foxxylove.corp.sigma-star.at (unknown [82.150.214.1])
	by lithops.sigma-star.at (Postfix) with ESMTPSA id A3D6062348A5;
	Sat, 25 May 2024 13:58:28 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: xenomai@lists.linux.dev
Cc: upstream+xenomai@sigma-star.at,
	Richard Weinberger <richard@nod.at>
Subject: [PATCH 05/16] prepare-kernel.sh: Fix shellcheck SC2046 warnings wrt. check_filter
Date: Sat, 25 May 2024 13:57:55 +0200
Message-Id: <20240525115806.12101-6-richard@nod.at>
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

Fixes:
In scripts/prepare-kernel.sh line 64:
                if test `check_filter $file` =3D "ok"; then
                        ^------------------^ SC2046 (warning): Quote this=
 to prevent word splitting.

In scripts/prepare-kernel.sh line 126:
                        if test `check_filter $link_dir/$f` =3D "ok"; the=
n
                                ^-------------------------^ SC2046 (warni=
ng): Quote this to prevent word splitting.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 scripts/prepare-kernel.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/prepare-kernel.sh b/scripts/prepare-kernel.sh
index 800528058..d8d63397d 100755
--- a/scripts/prepare-kernel.sh
+++ b/scripts/prepare-kernel.sh
@@ -61,7 +61,7 @@ patch_append() {
 		chmod +w "$linux_tree/$file"
 		cat >> "$linux_tree/$file"
 	else
-		if test `check_filter $file` =3D "ok"; then
+		if test "`check_filter $file`" =3D "ok"; then
 			patch_copytempfile "$file"
 			cat >> "$temp_tree/$file"
 		fi
@@ -123,7 +123,7 @@ patch_link() {
 				fi
 			fi
 		else
-			if test `check_filter $link_dir/$f` =3D "ok"; then
+			if test "`check_filter $link_dir/$f`" =3D "ok"; then
                     		if test -e $linux_tree/$link_dir/$f; then
                         		echo "$me: warning: $link_dir/$f already prese=
nt in Linux kernel tree, output patch might be defective" >&2
                     		fi
--=20
2.35.3

