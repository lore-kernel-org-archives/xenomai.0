Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BFE7247286
	for <xenomai@lists.linux.dev>; Mon, 14 Apr 2025 14:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744639859; cv=none; b=aN6skSDgLjhv7iEWhDcz3jOGtmKvFTU5ty9NgblxrhD0ToWGTIBrs9Qe91n1vTH4PF7LGohJ6ejaLHzrPf26pJ5ggRdGSWy7zgK2UkPHha37lg0HaA8uMstZQliUFi0hoj4Q907rsMnl2usG9YFF+ma9PnPT2tSj2GWI32W4jGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744639859; c=relaxed/simple;
	bh=SgakcmbLQn6hIbgn5ew0B5hRmA96OxfwT5oFeyuopG0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XcTeBUWV64YkqZJCRMkUPN8kysJg/qxrKBmIak74c3P4uh/RcJ0HZ/5FFldbxOKNq3E5jQalgGcEiwdXqMfPOrj6c3EuUi7BD1GhIJvXSUGhFIaKU5/J89YmLlbr6zFkR42TrlZ1PHyCd12GZT2YCEd8GAQ7gXOF33fgbonIM5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=HM23iXhS; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="HM23iXhS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=0Yaib
	OEXzXaI1eFj2LkmEpzlSLvEwBxUMGDwelyvTW0=; b=HM23iXhSEA2yrpNFjsi4C
	7TTsN4JsU62ONcoliAQlUr1uY4R7Ap2rOWmp8eNg56oh/Q4N3nVRMiqWoRnxJ/dM
	qREoKyKvk/qzTUdBOrZ7mEaNrDjn1harFXCXupEA7N8UWwwRQdSFc1jI/U4GyOop
	oo+k7uUjpMZkWjeQu3uzUg=
Received: from u2204.. (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgD3HwxqF_1nHU2rAQ--.11961S2;
	Mon, 14 Apr 2025 22:10:51 +0800 (CST)
From: Haiyang He <aspirestro@163.com>
To: jan.kiszka@siemens.com,
	florian.bezdeka@siemens.com,
	richard@nod.at
Cc: xenomai@lists.linux.dev,
	Haiyang He <aspirestro@163.com>
Subject: [PATCH] prepare-kernel.sh: expand tilde in --outpatch path parameter
Date: Mon, 14 Apr 2025 22:10:34 +0800
Message-Id: <20250414141034.1682520-1-aspirestro@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgD3HwxqF_1nHU2rAQ--.11961S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7XF48uw45AFWDZr1rJrW3GFg_yoWDtrXE9r
	s3tr9Igr4jywsxK3WrCFW3tr1ktr9rZ34xW345Zr17tw1kGFsakFs5Jr93J3WUZrZ7KF98
	C34Yvw42vF48XjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRRApnDUUUUU==
X-CM-SenderInfo: pdvsx2xhvw20i6rwjhhfrp/1tbiXBovcWf9Ec+zjAAAsj

Ensure shell expands tilde (~) in the --outpatch parameter path the
same way as --linux and --dovetail parameters. This fixes
"cd: can't cd to ~" errors when using home directory shortcuts in
output path.

The issue occurred because the ~ character in paths was not expanded
before directory operations.

$ ./scripts/prepare-kernel.sh \
--linux=~/xenomai/linux-dovetail \
--arch=arm64 \
--outpatch=~/xenomai.patch
./scripts/prepare-kernel.sh: 1: cd: can't cd to ~

Signed-off-by: Haiyang He <aspirestro@163.com>
---
 scripts/prepare-kernel.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/prepare-kernel.sh b/scripts/prepare-kernel.sh
index ecc830fd2..e15c1fe6e 100755
--- a/scripts/prepare-kernel.sh
+++ b/scripts/prepare-kernel.sh
@@ -139,6 +139,7 @@ while test $# -gt 0; do
 		;;
 	--outpatch=*)
 		output_patch=`echo $1|sed -e 's,^--outpatch=\\(.*\\)$,\\1,g'`
+		output_patch=`eval "echo $output_patch"`
 		;;
 	--filterkvers=*)
 		echo "$me: warning: --filterkvers= is deprecated and now a no-op" >&2
-- 
2.34.1

