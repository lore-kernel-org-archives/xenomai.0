Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332C31FB5
	for <xenomai@lists.linux.dev>; Thu, 23 Feb 2023 07:40:51 +0000 (UTC)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20230223074049f7459eebe8e3855517
        for <xenomai@lists.linux.dev>;
        Thu, 23 Feb 2023 08:40:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=Hv6hk3jNiqYHsl4VH5p1n58jLVPszhbjEHKgweoNtLU=;
 b=VVrd1VtEci7gS5Bkcim8Jjv6+R7AEhf/3YgFBB2+RzaoOJdA8eC5alu4aOGCKiAjXFr7HY
 aq+tHLolR2hK5kmljXNq4/vke1lMjcyBONVcA7T5oRZazuSbsgPIdBvq/39c5taA8cmwwykt
 eUAzbM9ZzmBOWZMp5PPrIr7mVodo4=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [xenomai-images][PATCH 1/2] ci: Fix handling of lava test failures
Date: Thu, 23 Feb 2023 08:40:46 +0100
Message-Id: <20230223074047.3974956-2-florian.bezdeka@siemens.com>
In-Reply-To: <20230223074047.3974956-1-florian.bezdeka@siemens.com>
References: <20230223074047.3974956-1-florian.bezdeka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

There are two kinds of errors that can happen:
 - errors: Like LAVA infrastructure problems
 - failures: Like failing testsuites

We should check both of them to get the right signal back to gitlab-ci.

In my case I was expecting some test failures but was getting a "green"
pipeline result. The test log clearly showed that the tests failed as
expected but the gitlab-ci pipeline result was wrong.

A simplified junit test report (provided by LAVA) is provided below.
The first matches of "errors=" and "failures=" provide the full test
job result.

<?xml version="1.0" encoding="utf-8"?>
<testsuites disabled="0" errors="0" failures="1" tests="25" time="176.49">
	...
	<testsuite ...></testsuite>
	...
</testsuites>

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 scripts/run-lava-tests.sh | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/scripts/run-lava-tests.sh b/scripts/run-lava-tests.sh
index 70deb36..10c60bc 100755
--- a/scripts/run-lava-tests.sh
+++ b/scripts/run-lava-tests.sh
@@ -2,7 +2,7 @@
 #
 # Xenomai Real-Time System
 #
-# Copyright (c) Siemens AG, 2019-2020
+# Copyright (c) Siemens AG, 2019-2023
 #
 # Authors:
 #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
@@ -16,6 +16,14 @@ if [ -z "${TARGET}" ]; then
     exit 1
 fi
 
+get_first_xml_attr_value()
+{
+	file=${1}
+	tag=${2}
+
+	grep -m 1 -o "${tag}=\".*\"" ${file} | cut -d\" -f2
+}
+
 # S3 artifacts
 artifact_url="${LAVA_ARTIFACTS_URL:-https://d1a54g2tyy2hl.cloudfront.net/artifacts}"
 # public master
@@ -51,8 +59,9 @@ url="${api}/${auth}"
 curl --silent "${url}" -o report.xml
 
 # change return code to generate a error in gitlab-ci if a test is failed
-number_of_fails="$(grep -o "errors=\"[0-9]*\"" report.xml | head -1  | cut -d\" -f2 )"
+errors=$(get_first_xml_attr_value report.xml errors)
+failures=$(get_first_xml_attr_value report.xml failures)
 
-if [ "${number_of_fails}" -gt "0" ]; then
-    exit 1
+if [ "${errors}" -gt "0" ] || [ "${failures}" -gt "0" ]; then
+	exit 1
 fi
-- 
2.39.1

