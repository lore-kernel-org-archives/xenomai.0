Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF20B312825
	for <xenomai@lists.linux.dev>; Mon,  1 Jun 2026 10:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780310173; cv=none; b=mNvr7oWa1mcUWMjmZ4f+2D/hwJPTcwa4oxNKYFoe3e6bDP47jYVKS6/174PpvQknrl5nVAsl6/+WgyIb0XmhdXZh0FlkC/VjJ9Xaj0mDgSo6M3ddqMjFoWtPSwySOkEQnSjcOfiJJHt0XaC3M3ewKSgje9IklXXjsvgpZyiINkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780310173; c=relaxed/simple;
	bh=+DK9H4SYLq0QmRoyqF52cpsLQAcFbrFhJl5PWSuoRrA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ESA8tq88fOGr0FybaI1KiSMkfknwLbkV9+ju8kdZvu8UpmGDP/Q7NW1gQ3WBq7EXJDs9RSAGxGs90VuXAseAiD7fsqFM6yyrS6NfjaGXRniQYrzKkrpFRfQcXj9rMv4xQ29S0xsCiKmL649whnc8uNt4cLY1P0d3ZU80TAi6v14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=nEnN3RMs; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="nEnN3RMs"
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20260601103557a922c39b1700020734
        for <xenomai@lists.linux.dev>;
        Mon, 01 Jun 2026 12:35:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=UcyscMrXAqQFA0hluPkdJvPhYFLmWzVfneg8VhgXi4M=;
 b=nEnN3RMsWhzDpvwHSnDHgvcEq7SGp8OeqV06mgzPF9+K//e54nS1Gp02EsrTwvevbScAL9
 8f5UH+SycK2g/o3Ys0ddBOttgT1Sl5HQmClv339/JCmF8r0ITy6yu+hYar8vFRcW/iptOUIx
 Ke8Noru980nCK+njnpdA+te72kAiBMxXsQDi890QESDtRcaxJet15FPpBAzRcz5rCDqpP5Ps
 omsvb7F692TtN2fkWPIAG9FipjOL6bOYaxTgNu+YkUoa+UkNXjbOr2aABOzz1Bz1YFiL0Ehe
 vZRSQTEHkrl01cVRZ8Qr5Ug5y8vgjYiE81jE2odVHf73xzZilfGPCA7Q==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>,
	Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH xenomai-images] kas/ci: Fix bitbake variable referencing themselves
Date: Mon,  1 Jun 2026 12:35:49 +0200
Message-ID: <20260601103549.785345-1-florian.bezdeka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

When trying to run a local kas build using the kas/opt/ci.yaml option
file the following bitbake error occurred as the following two bitbake
variables were referencing themselves:

Variables:
  - AWS_ACCESS_KEY_ID
  - AWS_SECRET_ACCESS_KEY

Error:
bb.data_smart.ExpansionError: Failure expanding variable
AWS_ACCESS_KEY_ID, expression was ${AWS_ACCESS_KEY_ID} which triggered
exception
Exception: variable AWS_ACCESS_KEY_ID references itself!
The variable dependency chain for the failure is: AWS_ACCESS_KEY_ID

The problem only exists for local builds as the gitlab project
configuration defines such variables.

We can avoid the bitbake error by stopping forwaring the variables to
bitbake. We don't need those variables inside the build environment.
The only user is located in the deploy_to_aws.sh script, which is
executed on gitlab CI level.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 kas/opt/ci.yaml | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/kas/opt/ci.yaml b/kas/opt/ci.yaml
index e1466a0..01d5c07 100644
--- a/kas/opt/ci.yaml
+++ b/kas/opt/ci.yaml
@@ -23,7 +23,3 @@ local_conf_header:
     IMAGE_INSTALL:remove = "sshd-regen-keys"
     IMAGE_INSTALL:remove = "expand-on-first-boot"
     IMAGE_FSTYPES = "${@ 'ext4.gz' if d.getVar('MACHINE', True).startswith('qemu') else 'tar.gz' }"
-
-env:
-  AWS_ACCESS_KEY_ID: ${AWS_ACCESS_KEY_ID}
-  AWS_SECRET_ACCESS_KEY: ${AWS_SECRET_ACCESS_KEY}
-- 
2.54.0

