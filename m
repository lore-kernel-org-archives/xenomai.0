Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44221A08B0
	for <xenomai@lists.linux.dev>; Mon, 24 Jun 2024 20:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.40.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719261244; cv=none; b=NheoC61k2ZjBCbSqqyIOJWwkH9HrMxNC6PrQqe2jfrz3WovSnKZMkei8pL7zQ2pGfrMKcrBEHYjIZBp5Vh/E1nAtYN2j2jkbpheS8GfbsgZxDgLJsgQgaC9rYZayAJsgT+AiosgUmVvHw1/1QD4vdphR4apf3PhRdDJYMlEmR2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719261244; c=relaxed/simple;
	bh=OwsrJ2yPQrbFhsA0OB/MJ11jvUu6evmJQXpNefv1Qqk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EBMEmt3YTxtJYmohtcQZ700NrLf5naKGGu1iuAj+DrIhk2V636EH5cxqdy+3qITf7heox2/rDKgHXZod/fTjc3sHotg0U/8WmQhB0qnsXhmETALPy3VZ19z9yS6PtEQgvOjQRMbD1B2Tsnxew3BELcwkEL992ZM7jNfc/NDXAfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=195.201.40.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 5323561966AF;
	Mon, 24 Jun 2024 22:33:54 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id 0fzPMk7lW5TG; Mon, 24 Jun 2024 22:33:53 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id AD2FE6195FE9;
	Mon, 24 Jun 2024 22:33:53 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id aj8Eo0k0u0D8; Mon, 24 Jun 2024 22:33:53 +0200 (CEST)
Received: from foxxylove.corp.sigma-star.at (unknown [82.150.214.1])
	by lithops.sigma-star.at (Postfix) with ESMTPSA id 56F2761966AF;
	Mon, 24 Jun 2024 22:33:53 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: xenomai@lists.linux.dev
Cc: upstream+xenomai@sigma-star.at,
	Richard Weinberger <richard@nod.at>
Subject: [PATCH 05/14] prepare-kernel.sh: Disable SC2115 warning around $linux_tree
Date: Mon, 24 Jun 2024 22:33:32 +0200
Message-Id: <20240624203341.6263-6-richard@nod.at>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240624203341.6263-1-richard@nod.at>
References: <20240624203341.6263-1-richard@nod.at>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The script makes sure that $linux_tree is valid, it cannot be empty.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 scripts/prepare-kernel.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/prepare-kernel.sh b/scripts/prepare-kernel.sh
index 5712f760d..30c5be2aa 100755
--- a/scripts/prepare-kernel.sh
+++ b/scripts/prepare-kernel.sh
@@ -138,7 +138,8 @@ patch_link() {
 	done
 	if test x$reverse =3D x1; then
 		if ! find $linux_tree/$link_dir -not -type d | grep -q . ; then
-			rm -rf $linux_tree/$link_dir
+			# shellcheck disable=3DSC2115
+			rm -rf ${linux_tree}/$link_dir
 		fi
 	fi
 	)
--=20
2.35.3

