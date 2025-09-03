Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC302FE590
	for <xenomai@lists.linux.dev>; Wed,  3 Sep 2025 12:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756902931; cv=none; b=rju2gpcO3/nSusptFu3YzaxnsO6FK3u2YDAw/VY3yPUwg3n/QKQIjwuRyZiXUGGgHlHYXoq1/IavSN0Jz15MCZTBCoCUImKaCFfjHx/SICAXIumD/IuJ+3x4ZSTQY9XZ9s7r9i21tLUU1LfGYfbjf5UqklvEhJdAlS4RBIBfSbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756902931; c=relaxed/simple;
	bh=0QsmNhRUiQGk39brx/PKP3l9l4cH2NIPem7i4owYFtM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hqziqp1o7lBupratvnNZtZdy+jZ4Sxf8ZdiGvQDgIJ2/NLpz5CaOER9GUbgr6kanelgC7Qmd788xF8xEIQE4Yv0sXNe6hY7Oc8gEUnEfwKC5VT8Vi0v2Vv1sMxRdKEXsPq7/qsjswgsYjU4iKMoaeNLm4tqHHEOibNaV3qzEn/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=Quirin.Gylstorff@siemens.com header.b=UH23wp03; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=Quirin.Gylstorff@siemens.com header.b="UH23wp03"
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 202509031225139673fd378800020737
        for <xenomai@lists.linux.dev>;
        Wed, 03 Sep 2025 14:25:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=U7V2QzkCMpPQ+wATMI93qwk7BlM4LFcX7ydcAOPPgl4=;
 b=UH23wp03+/jSY7MdcY2MIox93u4EFGcd+jaeIbevg+Ew2yLhDLfCoU40q8S4fhGERvOONL
 XR7zaqAQAYuj+uEfKtj3yrUhm5YxZPu7x6xMPHrEdXMK3Qz5GBxOiAVyTbvFciFqtWgnW9rF
 Z0FoWC6zEaiYhLO2PA/yC3Jl2kI0hChp7e0rVcdZCSy+XRWhgK2IXGxt72bho8GGGTD+qfZu
 vhZ/fX/yllYcrgMmscKEnEqQKo5f/p1bcVQD2B/6ZP7bMeK2Ht3fEAhInMV74h7V5kXdt9d9
 H7kyr6HalGP2A7Cvtmqi5AK5cd3efRXA7rspjJmi5V5qYW6SV3EulgQA==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	xenomai@lists.linux.dev
Subject: [xenomai-images][PATCH 2/2] ci: retry 3 times to download the test report
Date: Wed,  3 Sep 2025 14:24:03 +0200
Message-ID: <20250903122513.1072751-2-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20250903122513.1072751-1-Quirin.Gylstorff@siemens.com>
References: <20250903122513.1072751-1-Quirin.Gylstorff@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Avoid a test failure due to connection errors.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 scripts/run-lava-tests.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/run-lava-tests.sh b/scripts/run-lava-tests.sh
index e97dd2a..649e2e6 100755
--- a/scripts/run-lava-tests.sh
+++ b/scripts/run-lava-tests.sh
@@ -93,7 +93,7 @@ api="${lava_master_uri}/api/v0.2/jobs/${test_id}/junit"
 auth="?token=${LAVA_MASTER_TOKEN}"
 url="${api}/${auth}"
 
-curl --silent "${url}" -o report.xml
+curl --silent --retry 3 "${url}" -o report.xml
 
 # change return code to generate a error in gitlab-ci if a test is failed
 if xmlstarlet sel -t  -v "/testsuites/testsuite/testcase[@name='job']/failure/@type" report.xml; then
-- 
2.50.1

