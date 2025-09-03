Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0317C253B52
	for <xenomai@lists.linux.dev>; Wed,  3 Sep 2025 12:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756902323; cv=none; b=eIx88jdDMDPSL/CH1M0OnLxIitT/k1F6K20+Ii6UJQ1M2ScJmtpIVey0Wcbs2vA68zawGsqYwNkjBg03TxlJiLaC1TfyOGE1XGQu9508eMwFDlo08V6x8LRrPGGZdgPWBstRjmaMUM/QgDq7E7NHigQ0hKhpHmcP1pC6TPivgbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756902323; c=relaxed/simple;
	bh=RouOqqmE5AF7fzZux2cvqzH2kQtGnv4HQF0EIUqVG+Q=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=S9X9rlFQ2QkfeJznmdtaq8HlJNU09F4ChLrEX4GZchXv+iLceUXEYtjsx8I9IiuEPNPbqOtjGRdbpPkM26/dnZiFVpHQfrBwDZldAWFfxExsjhjUYTMEeoXQSmWqYGkQLcBY10UtZLPEdhlXwAr5CpQUqLT2P3XSQ23Jn22LNJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=Quirin.Gylstorff@siemens.com header.b=VfvwbPdH; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=Quirin.Gylstorff@siemens.com header.b="VfvwbPdH"
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20250903122513e7c9a263a4000207ed
        for <xenomai@lists.linux.dev>;
        Wed, 03 Sep 2025 14:25:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=lG2aApa6RFcQ6/MHMnCqhP9Ek8HyQT/2M3AZ18CxQ6M=;
 b=VfvwbPdHDOkT4nuayptQXsnWRo40HEEI8KSf5ECxhvi+5gcXYl90IYSbBNbcRr2K05AlK6
 76hSA/Wq/wFkrKI5my8fvMvzC2l4gK5zwwjCx4/NbZCtvyM7/JBREi3uo43ezCkxU5KZ1IpA
 ZeiMqNIHX6ShrKB8E6bWyXRfOyLVoxxIWR428R457CFSB6FP36hEADcKu1gmiMxXFU4PVBes
 1mi1vSv7oWSeBFGHZuH98MCy5Cvpv2xlDEOvmcENTyT3lTEHmyutjrEy3zPdwA7sdaSX0Tuv
 yS1SpmA9UZ4BlmJrjbrinWJJF1EZcSGWoqtVnCVuLh+DkZVQB84xYV3Q==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	xenomai@lists.linux.dev
Subject: [xenomai-images][PATCH 1/2] ci: check the device health
Date: Wed,  3 Sep 2025 14:24:02 +0200
Message-ID: <20250903122513.1072751-1-Quirin.Gylstorff@siemens.com>
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

Check the device health and the device state. If the device is not
healthy or the state is not idle try for "WAIT_FOR_DEVICE_TIMEOUT"
minutes until aborting the test.

The default of the variable WAIT_FOR_DEVICE_TIMEOUT is 10.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 scripts/run-lava-tests.sh | 36 ++++++++++++++++++++++++++++++++++--
 1 file changed, 34 insertions(+), 2 deletions(-)

diff --git a/scripts/run-lava-tests.sh b/scripts/run-lava-tests.sh
index 0971385..e97dd2a 100755
--- a/scripts/run-lava-tests.sh
+++ b/scripts/run-lava-tests.sh
@@ -24,6 +24,23 @@ get_first_xml_attr_value()
 	grep -m 1 -o "${tag}=\".*\"" ${file} | cut -d\" -f2
 }
 
+get_device_state()
+{
+	device_type=$(grep -oP 'device_type: \K.*' "$1")
+	devices=$(lavacli device-types show "$device_type" --json | jq .devices[] --raw-output)
+	for device in $devices; do
+		device_json=$(lavacli devices show "$device" --json)
+		state="$(echo "$device_json" | jq -c 'select(.health == "Good" or .health == "Unknown") .state' --raw-output)"
+		if [ "$state" = "Idle" ]; then
+			break
+		fi
+	done
+	if [ "$state" != "Idle" ]; then
+		return 1
+	fi
+	return 0
+}
+
 # S3 artifacts
 artifact_url="${LAVA_ARTIFACTS_URL:-https://d1a54g2tyy2hl.cloudfront.net/artifacts}"
 # public master
@@ -42,12 +59,27 @@ TEST_TIMEOUT_MINUTES=$((TEST_RUNTIME_SECONDS / 60 + ADDITIONAL_TEST_TIMEOUT_MINU
 export TEST_TIMEOUT_MINUTES
 
 echo "Deploy artifacts from '${artifact_url}'"
+test_definition="tests/jobs/xenomai-${TARGET}.yml"
 
 tmp_dir=$(mktemp -d)
 template="${tmp_dir}/job_${TARGET}_${CI_PIPELINE_ID}.yml"
 
-cat "tests/jobs/xenomai-${TARGET}.yml" | envsubst > "$template"
-
+cat "$test_definition" | envsubst > "$template"
+
+echo "check for device"
+time_elapsed=0
+while true; do
+	if get_device_state "$test_definition" ;then
+		break
+	fi
+	time_elapsed="$((time_elapsed+1))"
+	if [ "$time_elapsed" -gt "${WAIT_FOR_DEVICE_TIMEOUT:-10}" ]; then
+		echo "An test device for '$TARGET' is not available"
+		exit 1
+	fi
+	echo "Wait for test device '$TARGET'"
+	sleep 60
+done
 echo "Submit lava job"
 
 test_id=$(lavacli jobs submit "${template}")
-- 
2.50.1

