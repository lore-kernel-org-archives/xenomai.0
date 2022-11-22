Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C777217CA0
	for <xenomai@lists.linux.dev>; Tue, 22 Nov 2022 22:26:37 +0000 (UTC)
Received: from spool.mail.gandi.net (spool1.mail.gandi.net [217.70.178.210])
	by relay.mail.gandi.net (Postfix) with ESMTPS id D5295C0004
	for <xenomai@lists.linux.dev>; Tue, 22 Nov 2022 22:26:29 +0000 (UTC)
X-Envelope-To: xenomai@xenomai.org
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 77FD2941D94
	for <xenomai@xenomai.org>; Tue, 22 Nov 2022 22:26:29 +0000 (UTC)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20221122222629ec628e4dd947fa0c5b
        for <xenomai@xenomai.org>;
        Tue, 22 Nov 2022 23:26:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=A7IXwbYU9i4EkAQsIu+6XAS8VtNsSLwnGU/5KDPNZ1A=;
 b=KBEg4eUSwQ5vTCekubi4NPUpHb3q+xxW2TotMawznlQSQjnPFIsWbjri+M+KLt3qQXJZaO
 8RJxX0ByNsixpGsva4L0gd0rI9dlYPrRdth7Ti86DLqZYpMy2Osmg6crSQ+61PPOKNOHAo9r
 j1RQYswMzEX86lzHu6hGfVFKItsK0=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@xenomai.org
Subject: [PATCH 8/8] ci: Mark build jobs interruptible
Date: Tue, 22 Nov 2022 23:26:26 +0100
Message-Id: <5e0292d1e9bcbb8c9920572b7b396708bcfd8262.1669155986.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1669155986.git.jan.kiszka@siemens.com>
References: <cover.1669155986.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
Received-SPF: pass (spool1: domain of rts-flowmailer.siemens.com designates 185.136.64.228 as permitted sender) client-ip=185.136.64.228; envelope-from=fm-294854-20221122222629ec628e4dd947fa0c5b-91cVd5@rts-flowmailer.siemens.com; helo=mta-64-228.siemens.flowmailer.net;
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=siemens.com header.s=fm1 header.b=KBEg4eUS;
	spf=pass (spool.mail.gandi.net: domain of fm-294854-20221122222629ec628e4dd947fa0c5b-91cVd5@rts-flowmailer.siemens.com designates 185.136.64.228 as permitted sender) smtp.mailfrom=fm-294854-20221122222629ec628e4dd947fa0c5b-91cVd5@rts-flowmailer.siemens.com;
	dmarc=pass (policy=none) header.from=siemens.com

From: Jan Kiszka <jan.kiszka@siemens.com>

That should give the auto-cancel option its desired power.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .gitlab-ci.yml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 2b62f1a736..4d207dbd61 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -175,6 +175,7 @@ variables:
     - ./configure --enable-smp ${CONFIGURE_OPTS}
     - make -j $(nproc)
     - ccache -s
+  interruptible: true
   cache:
     key: "$CI_JOB_NAME-$CI_COMMIT_REF_SLUG"
     paths:
-- 
2.35.3

