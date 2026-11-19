Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795072673;
	b=PyecmUWhpiY0TfubkGuOx6ZkxlaQPuQLOZDda7zZtauHXyWrsAtrtlxTuNO5ctjjNLpK
	 iT4kz0wJT+ObUQknbvE9b1nSSNwa2Upu9jAmvA9or4Bd32rKSpAdCx5weE+GS7v8vWT1G
	 p8zr7mtZhyEFtynKsz6s3a+KsWxef24mG0GVuepjR9DejwB4K6GzycypNPy8ar9hz3q5C
	 ydhR3grGiz52tDF77eo15zHYs/ULqfvTQvtNj3TPn5dDpLrc6AfO148RepmInHGJiTySB
	 K+1LkvabqY/SACHKMGZnlWHlzAvIjO4dTNDul50gOrHZF27A9gHpWHx928/hdN/3xJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795072673;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=TrC+ufZTaHbhC/Np3pDTO6GLHaBQDQ5l/mmo1pMHHuI=;
	b=AyzIa9nkWXH4oc4dBTe9DKiUrq6AgasKXCDAF3UHDoXAA0CopjK3gqoAU3W69sQy7sYG
	 fkOIsCP/grubXdIWJrQtf8wf2mzUIAYDsBAg908rpM2ITrY1G8m2EdxeUykjwhvTp05wV
	 n8fyXgo8E6aVPGFjqbrPfQoXUIosJq6BJgGot7mTphAcvblPVhh2Or+B0yOT4ragAWzth
	 S/qXf5gqhEHoH/mH09xpHCWw6Flhz2HagG1m91RD7VwlwqcrzycKJ5R1r1AZ9wnMKrBoT
	 IDRMFGXUIjjh28ErFLF8otMlvZT75UBwJsrSXzIinCQipSJLUEXh7n+n2YW+NYU4iFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=googlemail.com;
	spf=pass smtp.mailfrom=googlemail.com;
	dkim=pass header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b=skj5xUm7;
	arc=none smtp.remote-ip=209.85.208.47
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C05F606A320
	for <xenomai@lists.linux.dev>; Thu, 19 Nov 2026 07:17:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8C05F606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b=skj5xUm7
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6b87a1a2babso1181963a12.0
        for <xenomai@lists.linux.dev>; Wed, 18 Nov 2026 23:17:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20260707; t=1795072672; x=1795677472; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TrC+ufZTaHbhC/Np3pDTO6GLHaBQDQ5l/mmo1pMHHuI=;
        b=skj5xUm7nUYhXub5V6TBD8fGIZlmWBbwCxdsegr+mvPhvq4vUTc2chXSlnrCFO955Q
         SnXjXW5HRDDhT9IWTpE6EbqQSmXf2JqPH+nSVVqf4Ns+wWHDYP2MZgdiDKOUPveyHjPS
         a0mMo8icIiZxNnuNNE64Tsq0Sczy23jAJKjihKw28IghwjYE6vAFxY1NUmuJqKFLGrWj
         HkPslfD4KbBqKiEfdW0ncJFOn8UzhH3syk7gjgfMElsJNMpZQp1uNmfSFThF/sYBFHth
         ByG0GSnuYPKMTKUtW0fNLtSow2BjVoWIogfjnQtiCe1fF7heK6Lw0951Ea745+DDue0j
         LsZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795072672; x=1795677472;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TrC+ufZTaHbhC/Np3pDTO6GLHaBQDQ5l/mmo1pMHHuI=;
        b=yhJ1XfvCx5l/EnuJmob/m7/bwg5Bd7irIH+dYH6bFWD8JVwfRzcjdMMdlDMyb0GK15
         z9IyrzVK9d2/yvsWEhvgixMq7TSCkHY5Po+lp4zICYqTt9UxlZ00BVZcdAwPKetGPZ/h
         NXznNZf63gSpxQ0rK+/4JUKJ8C1Be0g5bFfqtXLjqk9wIW1UsV833XE3dJubUd+MMpwX
         Ur0XILPzuu9l2lOqojOJ7vc8aS7FJpct8xHDTfeMvxWXcJQguKraY8ozjgZ6C62kga6v
         OVyeeLN1IV+HGaaVyqw50EHE+MDuhfM7nFsJ2dHetkzaDWpWvK5utd++Exn3rIn+c+5V
         sKnA==
X-Gm-Message-State: APuU4Z8KVyIuvpi7tNO+OO8K2wZVnIo9diWVjXqpvrnq57NKtuo+eDZP
	zoXC5aTE30Mue6VfGS8tjbzzeIEEoG+ki+gx5e6Qgvcjlcxxrbrp74vUqQ+POw==
X-Gm-Gg: AYBFou2A/aFTrtZyBkR5fgrlsteVkWzFoP1wa0MWJX3HRRonpQ0SpUJqfhLbdux3Bwx
	fKDa9K0x5hQvSCEjhTuny5gFkr13qYFm5EyLn9vC0rMaRhRqlAL5W8AHQyPl5gAoMUge4SC1usN
	IQ2Xw1CSoXNbgoNzIpYwdUMxwdJIebmY6S6cOLWnDANNHJ3iyRqylnEvlSQjPbkXXwLlacWt1mh
	mOR7vJqnAMNw9bZf0aHJNA78CrKpy0KaLVS6SRHeAYCu0N2y7zovS/xq6cDSkhFhp0S4Pxn9ibh
	fjx6Lu+WGotfVbKj90rc/526MpXE6uiNg3KxV4pkSNCBHz/DLKqMf/Mo99AEAfCZzjtz4pfrvjC
	U6y4amcOVaB+1tg7BHjc7TMeWukNS135tBvk3EZuoQqzY6WCgXAN2cTj6s+FddNkIEv6CeTYBhv
	gxaFRkuDw8UihAKxpLALSMnxQXF2CfdNUyNEzdnLAFnjo6koJXbrrSfF69c4ohzGnhLbxPHgrQ0
	XdBV6j8BCr7kkAUwJfzgRrKtIwufl7St7KbxjKFXPuz4pmbvZbnsJ+SeMEDh5Tez3j9beBVkFzD
	KH2OhYFjVatbUkJ2hoUNfmAkjmz0KckZnT7BSY3uDZ7cx1FFaZ7WDJeTW17T5JB74WGRaYt60+/
	AJcCLQZWRuUrmi5gsqr3W8i3nr1+zvvc=
X-Received: by 2002:a05:6402:3605:b0:6b7:d189:6041 with SMTP id 4fb4d7f45d1cf-6ba1f76a99emr285331a12.2.1795072671858;
        Wed, 18 Nov 2026 23:17:51 -0800 (PST)
Received: from development2.visionsystems.local (mail.visionsystems.de. [213.209.99.202])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b889a3315dsm2061733a12.10.2026.11.18.23.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 23:17:49 -0800 (PST)
From: Yegor Yefremov <yegorslists@googlemail.com>
To: xenomai@lists.linux.dev
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Yegor Yefremov <yegorslists@googlemail.com>
Subject: [PATCH v3 4/5] testsuite/smokey: Include stdbool.h where needed
Date: Thu, 19 Nov 2026 08:17:44 +0100
Message-Id: <20261119071745.2409665-5-yegorslists@googlemail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261119071745.2409665-1-yegorslists@googlemail.com>
References: <20261119071745.2409665-1-yegorslists@googlemail.com>
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Post: <mailto:xenomai@lists.linux.dev>
List-Help: <mailto:xenomai+help@lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
List-Owner: <mailto:xenomai+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Several Alchemy, pSOS and VxWorks tests use bool without including
<stdbool.h>. With the Cobalt core, the header is pulled in indirectly,
and GCC 15 and later default to C23 where bool is a keyword, but
building the Mercury core with an older compiler fails:

  event-1.c:14:8: error: unknown type name 'bool'
  mq-2.c:10:8: error: unknown type name 'bool'
  task-11.c:64:2: error: unknown type name 'bool'
  task-2.c:17:8: error: unknown type name 'bool'

Include <stdbool.h> in the affected tests.

Fixes: e7cfe856c498 ("testsuite: smokey - new testcase alchemy/task-11")
Fixes: eef4a9cd9327 ("testsuite/smokey/alchemytests: Account for race condition inside QEMU")
Fixes: 54e9c5098634 ("testsuite/smokey/alchemytests: Relax mq-2 test over VM")
Fixes: 79df634b5b23 ("testsuite: smokey: Raise some delays in skin tests when running in VM")
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
---
 testsuite/smokey/alchemytests/event-1.c | 1 +
 testsuite/smokey/alchemytests/mq-2.c    | 1 +
 testsuite/smokey/alchemytests/task-11.c | 1 +
 testsuite/smokey/alchemytests/task-2.c  | 1 +
 testsuite/smokey/psostests/task-2.c     | 1 +
 testsuite/smokey/vxworkstests/task-2.c  | 1 +
 6 files changed, 6 insertions(+)

diff --git a/testsuite/smokey/alchemytests/event-1.c b/testsuite/smokey/alchemytests/event-1.c
index d691192ec..9d13c4d7a 100644
--- a/testsuite/smokey/alchemytests/event-1.c
+++ b/testsuite/smokey/alchemytests/event-1.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <stdio.h>
 #include <stdlib.h>
+#include <stdbool.h>
 #include <copperplate/traceobj.h>
 #include <alchemy/task.h>
 #include <alchemy/event.h>
diff --git a/testsuite/smokey/alchemytests/mq-2.c b/testsuite/smokey/alchemytests/mq-2.c
index 09b26b213..f3c3f9ce7 100644
--- a/testsuite/smokey/alchemytests/mq-2.c
+++ b/testsuite/smokey/alchemytests/mq-2.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <stdio.h>
 #include <stdlib.h>
+#include <stdbool.h>
 #include <boilerplate/ancillaries.h>
 #include <copperplate/traceobj.h>
 #include <alchemy/task.h>
diff --git a/testsuite/smokey/alchemytests/task-11.c b/testsuite/smokey/alchemytests/task-11.c
index 6d07e0270..cdf4cd476 100644
--- a/testsuite/smokey/alchemytests/task-11.c
+++ b/testsuite/smokey/alchemytests/task-11.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <stdio.h>
 #include <stdlib.h>
+#include <stdbool.h>
 #include <copperplate/traceobj.h>
 #include <alchemy/task.h>
 
diff --git a/testsuite/smokey/alchemytests/task-2.c b/testsuite/smokey/alchemytests/task-2.c
index b2db20ab3..216a3cd87 100644
--- a/testsuite/smokey/alchemytests/task-2.c
+++ b/testsuite/smokey/alchemytests/task-2.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <stdio.h>
 #include <stdlib.h>
+#include <stdbool.h>
 #include <boilerplate/atomic.h>
 #include <copperplate/traceobj.h>
 #include <alchemy/task.h>
diff --git a/testsuite/smokey/psostests/task-2.c b/testsuite/smokey/psostests/task-2.c
index af0c0ff98..1b8f09f2f 100644
--- a/testsuite/smokey/psostests/task-2.c
+++ b/testsuite/smokey/psostests/task-2.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <stdio.h>
 #include <stdlib.h>
+#include <stdbool.h>
 #include <copperplate/traceobj.h>
 #include <copperplate/threadobj.h>
 #include <psos/psos.h>
diff --git a/testsuite/smokey/vxworkstests/task-2.c b/testsuite/smokey/vxworkstests/task-2.c
index bf2613143..14f4dbac9 100644
--- a/testsuite/smokey/vxworkstests/task-2.c
+++ b/testsuite/smokey/vxworkstests/task-2.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <stdlib.h>
+#include <stdbool.h>
 #include <unistd.h>
 #include <copperplate/threadobj.h>
 #include <copperplate/traceobj.h>
-- 
2.34.1

