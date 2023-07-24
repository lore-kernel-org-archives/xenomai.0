Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596A2AD2A
	for <xenomai@lists.linux.dev>; Mon, 24 Jul 2023 13:52:58 +0000 (UTC)
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-4fb761efa7aso6655900e87.0
        for <xenomai@lists.linux.dev>; Mon, 24 Jul 2023 06:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1690206776; x=1690811576;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X1cQOc964HWxVz5/SRWF8kLGcrk3hDq1vbOJf8B2Nkc=;
        b=tJ4QrlVT7RpNRcViLU2vJyh4xz8h5WBWrdsP8SmtwqMeofNmyyxJ8+TDsaw5Nmm5mA
         r8YaMd8fWU6vBX8IYppUGCkjFTY//IdqC7Uy7xjgTFDimeuKR+x0ICRcWCy/YOHxKSC7
         3L5srd8gZHaAtPCS4L8KYM0LBPWm6i1wi5r3iDxIjDwpVgLK18xxQrRGt3EuHes+UaI1
         K96nhkmC2n5Q9O+YPIrQa6W0USLJASiKzwE9GWTL/i92GuZoOSmJCj0lsDGXBKIEg4CC
         C+vZLNGpKbxYOgeRBjIXWcwdv6sp/pRBsZLh2udw/tR/Ivr8JCVFW4l5nrT61P7ON1y1
         ynCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690206776; x=1690811576;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X1cQOc964HWxVz5/SRWF8kLGcrk3hDq1vbOJf8B2Nkc=;
        b=Sa7vd0eYMIabFwCfXxCJvXJu9UWgpRdKSlsaDEtR0X4vqdfX2851PAWXcWUsVVsKB5
         t6GNlTH24mdw+FM4W6FmFH7o0S5Sj0679KSFSUSOrAcEyIjQl+da3juquvS+JgMD9sZN
         RBhUMpht4Zq6XOdBuvKGghcwn270b9vMdBg40MiOBGLDmmg6D+w8xSeaPOMzqhNoHZlh
         MvZC8sT9X6BqFl+DvLUyUPc1T9IGCcPD1oKVQtEdQXfeRo2H2EgvXRPJ/rR1y6Xphf3V
         PjR1hI64vdGovAOruDEXtq8Tf3dfVoVdupksqoZml2kmzk6WKCSCUc5WExnd2OvkLMdP
         nkew==
X-Gm-Message-State: ABy/qLbIfWtdPH7c5kKqmZGFIACgvijqSgk+PGXHHe69U7R8sptPPx1V
	zA+zpf6Z7aoeoS7B9em8R4vumLGQQECy/QiVJY8=
X-Google-Smtp-Source: APBJJlEpLf1/5iWk0Sz6xziTRw5IQHVW8y95WOAZaqLpOsv+FyRwePDSd9hUGjpNozzooPg0ZmaKyg==
X-Received: by 2002:a19:e05c:0:b0:4fb:741f:75bf with SMTP id g28-20020a19e05c000000b004fb741f75bfmr4894847lfj.16.1690206776154;
        Mon, 24 Jul 2023 06:52:56 -0700 (PDT)
Received: from foxxylove.corp.sigma-star.at ([82.150.214.1])
        by smtp.gmail.com with ESMTPSA id v2-20020aa7cd42000000b0051bed498851sm6239100edw.54.2023.07.24.06.52.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 06:52:55 -0700 (PDT)
From: Aaron Marcher <aaron@sigma-star.at>
To: xenomai@lists.linux.dev
Cc: richard@nod.at,
	jan.kiszka@siemens.com,
	Aaron Marcher <aaron@sigma-star.at>
Subject: [PATCH 04/10] testsuite: Remove old alchemytests Makefile
Date: Mon, 24 Jul 2023 15:52:33 +0200
Message-Id: <20230724135239.10579-5-aaron@sigma-star.at>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230724135239.10579-1-aaron@sigma-star.at>
References: <20230720145150.24607-1-aaron@sigma-star.at>
 <20230724135239.10579-1-aaron@sigma-star.at>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Richard Weinberger <richard@nod.at>

Signed-off-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Aaron Marcher <aaron@sigma-star.at>
---
 lib/alchemy/testsuite/Makefile | 70 ----------------------------------
 1 file changed, 70 deletions(-)
 delete mode 100644 lib/alchemy/testsuite/Makefile

diff --git a/lib/alchemy/testsuite/Makefile b/lib/alchemy/testsuite/Makefile
deleted file mode 100644
index a831c999e..000000000
--- a/lib/alchemy/testsuite/Makefile
+++ /dev/null
@@ -1,70 +0,0 @@
-ifeq ($(DESTDIR),)
-XENO_CONFIG=xeno-config
-else
-XENO_CONFIG=$(DESTDIR)/bin/xeno-config
-endif
-
-prefix := $(shell DESTDIR=$(DESTDIR) $(XENO_CONFIG) --prefix)
-solibs := $(shell DESTDIR=$(DESTDIR) $(XENO_CONFIG) --libdir)
-core := $(shell DESTDIR=$(DESTDIR) $(XENO_CONFIG) --core)
-
-ifeq ($(prefix),)
-$(error Please add <xenomai-install-path>/bin to your PATH variable or specify DESTDIR)
-endif
-
-cobalt-only := pipe-1
-mercury-only :=
-core-specific = $($(core)-only)
-
-TESTS :=		\
-	task-1		\
-	task-2		\
-	task-3		\
-	task-4		\
-	task-5		\
-	task-6		\
-	task-7		\
-	task-8		\
-	task-9		\
-	task-10		\
-	mq-1		\
-	mq-2		\
-	mq-3		\
-	alarm-1		\
-	sem-1		\
-	sem-2		\
-	mutex-1		\
-	event-1		\
-	heap-1		\
-	heap-2		\
-	buffer-1	\
-	$(core-specific)
-
-CFLAGS := $(shell DESTDIR=$(DESTDIR) $(XENO_CONFIG) --skin=alchemy --cflags) -g
-LDFLAGS := $(shell DESTDIR=$(DESTDIR) $(XENO_CONFIG) --skin=alchemy --ldflags)
-CC = $(shell DESTDIR=$(DESTDIR) $(XENO_CONFIG) --cc)
-
-all: $(TESTS)
-
-%: %.c
-	$(CC) -o $@ $< $(CFLAGS) $(LDFLAGS)
-
-install: all
-	install -d $(prefix)/testsuite/alchemy
-	install -t $(prefix)/testsuite/alchemy $(TESTS)
-
-clean:
-	$(RM) $(TESTS) *~
-
-# Run the test suite. We pin all tests to CPU #0, so that SMP does not
-# alter the execution sequence we expect from them.
-test: all
-	@for t in $(TESTS); do \
-		echo -n $$t...; \
-		sudo LD_LIBRARY_PATH=$(solibs) $(VALGRIND) ./$$t --cpu-affinity=0 --silent && echo ok || echo BAD; \
-	done
-
-test/%: %
-	sudo LD_LIBRARY_PATH=$(solibs) $(VALGRIND) ./$(@F) --cpu-affinity=0 --silent && echo ok || echo BAD
-
-.PHONY: clean test
-- 
2.35.3

