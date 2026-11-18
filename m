Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795002552;
	b=cWHYQfJ/BZWB93iAyoQqFFqceYlfb+9PjQCmi2kx/U5d+sWwbusCCiBBVU8x5qp163JV
	 Oj3SrHKEWkYwp6xW34TYNuw8niFVLWkLERWLJtr41JPXXAtRxHFyvzfr/NmxIwuL4UGcn
	 74AoGgJYvpTGj8oMXPFpH8YkLZxU3sDqX/v1EC9quwezRG651S5v47mIyoJcFKySa+ZlF
	 oPYZ9QD6pjdH8PTXkEdioU3WGzcF/ZeXVK3UFLGXedd4Nx7ZR9bbziU7nTBa4gjndqPtJ
	 RxatHX+ZK6+imHO2nKWNyFJQcj+YupaVjSzT+LIDImbxOfJCA+lFDzRNEe9oOR2jLEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795002552;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=ivDszq9Th4VB9AO2LhlOF7aFsxEgbTJwDmdx3TYx4+0=;
	b=wUm6PsF8ykf2oJH0F/aA/g9nKhxvXcWaXEw5Nc459XNzcLKt9S5U8NxH0e1EJxcjSU5W
	 LSXc8peQoKI7741X5IgQl434miBRa+WU8I6mWxXVZKa/qDB77/f9tbFLXe/6pe9RVgFSU
	 PN0N0dKYtmFlBDWt96gOtoJIWxblN5uFoPTqDEPM+WOjQ22WP6yoKyc2kZNEH8u3d/dlg
	 Atsi6kJlX9Ho2t5QnjeGKB02wq3C3i7NaLSanT7n/SzNCY4MQeFUboyAKnp63FmpD3bXP
	 aa2mgpyVTt3QXALrzTb+uxraAlxinPJPvhKBL7k2wpoM35hvYGAX0tV6eZyhp36g7ag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=googlemail.com;
	spf=pass smtp.mailfrom=googlemail.com;
	dkim=pass header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b=NfZMKbXr;
	arc=none smtp.remote-ip=209.85.208.42
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00AEE606A31C
	for <xenomai@lists.linux.dev>; Wed, 18 Nov 2026 11:49:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 00AEE606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b=NfZMKbXr
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6b88bc47e23so993585a12.2
        for <xenomai@lists.linux.dev>; Wed, 18 Nov 2026 03:49:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20260707; t=1795002550; x=1795607350; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ivDszq9Th4VB9AO2LhlOF7aFsxEgbTJwDmdx3TYx4+0=;
        b=NfZMKbXr7yYz+SmdRDtGIV1IX092HfmCsrFx/6t7ennlh5dF+tIvsKedjgHvU0XwMc
         rUlGlWCRqcdngwMVNWDz6Lkhnape2XIeJAMMAQKLu5WWEO7lGuqfR8ZIcGB+ahRWOcrk
         X9Bx97PJXbcFZjS7DlAwZc3bt82NJL3POQSOVAWVgRpX0SGWYjgu5s4w6oVSQs27sWCF
         xRhPNUva7rqmD+JuUCI90BFVsgd/NbPBca42ASt4RAPVk0XkNz3Ksj7u64YCiXx3Py2a
         hm4kg1BoaMb7FvXvwcDvusvWy7LjUOsBzHVHRWqaxSWrDkcTfYa+DgrWXxRp11Haz+dh
         pIpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795002550; x=1795607350;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ivDszq9Th4VB9AO2LhlOF7aFsxEgbTJwDmdx3TYx4+0=;
        b=Mbz1SoMLlyeg37JPr2Ah4jCVUpe9JwrILDCrjnwrqrkIfPDAvx/+rgYnhOQOchSU8I
         TIX8dYnNbSn/usDLnPgcudXOdyD0BCxUCGd3wNJMMaWd0CrQTjHKZUD9wHhR1b97skbo
         maHyZOyxdyhH0X5AOXTQ90yyEOch+j+VgbEXXb4KSukwH6n2Uo9E8V5+z2m6aO+DCzQh
         q1uVuGV2Xpk8FMG+5T/1Slvs7nTqXS3DXoUKeCSzjCs8C+o4VpgIUujzl6cLcwb3+E5e
         k8ZTgi2EC9FSZv3yWkBpNsDG8r+nmNWRzXFMWWVdsrOw2SFuyK7nnKS2Ex9c4O6YxN3q
         HHlg==
X-Gm-Message-State: APuU4Z9ZJguVcMYWWpeYkwLi4Chylcc3K3Za5RmkzxTq3hUfOxJTsyOx
	rknYV+fsAtwWQuzAKhHlwWps3W6+1SokhLsBbXkbBnCi4bXZDZ7fZsowT8etMQ==
X-Gm-Gg: AYBFou0epFd4Sk5ONS0hc14oKptK0ICGxcWs87ad0aTRbmJDURi3Eabe45NJhUW8sXp
	84jfOw7t/xJYWbgi9NMCiMXFtynRlUAG5bMUO/2Fj2UBVhTPWojMaCBh0j3Xx0zwIfdcaW3CkSX
	smjwekKtxyaN7wv6+3HCIpt/FXvAg0AJij/QRNC6BPdDP/m8wYlJaEjtvkxcWV9D8PkNTOrHoAK
	woSBip2ipJV+edN6D8DcQPUQb17MmxhOMfMSg8hp6uaCC7N852ZaUC98uQWGqMp/nG19qelrHbB
	wiAAon3SFp/uK6HgAltxsdJww5ypCwUGX+swr8rJTFHf+2yJ/yMn4BMwVjkUczHuz+gv5gHPDck
	wQheqDdQwdn/oM8Kw7S276qnOUBbPLato1eb6rFw2HgoVuCB54Yu/Brby5gNevdComqwBmnazzs
	l5B+JdhuDyooIr9e+QKuAln5u36dXjb6oiMdTSOxt/ceY5SRt2XBPKCKQ8UXUAyofAcn8WRX4Yr
	Q2cwv0q6rqmXc/GyqJalfCynDzmoy2q35JGMPAKNxMbtii08EaRQE2LtDzUNWn1bidItueOwW1d
	rN4NDuKT+6+1oWfC4LeO6Uc+BvmjPJAUjxBbOvBEu9aW1KeMpFSx5g6eyBf73FOAB/PUDEbU+O/
	NRctwSf1nS7Ioy/fG5SAvdhAQQSKvPg==
X-Received: by 2002:a05:6402:2707:b0:6b6:f22a:8de9 with SMTP id 4fb4d7f45d1cf-6b887f1e952mr1609547a12.40.1795002549799;
        Wed, 18 Nov 2026 03:49:09 -0800 (PST)
Received: from development2.visionsystems.local (mail.visionsystems.de. [213.209.99.202])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b888ef94a5sm917931a12.4.2026.11.18.03.49.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 03:49:09 -0800 (PST)
From: Yegor Yefremov <yegorslists@googlemail.com>
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>,
	Florian Bezdeka <florian.bezdeka@siemens.com>,
	Yegor Yefremov <yegorslists@googlemail.com>
Subject: [PATCH 0/5] Build fixes for Mercury, GCC 16 and glibc 2.43
Date: Wed, 18 Nov 2026 12:49:04 +0100
Message-Id: <20261118114909.3030884-1-yegorslists@googlemail.com>
X-Mailer: git-send-email 2.34.1
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

While bumping Xenomai to 3.3.3 in Buildroot, I hit several build
failures. Xenomai forces -Werror for userspace code, so new compiler
and libc warnings turn into errors:

- The Mercury core no longer builds at all since the include cleanups
  in 41de7cc7196f and 7b7ddf4a3658: mmap()/MAP_* and __NR_tkill are
  undeclared. This affects every Mercury build of v3.3.x.
- GCC 16 warns about variables that are only ever incremented
  (-Wunused-but-set-variable), in autotune and in the smokey tests.
- glibc 2.43 makes strstr() return a const pointer for a const
  argument (C23), which breaks sched-tp.
- The alchemy tests miss a couple of includes.

All patches apply to stable/v3.3.x as well, and would be good to have
there, especially the first one.

Tested by building v3.3.3 plus this series with Buildroot: Mercury
for arm and aarch64 (glibc and uClibc), and Cobalt with the testsuite
and the Alchemy, pSOS and VxWorks skins for aarch64, i686 (GCC 15)
and x86_64 (GCC 16).

Some testsuite issues remain on Mercury that this series doesn't
address, e.g. the alchemy pipe test calling the Cobalt-only
rt_pipe_read() and task-11.c missing <stdbool.h>.

Yegor Yefremov (5):
  lib: Restore includes needed by the Mercury core
  utils/autotune: Drop unused sample counter
  testsuite/smokey/sched-tp: Fix build with C23 strstr()
  testsuite/smokey/alchemytests: Add missing includes
  testsuite/smokey: Fix unused variable warnings with GCC 16

 lib/boilerplate/setup.c                      | 1 +
 lib/copperplate/internal.c                   | 1 +
 testsuite/smokey/alchemytests/alchemytests.c | 1 +
 testsuite/smokey/alchemytests/task-2.c       | 1 +
 testsuite/smokey/psostests/rn-1.c            | 7 +++----
 testsuite/smokey/psostests/task-2.c          | 5 +++--
 testsuite/smokey/sched-tp/sched-tp.c         | 2 +-
 testsuite/smokey/vxworkstests/task-2.c       | 5 +++--
 utils/autotune/autotune.c                    | 4 +---
 9 files changed, 15 insertions(+), 12 deletions(-)

-- 
2.34.1

