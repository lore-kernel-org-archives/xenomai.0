Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E99A1A08C3
	for <xenomai@lists.linux.dev>; Mon, 24 Jun 2024 20:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.40.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719261248; cv=none; b=nxtI7I5+lGAuvOeSsG1GD1Kz1zSwQjGyu6G5C6eVDwwaKbgSyBXmHDzFEWycfF8sKnmTBK5hWJj66WoLaA0eH+jqY4Kk6JqzChkUGNysLSKhBWUGx2fN4tioDZ61C6HmujuT2he6q3CO28Np9n0wz2Y9OGMqq+8EN/yzID7mOzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719261248; c=relaxed/simple;
	bh=/b+dONBo4tId2pAFkoi9XfleHiL16OzXyrDCQZP7Mos=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dhkCiWvu6Z5t5KpYP5SlhAJwCA1sVAlqpkc6DUyc2Gw5mEQecqcqhhLKxPDZrN9I64TNMSaK6pC9WvkXDzIP4Wih6aksYbxKz4RxLHMJwdpSwY9g3ZSuYDauMBXpg1y3eTDIm5q6jSasDZpcQpbMFRH+T4slByn95FIYp4ZtfU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=195.201.40.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 6D73C6195FE0;
	Mon, 24 Jun 2024 22:33:55 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id XE_qMXCoOzup; Mon, 24 Jun 2024 22:33:55 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 06F116195FCC;
	Mon, 24 Jun 2024 22:33:55 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id I85Li_cvM6Ak; Mon, 24 Jun 2024 22:33:54 +0200 (CEST)
Received: from foxxylove.corp.sigma-star.at (unknown [82.150.214.1])
	by lithops.sigma-star.at (Postfix) with ESMTPSA id 96FFB6196386;
	Mon, 24 Jun 2024 22:33:54 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: xenomai@lists.linux.dev
Cc: upstream+xenomai@sigma-star.at,
	Richard Weinberger <richard@nod.at>
Subject: [PATCH 11/14] prepare-kernel.sh: Define command line variables
Date: Mon, 24 Jun 2024 22:33:38 +0200
Message-Id: <20240624203341.6263-12-richard@nod.at>
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

To use "set -u" later, define all variables that can be set via the comma=
nd line.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 scripts/prepare-kernel.sh | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/scripts/prepare-kernel.sh b/scripts/prepare-kernel.sh
index cc1907b63..e1d1c318d 100755
--- a/scripts/prepare-kernel.sh
+++ b/scripts/prepare-kernel.sh
@@ -3,9 +3,6 @@ set -e
=20
 unset CDPATH
=20
-# Default path to kernel tree
-linux_tree=3D.
-
 patch_copytempfile() {
 	file=3D"$1"
 	if ! test -f "$temp_tree/$file"; then
@@ -120,6 +117,14 @@ generate_patch() {
 usage=3D'usage: prepare-kernel --linux=3D<linux-tree> [--dovetail=3D<dov=
etail-patch>] [--arch=3D<arch>] [--outpatch=3D<file> [--verbose] [--rever=
se]'
 me=3D`basename $0`
=20
+# Default path to kernel tree
+linux_tree=3D.
+output_patch=3D""
+linux_arch=3D""
+reverse=3D0
+pipeline_patch=3D""
+verbose=3D0
+
 while test $# -gt 0; do
 	case "$1" in
 	--linux=3D*)
--=20
2.35.3

