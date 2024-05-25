Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1000A3E462
	for <xenomai@lists.linux.dev>; Sat, 25 May 2024 11:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.40.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716638322; cv=none; b=oVE8icM67356FMhC8Kq57/IBpixUPBEYkbbBU8mHY9BV81H7y8VS4SDwNq55oWJE8yXDBLbnjumr7TjbsdTQej+DaNpmYMPqQwBe1xIjaZAljvvFj5YuU7iTXGjA2c8MFAz27NRSOKIFugVJ6gkg106GxwpaOSypGRdG9PMvago=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716638322; c=relaxed/simple;
	bh=LaKFK6DnsDp30R4r6bx8xxEfv6TsLzBQus25NCp8nPw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FnvnDDruj9EoBg8bDkkE7JC1eA9EX/FcirIVuyRLR8CwIuFqHJ5ECGW0pObLh1JsgyHrK5Jd70JajQxer0rmkU7rbRFH4kXzFYkaQcLQ9Z4TO3jJgDeHq4wQfPCxQcSCT/m/qp++ZVEfczOXIpJ2bDDXbzNk+W9Y2OJK5jZd9X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=195.201.40.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 80AB564103FF;
	Sat, 25 May 2024 13:58:29 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id zqMiSAH-3x_m; Sat, 25 May 2024 13:58:29 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 2E8AF64103ED;
	Sat, 25 May 2024 13:58:29 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 5XjWmm8t48Zi; Sat, 25 May 2024 13:58:29 +0200 (CEST)
Received: from foxxylove.corp.sigma-star.at (unknown [82.150.214.1])
	by lithops.sigma-star.at (Postfix) with ESMTPSA id D8E4A6340E1A;
	Sat, 25 May 2024 13:58:28 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: xenomai@lists.linux.dev
Cc: upstream+xenomai@sigma-star.at,
	Richard Weinberger <richard@nod.at>
Subject: [PATCH 06/16] prepare-kernel.sh: Disable SC2115 warning around $linux_tree
Date: Sat, 25 May 2024 13:57:56 +0200
Message-Id: <20240525115806.12101-7-richard@nod.at>
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

The script makes sure that $linux_tree is valid, it cannot be empty.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 scripts/prepare-kernel.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/prepare-kernel.sh b/scripts/prepare-kernel.sh
index d8d63397d..e78c48e61 100755
--- a/scripts/prepare-kernel.sh
+++ b/scripts/prepare-kernel.sh
@@ -135,7 +135,8 @@ patch_link() {
=20
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

