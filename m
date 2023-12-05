Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C965D901
	for <xenomai@lists.linux.dev>; Tue,  5 Dec 2023 12:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="WtCheepW"
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20231205124141487cba0be2c9d406a7
        for <xenomai@lists.linux.dev>;
        Tue, 05 Dec 2023 13:41:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=yj0P8mcWBIxpon9QVnJfZR7OBhiSdJQfUMIlPUMImsE=;
 b=WtCheepWMsOAQnKinUJpVfUdQTpeEXZBdstHJz8AAUxgbMQYDB93VxbTpO0WY0owp8/snk
 dXyZrbiJbto9/crpJYbREMPT3WKjKRxd7EekVHpkTjH1lUsoP2FytP0hHd0XZ5l08R7uHm9n
 VSd54sGdxUtAuRGN2t2bQRQwurgsA=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Tue, 05 Dec 2023 13:41:40 +0100
Subject: [PATCH 03/13] lib: Migrate to ARRAY_SIZE()
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231201-flo-array-size-v1-3-3e0abd7c68fa@siemens.com>
References: <20231201-flo-array-size-v1-0-3e0abd7c68fa@siemens.com>
In-Reply-To: <20231201-flo-array-size-v1-0-3e0abd7c68fa@siemens.com>
To: jan.kiszka@siemens.com, xenomai@lists.linux.dev
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Use ARRAY_SIZE() where possible. No functional change.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 lib/boilerplate/ancillaries.c | 4 ++--
 lib/boilerplate/setup.c       | 2 +-
 lib/cobalt/mutex.c            | 2 +-
 lib/cobalt/sigshadow.c        | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/lib/boilerplate/ancillaries.c b/lib/boilerplate/ancillaries.c
index a0754cb48..457ef0b7c 100644
--- a/lib/boilerplate/ancillaries.c
+++ b/lib/boilerplate/ancillaries.c
@@ -182,7 +182,7 @@ static const char *__esym_map[] = {
 	__esym_def(EPROTO),
 };
 
-#define __esym_max  (sizeof(__esym_map) / sizeof(__esym_map[0]))
+#define __esym_max	ARRAY_SIZE(__esym_map)
 
 const char *symerror(int errnum)
 {
@@ -472,7 +472,7 @@ char *lookup_command(const char *cmd)
 	char *path;
 	int n, ret;
 
-	for (n = 0; n < sizeof(dirs) / sizeof(dirs[0]); n++) {
+	for (n = 0; n < ARRAY_SIZE(dirs); n++) {
 		ret = asprintf(&path, "%s/%s", dirs[n], cmd);
 		if (ret < 0)
 			return NULL;
diff --git a/lib/boilerplate/setup.c b/lib/boilerplate/setup.c
index 5139560e8..a9138e96b 100644
--- a/lib/boilerplate/setup.c
+++ b/lib/boilerplate/setup.c
@@ -304,7 +304,7 @@ static struct option *build_option_array(int *base_opt_startp)
 	const struct option *p;
 	int nopts;
 
-	nopts = sizeof(base_options) / sizeof(base_options[0]);
+	nopts = ARRAY_SIZE(base_options);
 
 	if (!pvlist_empty(&setup_list)) {
 		pvlist_for_each_entry(setup, &setup_list, __reserved.next) {
diff --git a/lib/cobalt/mutex.c b/lib/cobalt/mutex.c
index 54f6b8461..c77d10684 100644
--- a/lib/cobalt/mutex.c
+++ b/lib/cobalt/mutex.c
@@ -196,7 +196,7 @@ static int __attribute__((cold))
 	};
 	int i;
 
-	for (i = sizeof(mutex_types) / sizeof(mutex_types[0]); i > 0; --i) {
+	for (i = ARRAY_SIZE(mutex_types); i > 0; --i) {
 		if (memcmp(mutex, &mutex_initializers[i - 1],
 				sizeof(mutex_initializers[0])) == 0)
 			return mutex_types[i - 1];
diff --git a/lib/cobalt/sigshadow.c b/lib/cobalt/sigshadow.c
index b03703526..092cadb08 100644
--- a/lib/cobalt/sigshadow.c
+++ b/lib/cobalt/sigshadow.c
@@ -53,7 +53,7 @@ int cobalt_sigshadow_handler(int sig, siginfo_t *si, void *ctxt)
 		break;
 	case SIGSHADOW_ACTION_BACKTRACE:
 		arg = sigshadow_arg(si->si_int);
-		nr = backtrace(frames, sizeof(frames) / sizeof(frames[0]));
+		nr = backtrace(frames, ARRAY_SIZE(frames));
 		/* Skip the sighandler context. */
 		skip = nr > 3 ? 3 : 0;
 		XENOMAI_SYSCALL3(sc_cobalt_backtrace, nr - skip, frames + skip, arg);

-- 
2.39.2

