Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705CF1363
	for <xenomai@lists.linux.dev>; Fri,  3 Mar 2023 08:38:16 +0000 (UTC)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 202303030838070ea718fd8aad5d2289
        for <xenomai@lists.linux.dev>;
        Fri, 03 Mar 2023 09:38:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=tv8HvGgVgA0Wr0+pDR6/BVUWkhe5FrWyRuIMO7EIkis=;
 b=PSfxyVDkb2EaVczop1JczbJtC1mGTL6m6QHYRMkpW98tCgsgEN1LdMHCQkgmQgr4DS+MOj
 9Ft0Eyzohh5zyKi4YipTfZPtzbxkpkElmbaCatngvFp+j/T1TrNFZPv8BwejDjdp8g4Z5dvE
 FvQtFztEdSohV/hsS+ZSJgCR6Ltf8=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH] config: Bump version number
Date: Fri,  3 Mar 2023 09:38:05 +0100
Message-Id: <20230303083805.3211325-1-florian.bezdeka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

The compiled-in version number for master/next branch was invalid.
That caused some confusion after updating from one of the stable
branches to master/next.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 config/version-code  | 2 +-
 config/version-label | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/config/version-code b/config/version-code
index e4604e3af..172b71c92 100644
--- a/config/version-code
+++ b/config/version-code
@@ -1 +1 @@
-3.2.1
+3.3-dev
diff --git a/config/version-label b/config/version-label
index e4604e3af..172b71c92 100644
--- a/config/version-label
+++ b/config/version-label
@@ -1 +1 @@
-3.2.1
+3.3-dev
-- 
2.39.2

