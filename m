Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795642466;
	b=sGdhpWorSfTnkGTIbZuhQBDDTIVMPGQLt4zvvM4UcCRaAH/mZIywUFsWM6du97lzOKll
	 pPr2hSa1avGQtpjS9XTJSEXAR4d+4d0LhecyLNtNwCW0PG+kX81G9ukxxt1j/76QONDJZ
	 NMd3Aplz4csyhryYzWrQDUrbeGpv0RpiatVV7hsHsNAoXm4UttBv01i/LrMYae/8E8Ac0
	 YWTiEkd/+BlaiHo96f2reV6aDn8fo+TNlFiZRsg7R2ah8R+5zkV2ciBkMAMhKaSoavRIs
	 27NRSnZNe9nD3tbrrXTMTNgSGyUZ11ne+tz9JJg7Dhoy+M5uJcOkeEsf5sne9efZK/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795642466;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=bHzwv9cqseyKiVnarSRz5nOqzcPgYfKwDZ+JbFyiqQA=;
	b=xfno7TRuM261pzR9gCvTCyx+xypUAIlNorlq61+s750WFNg0DAuw1O9zwBx/YJUJ5hqv
	 JSCAgug4AooM1WPhXUylvBb7KhtA6mMo45TZU2CVQNQCsyZ7OmgUDeMhphIO3gNEXb/GN
	 mkhvsRikjwQSzAlNoQv08wRFkkRLNoUHgCyiNufaiXC+ngP7PHPyG4NU0g0ijQwObyHdp
	 O+V6pp/J2XP61m0MkPaMdn3JbckdNMmiRphgWpfo1PeoXTVou4gobte2ndLG9ixptEj2J
	 YdwZ6dPFPLqGvjxGc30/dK6p5avEAl4znV1mUKcNXTQAwywc5xAGVZWcYJk1PMS5bJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bsnAgJAv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D36606A31E
	for <xenomai@lists.linux.dev>; Wed, 25 Nov 2026 21:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bsnAgJAv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BE5C1F000D1;
	Wed, 25 Nov 2026 21:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795642465;
	bh=bHzwv9cqseyKiVnarSRz5nOqzcPgYfKwDZ+JbFyiqQA=;
	h=From:To:Cc:Subject:Date;
	b=bsnAgJAvtx2CGysEBplyMTpoR5cEiOD+vfKhgsCP2mTO6/Nboj4VMiYB7z7EhOrBX
	 qICgcEvVIXtvGN3lLgJ2YraxIGzgfuix281qiudh+47SXMVhTOV+NdnF+/AHEXV05c
	 RwgOv9J3bGZqjIVQlG/d6+S+dwuyyL05buJSfgWxmZ70DHN1FfayvPV6DqR3Pp4DU2
	 mLpQSrhcmYHPvOKZTU91yCsYy/dxoG3UYjVM9tIrGnGAq16qMtmGNcXxOA+mhd9ArR
	 dcQuvbVdTmDv2Z/t4NIhXjdZhykCkOfa7JPCDP80Wng248mJZjtPJIPq6+x3fDA+dA
	 YIM7vN+ECs1Zw==
From: "Richard Weinberger (sigma star gmbh)" <rw@kernel.org>
To: xenomai@lists.linux.dev
Cc: upstream+xenomai@sigma-star.at,
	Richard Weinberger <richard@nod.at>
Subject: [PATCH 0/7] Alchemy: Fix calling context checks and documentation
Date: Wed, 25 Nov 2026 22:34:12 +0100
Message-ID: <20261125213419.2363742-1-rw@kernel.org>
X-Mailer: git-send-email 2.55.0
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

From: Richard Weinberger <richard@nod.at>

Several Alchemy services refuse callers which are not Copperplate
tasks, although they do not need a Copperplate TCB at all, or only
need one when actually waiting. As a result, Cobalt POSIX threads,
which are Xenomai threads according to the API documentation, get
-EPERM from rt_mutex_acquire(), rt_task_yield(), rt_pipe_read() or
rt_event_wait(), and even from queue/buffer/heap calls which could
be satisfied immediately.

Also the documentation is inaccurate. It keeps referring to "Xenomai
threads" where a Copperplate task, or even an Alchemy task, is
actually required.

At first I thought fixing the documentation would be the best way to
go. Then I remembered a customer application which does mix the
Alchemy and POSIX skins, so I gave improving the Alchemy layer a try.

Patch 6/7 is worthy of discussion, I'm not so sure whether it really
brings a real gain.

Thanks,
//richard

Richard Weinberger (7):
  lib/alchemy/mutex: Allow any Xenomai thread to acquire a mutex
  lib/alchemy/task: Allow rt_task_yield() from any thread
  lib/alchemy: Document the actual calling context requirements
  lib/alchemy/pipe: Do not require a Xenomai task for blocking reads
  lib/alchemy/event: Require a Xenomai task only for waiting over
    Mercury
  lib/alchemy: Require a Xenomai task only when actually waiting
  testsuite/smokey/alchemytests: Test Alchemy services from POSIX
    threads

 include/alchemy/mutex.h                      |   3 +-
 lib/alchemy/alarm.c                          |   9 -
 lib/alchemy/buffer.c                         |  23 +-
 lib/alchemy/cond.c                           |   3 +-
 lib/alchemy/event.c                          |  11 +-
 lib/alchemy/heap.c                           |  13 +-
 lib/alchemy/mutex.c                          |  22 +-
 lib/alchemy/pipe.c                           |  15 +-
 lib/alchemy/queue.c                          |  23 +-
 lib/alchemy/sem.c                            |   3 +-
 lib/alchemy/task.c                           |  86 +++---
 lib/copperplate/eventobj.c                   |   5 +
 lib/copperplate/init.c                       |  10 +
 testsuite/smokey/alchemytests/Makefile.am    |  10 +
 testsuite/smokey/alchemytests/alchemytests.c |   2 +
 testsuite/smokey/alchemytests/mutex-3.c      | 158 +++++++++++
 testsuite/smokey/alchemytests/posix-1.c      | 259 +++++++++++++++++++
 17 files changed, 561 insertions(+), 94 deletions(-)
 create mode 100644 testsuite/smokey/alchemytests/mutex-3.c
 create mode 100644 testsuite/smokey/alchemytests/posix-1.c

-- 
2.55.0

