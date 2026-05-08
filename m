Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D3A384228
	for <xenomai@lists.linux.dev>; Fri,  8 May 2026 09:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778234333; cv=none; b=crmVNWqaUTw2csCP0LErlz8du2QQ+juW0K24WNDIa23Udid6uMD2mLuGiQb9we7uWXPSy0wrr4dYTolihHNMVMsbj4DXbeUkk0yNm43ezZDfHSolJmVB6nJBRaCX9uySkx7PWN02TJUkvXhzIQtgJ/qypl78JreoQ3k8zMW0Tn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778234333; c=relaxed/simple;
	bh=43UQlznyKgSxEhWDU3zdLLn8NXsiq/050B09QW3zlCM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KhjkKNZR1UES9m9OLNk61MFy3vEBvdAGVv2H9iHyD6qBRPqv6muGvvCDUg3RhnI6NEP8yzs/Ua6Q3vkQwYrdLlPL2vu8AVly8wEmbX67OrcmRGpZNmEYPV2RskIViN4l4cfQAHg6EAyZgr0P/D6loCYvVeolLttlb/DXPJMSDeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=FyuA5KEB; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="FyuA5KEB"
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 2026050809584581a1af23e7000207a0
        for <xenomai@lists.linux.dev>;
        Fri, 08 May 2026 11:58:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=ssaBcQdjsNd3sghwONLGSFQTakVUoSykgJZG8gXzsN4=;
 b=FyuA5KEBWVtDaoZlXPLbU16KV2MFT/PLkqcVDhgCrkozKTRrQ/zxDOMXg1ayRsCPw+ic1v
 rhs6ZqqMvwB5NzBNvhtw4etLsw1Ok+Az24WV/vMsxEZ5JzGARxEHEjCRPe/ghW/AW/8YWw6t
 eZhn+LemBaeRzkCW/DBpXg77yZdpj10dpzfbQeZCh2WWrkNedNml1Jq27D7S+qtNKXRR5JEg
 S45qc4oPd53o3DBWT2TGPCnj0o3k8YotafZbElii6FvLNnF8D2P/L46MTpczPoTwOaOE0EPh
 DFdrlic0NJghsXLPkci3cBoa359txb8acdmlBO9gXzXTzfPVn9Fh/c/Q==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH v2 0/3] Fix / improve some unit tests
Date: Fri,  8 May 2026 11:58:41 +0200
Message-ID: <cover.1778234324.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer

This is v2 for the 3rd patch in this series, properly setting up its
internal --vm argument passing. The other two are a related fix and a
refactoring.

Jan

Jan Kiszka (3):
  testsuite/smokey/alchemytests: Fix garbage args in case no --vm option
    is passed
  testsuite/smokey: Use XENO_CPU_AFFINITY envvar for psostests and
    vxworkstests as well
  testsuite/smokey/psostests: Avoid timeouts in over virtual
    environments

 testsuite/smokey/alchemytests/alchemytests.c |  3 +--
 testsuite/smokey/psostests/mq-3.c            | 10 ++++++++--
 testsuite/smokey/psostests/psostests.c       | 12 ++++++++++--
 testsuite/smokey/vxworkstests/vxworkstests.c | 10 +++++++++-
 4 files changed, 28 insertions(+), 7 deletions(-)

-- 
2.47.3

