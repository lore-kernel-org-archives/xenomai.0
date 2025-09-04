Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA632C0307
	for <xenomai@lists.linux.dev>; Thu,  4 Sep 2025 09:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756978223; cv=none; b=H72sw+yA4+wTSSXUBaYR+xE0x1R5d/tQeg7kJVuQ9vbPtRE413jDX3UoUpl/iP04D2kQpZ42OQPptUSjZw3dfk1ZGPmaCg2QS5lUOWeLNNzn5au/jSewmb9oVHHatoB4JeKUsvawdZbjuEw227/vf+EQH8umdNXCbhqPlT3AGog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756978223; c=relaxed/simple;
	bh=wTJmC2gs69gJKlWhJKgO3yDINQj8Cb3bK8TuPxKwyj0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=eWI9G1pQ8LS1A6i2lJWznmU+ttn+khgEurqpTXRVilz3+KSF15bJTkKdrQOvu1lUJ0wiPg9YVLXLN4L2Pwy5xOGkRObCnaPVNuo9Wa96ixvucq1tvJLMUQaigInU8BfMLEntmomovHzJ5Q8Iv7o6uxjmFVtM3Yh0KK6iUAl2bF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=Quirin.Gylstorff@siemens.com header.b=RNFTTMR5; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=Quirin.Gylstorff@siemens.com header.b="RNFTTMR5"
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 202509040930143da53c305100020782
        for <xenomai@lists.linux.dev>;
        Thu, 04 Sep 2025 11:30:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=cHTGkgx8TQk2BjWJZ7adCCtYR8em8Tzav98RgSXb+es=;
 b=RNFTTMR5+SeChY1LFdzDAU/8Uaf/CLiNGs94RnMiek1fKE+a7yIy7xNt0+SenR8agvkOkJ
 gvOZ0mb6uLpL1AxcbNXrLJd3I2xeDoKyIk4H9korsR4Bppq/1DgCsRd1qdD5jWx0oaqZwDiq
 IFKm2P7TBMroXHGQ59pOn8ayHrpUzvv/7qwEb4w90Ooh1LSBOFZPIHAHm5dX5zQwBLJZpNBZ
 oIWmTXA934+dGQYmqKLBvrS8d8peWKi1q5T85rUyoObig3hwWod9ofjWiERdgB+OHjEJG6XC
 EkD3vkqJVopJr0BLFlbXktB4KbG7WcHCa3X8viWLJ6URaF3pRNpfHqzA==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	xenomai@lists.linux.dev
Subject: [PATCH v2] ci: check the device health
Date: Thu,  4 Sep 2025 11:29:59 +0200
Message-ID: <20250904093014.2037482-1-Quirin.Gylstorff@siemens.com>
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
Changes v2:
 - simplify get_device_state by returning directly
 - correct white space
 - Add documentation for the new WAIT_FOR_DEVICE_TIMEOUT

 scripts/run-lava-tests.sh | 33 +++++++++++++++++++++++++++++++--
 tests/README.md           |  1 +
 2 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/scripts/run-lava-tests.sh b/scripts/run-lava-tests.sh
index 5545dc5..2293872 100755
--- a/scripts/run-lava-tests.sh
+++ b/scripts/run-lava-tests.sh
@@ -24,6 +24,20 @@ get_first_xml_attr_value()
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
+			return 0
+		fi
+	done
+	return 1
+}
+
 # S3 artifacts
 artifact_url="${LAVA_ARTIFACTS_URL:-https://d1a54g2tyy2hl.cloudfront.net/artifacts}"
 # public master
@@ -42,12 +56,27 @@ TEST_TIMEOUT_MINUTES=$((TEST_RUNTIME_SECONDS / 60 + ADDITIONAL_TEST_TIMEOUT_MINU
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
+	if get_device_state "$test_definition"; then
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
diff --git a/tests/README.md b/tests/README.md
index b6421b4..b8288e7 100644
--- a/tests/README.md
+++ b/tests/README.md
@@ -111,6 +111,7 @@ The following variables are used and set by the ci system:
   - `LAVA_ARTIFACTS_URL`: optional variable where to get the artifacts for testing
   - `LAVA_MASTER_URL`: URL to the LAVA Master
   - `CONTAINER_REGISTRY`: Container registry server to pull lavacli base image from. Uses registry.gitlab.com if unset.
+  - `WAIT_FOR_DEVICE_TIMEOUT`: Timeout for device health check. Default is 10 minutes.
 
 - Image deployment settings:
   - `USE_S3_BUCKET`: Set to `1` in order to upload build artifacts to AWS S3
-- 
2.50.1

