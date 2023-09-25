Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A471CAA5
	for <xenomai@lists.linux.dev>; Mon, 25 Sep 2023 15:13:08 +0000 (UTC)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-530fa34ab80so17526333a12.0
        for <xenomai@lists.linux.dev>; Mon, 25 Sep 2023 08:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1695654786; x=1696259586; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mqFetNK06rHCRJ1nh0IndRefOhdLLX/GeF6P1s7wlsE=;
        b=ig9hhI87QuBR06+jl9mYWTxdaAJB+5Fs3zRY3pL3m0GZvb3eTVjyp0amd15PIFeZob
         gEEqFnVqQolbXfmzebX7PybgvRt14fG3lcbrtYC9NBoeFV98tY2vV4zu5iSCsQzIbTiL
         QMNkjpd8G7rIRdTMJ90bpoJhoJ0bljiGoOjtAoDEsIq6yZWGKF9vdVaOeyZJ1yLsHZqX
         UpmVUKjaYFciqt/CsomcNv8+q99dL9YrxMs+iqj3TlVluxtKbh6uHSav7+PJ15xPibW9
         136QFVoGzNj00VuHU4Qrs6wg8Xchr05Xt/ohwP+LfOlNDZekdFuv9CHmM8DofhK4lGo5
         tonA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695654786; x=1696259586;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mqFetNK06rHCRJ1nh0IndRefOhdLLX/GeF6P1s7wlsE=;
        b=q5+V6l3wpl8tIwa8UHrd53XUEglsOudPUowkLVenF9jQE/796j+oWhze4Do5sbxO91
         2vObv0IzdUdTOs7K3+5GEoCbbFTkX/W+uzlWE6kQFw8G5EX3AI0RkSrVc3O0VtEzi13P
         4bDTL7f+smYP70I84+8h++3Wa15Pf5WgSXgbdpCDEPvPnjr4oZnqiASvkPk1f7VOujZI
         HdLYSZnjB6e3uzHzJ/1FKx2xwhkMd/JM/mm6iOGcZ0DaiBIjsAzkxmxKKrtzST1PFg4C
         abyqQJ63KkHQd9axRWLS8UmNodHb2Ppq3qAvob7dZRk7ZdCsO1MQBR9OE47OPXNtmG7C
         jDxw==
X-Gm-Message-State: AOJu0YyGbYVRx1qHJ64rW2Wfw6tLYZshCqaDvxB6j5KiNTz1tPibwCvU
	4qZpih+3gGup/wKoRWE4lpdA2OjlvjAT5IO6ZOQ=
X-Google-Smtp-Source: AGHT+IF2vBu/V4azPS9YDamN1OmN+FdA7OwBM+qB0bNBSqe3xYWI8sI/AzHJnylTsYZck2SjpRocUA==
X-Received: by 2002:a17:907:7288:b0:9ae:50ec:bd81 with SMTP id dt8-20020a170907728800b009ae50ecbd81mr15701542ejc.21.1695654786209;
        Mon, 25 Sep 2023 08:13:06 -0700 (PDT)
Received: from foxxylove.corp.sigma-star.at ([82.150.214.1])
        by smtp.gmail.com with ESMTPSA id t15-20020a170906608f00b009a9fbeb15f2sm6430007ejj.62.2023.09.25.08.13.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 08:13:05 -0700 (PDT)
From: Aaron Marcher <aaron@sigma-star.at>
To: xenomai@lists.linux.dev
Cc: richard@nod.at,
	jan.kiszka@siemens.com,
	Aaron Marcher <aaron@sigma-star.at>
Subject: [PATCH 1/1] lib: Drop cpu-affinity=0 from skin-tests helper
Date: Mon, 25 Sep 2023 17:12:56 +0200
Message-Id: <20230925151256.22161-2-aaron@sigma-star.at>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230925151256.22161-1-aaron@sigma-star.at>
References: <20230925130311.17757-1-aaron@sigma-star.at>
 <20230925151256.22161-1-aaron@sigma-star.at>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Alchemy, pSos and VxWorks tests assume zero CPU affinity, but we cannot
enforce that in general.

Introduces a parameter to control the arguments.

Signed-off-by: Aaron Marcher <aaron@sigma-star.at>
---
 include/smokey/smokey.h                      | 2 +-
 lib/smokey/helpers.c                         | 8 ++++++--
 testsuite/smokey/alchemytests/alchemytests.c | 3 ++-
 testsuite/smokey/psostests/psostests.c       | 3 ++-
 testsuite/smokey/vxworkstests/vxworkstests.c | 3 ++-
 5 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/include/smokey/smokey.h b/include/smokey/smokey.h
index 4d0fe011f..3623ba18c 100644
--- a/include/smokey/smokey.h
+++ b/include/smokey/smokey.h
@@ -259,7 +259,7 @@ int smokey_modprobe(const char *name, bool silent);
 
 int smokey_rmmod(const char *name);
 
-int smokey_run_extprog(const char *dir, const char *name, int argc, char *const argv[]);
+int smokey_run_extprog(const char *dir, const char *name, const char *args);
 
 #ifdef __cplusplus
 }
diff --git a/lib/smokey/helpers.c b/lib/smokey/helpers.c
index dfd63b409..99cd019aa 100644
--- a/lib/smokey/helpers.c
+++ b/lib/smokey/helpers.c
@@ -411,12 +411,16 @@ int smokey_rmmod(const char *name)
 	return err;
 }
 
-int smokey_run_extprog(const char *dir, const char *name, int argc, char *const argv[])
+int smokey_run_extprog(const char *dir, const char *name, const char *args)
 {
 	int ret;
 	char *tst_path;
 
-	ret = asprintf(&tst_path, "%s/%s --cpu-affinity=0", dir, name);
+	if (args == NULL)
+		ret = asprintf(&tst_path, "%s/%s", dir, name);
+	else
+		ret = asprintf(&tst_path, "%s/%s %s", dir, name, args);
+
 	if (ret == -1)
 		return -ENOMEM;
 
diff --git a/testsuite/smokey/alchemytests/alchemytests.c b/testsuite/smokey/alchemytests/alchemytests.c
index 5753af423..04f631bac 100644
--- a/testsuite/smokey/alchemytests/alchemytests.c
+++ b/testsuite/smokey/alchemytests/alchemytests.c
@@ -33,12 +33,13 @@ static int run_alchemytests(struct smokey_test *t, int argc, char *const argv[])
 		"alchemytests_task9",
 		"alchemytests_task10"
 	};
+	char *args = "--cpu-affinity=0";
 
 	for (size_t t = 0; t < sizeof(tests) / sizeof(tests[0]); t++)
 	{
 		int fails = 0;
 
-		ret = smokey_run_extprog(XENO_TEST_DIR, tests[t], argc, argv);
+		ret = smokey_run_extprog(XENO_TEST_DIR, tests[t], args);
 		if (ret) {
 			fails++;
 			if (smokey_keep_going)
diff --git a/testsuite/smokey/psostests/psostests.c b/testsuite/smokey/psostests/psostests.c
index a54e6ea31..f2a75c841 100644
--- a/testsuite/smokey/psostests/psostests.c
+++ b/testsuite/smokey/psostests/psostests.c
@@ -46,12 +46,13 @@ static int run_psostests(struct smokey_test *t, int argc, char *const argv[])
 		"psostests_tm6",
 		"psostests_tm7"
 	};
+	char *args = "--cpu-affinity=0";
 
 	for (size_t t = 0; t < sizeof(tests) / sizeof(tests[0]); t++)
 	{
 		int fails = 0;
 
-		ret = smokey_run_extprog(XENO_TEST_DIR, tests[t], argc, argv);
+		ret = smokey_run_extprog(XENO_TEST_DIR, tests[t], args);
 		if (ret) {
 			fails++;
 			if (smokey_keep_going)
diff --git a/testsuite/smokey/vxworkstests/vxworkstests.c b/testsuite/smokey/vxworkstests/vxworkstests.c
index d3ac891ae..24ea8f0a1 100644
--- a/testsuite/smokey/vxworkstests/vxworkstests.c
+++ b/testsuite/smokey/vxworkstests/vxworkstests.c
@@ -24,12 +24,13 @@ static int run_vxworkstests(struct smokey_test *t, int argc, char *const argv[])
 		"vxworkstests_task1",
 		"vxworkstests_task2"
 	};
+	char *args = "--cpu-affinity=0";
 
 	for (size_t t = 0; t < sizeof(tests) / sizeof(tests[0]); t++)
 	{
 		int fails = 0;
 
-		ret = smokey_run_extprog(XENO_TEST_DIR, tests[t], argc, argv);
+		ret = smokey_run_extprog(XENO_TEST_DIR, tests[t], args);
 		if (ret) {
 			fails++;
 			if (smokey_keep_going)
-- 
2.35.3

