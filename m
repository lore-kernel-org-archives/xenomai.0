Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C94E1D63DF
	for <xenomai@lists.linux.dev>; Mon, 28 Oct 2024 13:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730123701; cv=none; b=dJsdZs05W3GdA0/8TGbJurxFGvGWTaMwnRQBO3dB7Ec3tJJ/KAAs7/hGldo747b4bR2AE6nyD+Qzwl1znDniWfWt4cEVbpyADWHRAzVPnknT4icFmc+VVx8TjRrBggJgCYkJrf1OM88VqXN3LnhJRfgarkG/gb9g+tHX0B7nRoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730123701; c=relaxed/simple;
	bh=wJBa0cE/mpuLtGmcTa3p4kNc3PA8Qn7AP21J4+tQt9U=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ac9UFFFvo+drFPqAldti3BEDL51nSpfZdI0RfBrxAQtm7+xeomJ8D1mf713ey1p90kqXjcUhAirPJ337Okibw7rT7LgEkkWh3MCM0ARDUGBeD7hOEQHbDXpBWMF13lduE5aOAVTjTM3n62hyHsoObBhSmoPaNg/uR06qJT15QH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=breqSKDb; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="breqSKDb"
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 202410281344458b4ccac7c530c64611
        for <xenomai@lists.linux.dev>;
        Mon, 28 Oct 2024 14:44:46 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=+K4EXOX7j72CMbGwF/ZPUbspZyQk+ZmUt7uq+mAlO/E=;
 b=breqSKDbwzvqwXop/mDQowRxqOidPD3Iqo51aD7lpjvtumbE7AFVU2IBtgUBq2sVwjpErw
 x0xGNYhsU3rMCBXduBKtEjoUwZlWH2c3v5kYC4y+2eVjKtPJ7Bnue3DtFrANXCuZxxn0hmd3
 zt7rU0+30EMmmoYrIOkUKvXDU1xiLSaQmbt+NwKsU9vhU2Zm1UoQGGCRHYN5z0t+17QLROi4
 U+yTpDMY5uFRFRxtczZKTLVZjDtiPRP0644RqQ3IXwTVdtcH75k0gDWD40pwK0KNY0ghc4W3
 CiNKtstH3GcFAJCauBO8N85YwvtMYNh0hR/X95LAl7VD9gIRey3SWtyw==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Subject: [xenomai-images][PATCH 3/6] Update isar revision
Date: Mon, 28 Oct 2024 14:44:41 +0100
Message-ID: <bdc63965229676c2fa97f2bc75c72b254bc46f27.1730123084.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1730123084.git.jan.kiszka@siemens.com>
References: <cover.1730123084.git.jan.kiszka@siemens.com>
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

Resolves some false-positive variable export warnings in CI, otherwise
just housekeeping.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kas.yml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kas.yml b/kas.yml
index c0cce41..d2554d3 100644
--- a/kas.yml
+++ b/kas.yml
@@ -1,7 +1,7 @@
 #
 # Xenomai Real-Time System
 #
-# Copyright (c) Siemens AG, 2018-2023
+# Copyright (c) Siemens AG, 2018-2024
 #
 # Authors:
 #  Jan Kiszka <jan.kiszka@siemens.com>
@@ -22,7 +22,7 @@ repos:
 
   isar:
     url: https://github.com/ilbers/isar.git
-    commit: 1372f428223aea046e8efaa04202093d0d73c52e
+    commit: 2480baaa18b097c39d6e68b2ac7d6fabd6ff8ab9
     layers:
       meta:
 
-- 
2.43.0

