Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9312118C31
	for <xenomai@lists.linux.dev>; Mon,  9 Sep 2024 20:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725913471; cv=none; b=JtaXngdBr/gDwU9jTz2V+03jSXXWoiNzb5W+wqM/nGrKhfvrI/oWaMZj9YeCxPSprrF9IOL8+R8oCi2f8w8NAZMp+a3uNTNROkQV/XSjmQcCU2xjn3+fKOa3TF3wmQv4tTBjfX3tXn4CDaZPKCQWQ9UxAfosCfm4QQXuiwWGqCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725913471; c=relaxed/simple;
	bh=S54yXkkymqGzoqYkh+lSsXzWPrBOVvLzp/B8c1EJ3cI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PHmVm01qdqowPHI5YjpsF8+HcLH6y8laLjqkCLSRkoCL5RmYR4QBFQwcOMnmcxWESIYS3OCCHRfO2pR3anAwsh7OvUOBvabkPCbVAhz9BYgAqev3RDQ/YE6QI0s97M9X2AHkr0kBsI0ABhY4QWOZWIS64IgY5agDEH2UnB7bsc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=bg8qeyLz; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="bg8qeyLz"
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 202409092024219760fe0c6faa711c9a
        for <xenomai@lists.linux.dev>;
        Mon, 09 Sep 2024 22:24:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=KhLmrhQbXkpRZPv5RXkgxpkYQIpLNys/7P7XjrmxNew=;
 b=bg8qeyLzxWCZCufb/nEK21NJXmwwowd9/fdkG9SmlY01zsa7g4qxd4w/JoTZcyadZHfzmm
 KXbapdDuCFD5bRVzGF7yygJKK6DpQgexxV7TshdEewI/t48ov8ic6viPL5DqRLM6hdiYTwiF
 fPnLM0yl4EwDvGUpAbnhXt48gRXdcwWqs5prh2Ce7+hfj8inHYWZ1rV/RijJeEPQCcA5Ppv/
 zw94B0000w/IKJ1WU7tDahC9EYR89/OobesZf8DM6Zqbsqw8OY1o+vyBYq3j0Ay8wAEtPeqk
 9qiQLJ5mmUaI2tRjKGaIZhMpmZ1pE9GIQ5GT9DSZd9gTa6n44t16lAYA==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>,
	Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH] prepare-kernel.sh: Mark i*86 as unsupported architecture
Date: Mon,  9 Sep 2024 22:24:16 +0200
Message-Id: <20240909202416.4079348-1-florian.bezdeka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

We do not support i*86 kernels for some years now. The prepare-kernel
script should bail out if someone tries to prepare such a kernel.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 scripts/prepare-kernel.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/prepare-kernel.sh b/scripts/prepare-kernel.sh
index 0afb812a4..ecc830fd2 100755
--- a/scripts/prepare-kernel.sh
+++ b/scripts/prepare-kernel.sh
@@ -217,7 +217,7 @@ if test x$linux_arch = x; then
 	target_linux_archs="x86 arm arm64"
 else
 	case "$linux_arch" in
-		x86*|i*86|amd*)
+		x86*|amd*)
 		target_linux_archs="x86"
 		;;
 	arm)
-- 
2.39.2

