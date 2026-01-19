Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C69630E0F8
	for <xenomai@lists.linux.dev>; Mon, 19 Jan 2026 10:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768819466; cv=none; b=PS9DhalGysyKwpD8XrP63p7ePngvP+z/Skp2i0/KnKBoto0rdp/lF1h+3QSutm56cbGRZy2Gpaqo9f97UHShcKOZjmM+aWBB3i66CVkQAYNSqlgKrvcc8YJerlJ3jzQh5tyFDuRbcr4ZN4/uIbE+JcL6VzgskFdoOMDcu7XB7TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768819466; c=relaxed/simple;
	bh=Ux3Qod6MlsX5+UDdgS3sIT1l8u4my5/jItlOIaFic4Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SJ4h7XvxPO0RCo/Z+Nh4wD8X1q4CgZ2ljRtDDXdjIxza53h7u8lMWcHk4Rg/dLUgn2NkL3UYSNrUZ1JtqxFOV+bEwO3lUbD5aX0QWNBt+jcVoNhzK5xxMvi1gPzCQ94lfxrb8Vkv8s9cDsBKK6uQa9fCKT4mJyPRuyePmgICxPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=Qtg7+5OS; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="Qtg7+5OS"
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20260119103409a96417731400020756
        for <xenomai@lists.linux.dev>;
        Mon, 19 Jan 2026 11:34:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=9QsKAg7QvNNdHpzU1Rx2o7y/JB+mwz2yxhgbnKil8UM=;
 b=Qtg7+5OS0CYFVqMc7/Q0fXo+N4uaTQhF1E6bEQw1F+520JeiqmNXOAg5I1oUovkF8YLD7j
 EK+KQ5ySY2W6v/UlTNw1bayCNIoa6f7KLEY4lcQcgsp4aSOi3QkpVKOGeIUPG2Q2LN2RbK9J
 a584aHRWtITxGH3hrnEITjHVVnv+onrn6mBFIiqIVq+y/MG3wPo5KDsKgcMVOWxYI2/JuAqD
 EbbzbE0VEnHT9UhzCFGfYL+m0Tl2PNjaRz/nQuhmBELTtK04AqYG2j9SCshPX/Yjld7wodCH
 x0h+Fu5hWfszrEINh3n9SAS6uONs0woXNQrxWePXn7EAdKyLDddvstOQ==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Mon, 19 Jan 2026 11:34:05 +0100
Subject: [PATCH 2/3] testsuite/smokey/gdb: Improve error reporting from gdb
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251006-wip-flo-test-improvements-v1-2-b70e8726ec0b@siemens.com>
References: <20251006-wip-flo-test-improvements-v1-0-b70e8726ec0b@siemens.com>
In-Reply-To: <20251006-wip-flo-test-improvements-v1-0-b70e8726ec0b@siemens.com>
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

In case there was an error / unexpected output on stdout in the
communication with gdb the printed error message (see below) was not
that useful:

FAILURE run_gdb:302: checking expression "primary_mode", expected
"$", found "N"

In case of an error we now read up to 64 additional characters from
gdb. That should be enough to get more information about the actual
problem. Example:

FAILURE run_gdb:323: checking expression "primary_mode", expected
"$", found "N", remaining "o symbol table is loaded.  Use the "file" command"

The buffer for the additional output is marked as static, so no
additional "stack traffic" in the error case.

The problem at hand was a local tooling problem. I was running an
arm64 smokey inside a compat environment. A compat gdb is not able to
parse the native symbol table.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 testsuite/smokey/gdb/gdb.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/testsuite/smokey/gdb/gdb.c b/testsuite/smokey/gdb/gdb.c
index 241fc614a..d5b4e9383 100644
--- a/testsuite/smokey/gdb/gdb.c
+++ b/testsuite/smokey/gdb/gdb.c
@@ -1,7 +1,7 @@
 /*
  * gdb test.
  *
- * Copyright (C) Siemens AG, 2015-2019
+ * Copyright (C) Siemens AG, 2015-2026
  *
  * Authors.
  *  Jan Kiszka <jan.kiszka@siemens.com>
@@ -107,6 +107,20 @@ static void send_command(const char *string, int wait_for_prompt)
 		wait_for_pattern("(gdb) ");
 }
 
+static char *read_remaining_output(void)
+{
+	static char buf[64];
+	ssize_t ret;
+
+	ret = read(pipe_out[0], buf, sizeof(buf));
+	if (ret <= 0)
+		return NULL;
+
+	buf[ret - 1] = 0;
+
+	return buf;
+}
+
 static void check_output(const char *fn, int line, const char *expression,
 			 const char *pattern)
 {
@@ -118,9 +132,11 @@ static void check_output(const char *fn, int line, const char *expression,
 		if (*match != read_string[pos]) {
 			rt_print_flush_buffers();
 			read_string[pos + 1] = 0;
-			fprintf(stderr, "FAILURE %s:%d: checking expression "
-				"\"%s\", expected \"%s\", found \"%s\"\n",
-				fn, line, expression, pattern, read_string);
+			fprintf(stderr,
+				"FAILURE %s:%d: checking expression "
+				"\"%s\", expected \"%s\", found \"%s\", remaining \"%s\"\n",
+				fn, line, expression, pattern, read_string,
+				read_remaining_output());
 			send_command("q\n", 0);
 			exit(EXIT_FAILURE);
 		}

-- 
2.39.5

