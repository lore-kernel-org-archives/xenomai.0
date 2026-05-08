Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B20378D92
	for <xenomai@lists.linux.dev>; Fri,  8 May 2026 06:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778221403; cv=none; b=Dvd7D/aocSv6+dHc1vUBSPowEWjMrAI20ORSos1rJZxr3ZSQWVeComXsi7Ksa63d8UmYjLx2HLoNSv0SD9illkjlO+84iBAMyLATfozWseCiM7cWIiN8oWj8REscQ9eEYG3xAPb7xv08Tt2wLMexs5Pq3OBpQRKVb/H06XtvP3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778221403; c=relaxed/simple;
	bh=Uwl8zxgsnHtg+54QYLytlRmVzQ+G++uhdLNTnooOZhU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sq1w0/OXNq2y62wkcZurmsqzCIMJ3wVhGtgRt6E1/PjhFkaD9pzvxMvdv/dBmXuHYjpC6sb9YbpiqU0SupM9/zWnutOluIBs3WhE1GtjSgH/Ye/bKJ8Bvqn39z5mbqSpjMB0hPceo3htjF9Gzse1UNXRG20GSycC+2/h0n6GiWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=OuTFMz7n; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="OuTFMz7n"
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20260508062306d0fc831938000207c2
        for <xenomai@lists.linux.dev>;
        Fri, 08 May 2026 08:23:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=a2SJcgIL0G49mQA40LNII+zVampoaN3moVvZbXcjUKw=;
 b=OuTFMz7nQhXEXcSMGn6DxqJAmUby6aKtrfigaKPoXeQF90mmvfDxr5t2jRdYCJUarqouJ4
 AjVv74ptsQbm+4iZG7LL1WaHwDcRFZjkHuU3MHlNrjLxxh0CRujYBHcLqVOxHMMR2TKX8NLg
 XhoGvoO0fI6SbxphPoxLe2+ATN/FTB9k9Urv6Meh/HVK6yA3aUYKkPLxyNfZ5Xgi/x0r23ct
 0NGUC88yLfb8qva2nz6DxBapMCPUSrCLmCukLbE4m9rMG7qyGVPwgkbFVEOotE5xPR6Xytu3
 GI4l7ctcvzOmlekp0yPvsesAAbZKzwZxl3Dbv6YGPmMQsbBFTe33oW3Q==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Fri, 08 May 2026 08:23:05 +0200
Subject: [PATCH 32/32] clang-format: Enable sorting of includes
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260508-wip-flo-refactor-includes-v1-32-e449f2bd4fc2@siemens.com>
References: <20260508-wip-flo-refactor-includes-v1-0-e449f2bd4fc2@siemens.com>
In-Reply-To: <20260508-wip-flo-refactor-includes-v1-0-e449f2bd4fc2@siemens.com>
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

The includes of all touched files have been sorted/formatted by
clang-format with this option enabled. Keeps us one step closer to
auto-formatting.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 .clang-format | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.clang-format b/.clang-format
index 2ffd69afc1a8280654a8763e044e27e08be7a69f..d1bdccb8480a54eb82d878d386a6621efb77b9e8 100755
--- a/.clang-format
+++ b/.clang-format
@@ -471,7 +471,7 @@ PenaltyReturnTypeOnItsOwnLine: 60
 
 PointerAlignment: Right
 ReflowComments: false
-SortIncludes: false
+SortIncludes: true
 #SortUsingDeclarations: false # Unknown to clang-format-4.0
 SpaceAfterCStyleCast: false
 SpaceAfterTemplateKeyword: true

-- 
2.54.0

