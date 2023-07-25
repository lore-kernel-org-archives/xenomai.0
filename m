Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA48514AAA
	for <xenomai@lists.linux.dev>; Tue, 25 Jul 2023 08:30:07 +0000 (UTC)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-9939fbb7191so1106494566b.0
        for <xenomai@lists.linux.dev>; Tue, 25 Jul 2023 01:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1690273806; x=1690878606;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X1cQOc964HWxVz5/SRWF8kLGcrk3hDq1vbOJf8B2Nkc=;
        b=nxRE4LFd5Bt0tvOTpd3X/lt+9Po2K35IsV9GfU1ZtUcMuw5Yq3uiknlYcwCheXHkOd
         akEeLRrjlDwZ07pklFAJNELUfTbtMjdMQaluZFxvFPeVR6OLdeHq0XsFmbOuHmCRvE55
         yG8K3+F7SddsjQy4s1XH22DKpJXWCpyZrVzL3Z3dL6MovF0+dTTYYm6UyyJ0mulLQq/A
         iaK8Iz4RBp2TV4RjjVYHP3f9hJHffXW9wtWzj091yd86JNxvbVidvozQED07/HRMgDNu
         su0N9yMDUpjhYJj8HWlihsUgT79mbuTmxxuREq7yhB8SE2XWRD0biThEv1ST8ynAt6qr
         QnCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690273806; x=1690878606;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X1cQOc964HWxVz5/SRWF8kLGcrk3hDq1vbOJf8B2Nkc=;
        b=h3zz57aXcVcbcTZH5Bwk0YA/nrjC9QIXFSupm4/0+i2HNU6WIBg0O6mZu9jSIMfY/E
         m3fiO7u7YPscHVhYyuOj/Tn8jkgHzpfVs7+n1Vea0+RHq2m18+Psn2kMGLeziwaxft0A
         eQ56C4yUTv+J/mxEeXQNAVdPAuTh5/Con1qN88H+BEZmeVH4iz6kOC8zvn9i627cd5tA
         izIIiVXXkve3TK6MqxIKi1qAiD7J01Kho/1WjrXej+JzTXqZ6VTKkMLXCo3qsl+lEjRS
         aec2mGkP4Jom0C85p0wm+kFcrsBs/0OctkSouJjfL4F//cx+7tigFuopyos5PTxsF+cT
         EW/Q==
X-Gm-Message-State: ABy/qLacvz2ufEfe0tc/7noQj+yVBDqGbBAgzYl4UM/tfCIGGUWFCz5d
	7TuDmZR+BDhvFDr2/PmaaEd8AZRznHRgT66LQi8=
X-Google-Smtp-Source: APBJJlHlU4gzhV9AvWD+/CgTSLNn0w4CdazgeAqyzhb8Y9u3h4o/1bOV2uiMIQngYHuRpoYLmVZxyA==
X-Received: by 2002:a17:907:3f98:b0:966:1bf2:2af5 with SMTP id hr24-20020a1709073f9800b009661bf22af5mr1868915ejc.22.1690273805926;
        Tue, 25 Jul 2023 01:30:05 -0700 (PDT)
Received: from foxxylove.corp.sigma-star.at ([82.150.214.1])
        by smtp.gmail.com with ESMTPSA id l2-20020a170906230200b00997e52cb30bsm7752080eja.121.2023.07.25.01.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 01:30:05 -0700 (PDT)
From: Aaron Marcher <aaron@sigma-star.at>
To: xenomai@lists.linux.dev
Cc: richard@nod.at,
	jan.kiszka@siemens.com,
	Aaron Marcher <aaron@sigma-star.at>
Subject: [PATCH 04/10] testsuite: Remove old alchemytests Makefile
Date: Tue, 25 Jul 2023 10:29:53 +0200
Message-Id: <20230725082959.5144-5-aaron@sigma-star.at>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230725082959.5144-1-aaron@sigma-star.at>
References: <1753829974.221010.1690209596711.JavaMail.zimbra@nod.at>
 <20230725082959.5144-1-aaron@sigma-star.at>
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

