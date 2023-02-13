Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C821FB6
	for <xenomai@lists.linux.dev>; Mon, 13 Feb 2023 07:11:29 +0000 (UTC)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 202302130701187ed9c6e2bbc5c87412
        for <xenomai@lists.linux.dev>;
        Mon, 13 Feb 2023 08:01:19 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=EJyCznucPcRyL09poItOF6vFRg5E9BMhHq5Nw4aC1sk=;
 b=nSuzPXVjw39U+v35WCo2AYD/QiHMhYYRN2HhLq1ucFfp49bXsb+qcMYUqDNI8WhRYjnqtn
 Wcfy3Htqkeko9DhwFSld30On8LzjI8yhMkmxhepZqhUPzaHU4Q12uesOcTHHm5WC+VoxIVul
 xCQJPx6zVfr7vbp9T/+ZzGX8elaPg=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Subject: [xenomai-images][PATCH 5/7] Kconfig: Enable kernel 5.15 for xenomai 3.2 head
Date: Mon, 13 Feb 2023 08:01:14 +0100
Message-Id: <0ca14b74117f723c5b809c73dfb85e2d753cd827.1676271676.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1676271676.git.jan.kiszka@siemens.com>
References: <cover.1676271676.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer

From: Jan Kiszka <jan.kiszka@siemens.com>

No release with this support yet, so only enable XENOMAI_3_2_LATEST.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Kconfig b/Kconfig
index b49e22d..953634e 100644
--- a/Kconfig
+++ b/Kconfig
@@ -103,11 +103,11 @@ config KERNEL_6_1
 
 config KERNEL_5_15_LATEST
 	bool "Head of 5.15 Dovetail branch"
-	depends on XENOMAI_LATEST
+	depends on XENOMAI_LATEST || XENOMAI_3_2_LATEST
 
 config KERNEL_5_15
 	bool "Latest 5.15 Dovetail version"
-	depends on XENOMAI_LATEST
+	depends on XENOMAI_LATEST || XENOMAI_3_2_LATEST
 
 config KERNEL_5_10_LATEST
 	bool "Head of 5.10 Dovetail branch"
-- 
2.35.3

