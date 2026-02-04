Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08BF5428479
	for <xenomai@lists.linux.dev>; Wed,  4 Feb 2026 18:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770228633; cv=none; b=FBp0tVaIMfDmUCHGsdCxMSHZ/rHH3asMm+IwYd/FLvGBD7ZOHUSFXwcYfcde1MjWswI5qZ1G5OdLwxDRPEwzVLL7kXzbIptESqGVfrmsI8eaPjKMKTWYBfhynpIewVC24dOkv9F0azyvbABqMujZXSi8RqfZ8Dw4OZfCS9fImVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770228633; c=relaxed/simple;
	bh=A1jUtaPdilTCghHed8fKIvm0+ZyHikC/hW5rs0Fc+lo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=InZq6OCeR/+t6/RTdQHxmDOT66wdH0yDY4Gw75h5dQpuNWWpGcyb5w5mpaPi4ROkuxlimDxN5CRkhf29pUQgP9gcwj67ean8C2YzmqtHQH4aH2JhqhP8RArQwm66u+vpaJoNDANRWzPtXxmQB5cWPLft+fm9X/pcNhZh+I2SKFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=Fy9sVvj/; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="Fy9sVvj/"
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 202602041810254d598bf3f7000207dc
        for <xenomai@lists.linux.dev>;
        Wed, 04 Feb 2026 19:10:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=eH8k4KfuuIKbPoO08Yd4hZFr6dL5w0Jjnsd4KWADLOc=;
 b=Fy9sVvj/Eyi4zbleO5eTkWnDhosjeg2V0TRy6Wg9lHxUIyI5T8E9+N7OKgi8Ki3+o0zoR9
 GW1E/nG68/hvQ2DwHMVtKiL3P5pOgECfTfKaEsZaaA6kiXvJ50F7caleyHcj8ZSD5mkhZeVA
 sfsxNg630cV0waO+oUweyCTqTsjUTyIvA4EgE9okjWdeWuBXJmcMnAgf21KVCgGhfL9163w+
 UI3KIQ4Q+65Hf/o/FSKBtifL9ch0XQbh/07ErtnGkM6pSfe24fL37i5210UoMrq1J1lWgQD6
 TRtDfn0EUBFH5vcomMQzogzaDg08dLTyIN+ssSpoRLOJHwMhc7zd/kxw==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Cc: Richard Weinberger <richard@nod.at>
Subject: [PATCH 0/3] Resolve kernel thread shutdown race, simplify host PID handling
Date: Wed,  4 Feb 2026 19:10:21 +0100
Message-ID: <cover.1770228624.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer

Triggered by Richard's analysis of a race we have between (RTDM) kernel
xnthreads terminating and xnthread_join waiting for them, this reworks
how we retrieve the PID of an xnthread host part, resolving that race
(hopefully) and simplifying/optimizing the code along that.

Patch 1 is a stable backport candidate.

Jan

Jan Kiszka (3):
  cobalt/thread: Keep host task PID in xnthread struct as well
  cobalt/thread: Simplify wait_for_rcu_grace_period
  cobalt: Eliminate xnthread_host_pid wrapper

 include/cobalt/kernel/thread.h    |  4 +--
 kernel/cobalt/debug.c             |  2 +-
 kernel/cobalt/dovetail/kevents.c  |  4 +--
 kernel/cobalt/dovetail/sched.c    |  2 ++
 kernel/cobalt/posix/event.c       |  2 +-
 kernel/cobalt/posix/process.c     |  5 ++--
 kernel/cobalt/posix/sem.c         |  2 +-
 kernel/cobalt/posix/thread.c      |  2 +-
 kernel/cobalt/posix/timer.c       |  2 +-
 kernel/cobalt/sched-quota.c       |  2 +-
 kernel/cobalt/sched-rt.c          |  2 +-
 kernel/cobalt/sched-sporadic.c    |  2 +-
 kernel/cobalt/sched-tp.c          |  2 +-
 kernel/cobalt/sched-weak.c        |  2 +-
 kernel/cobalt/sched.c             |  4 +--
 kernel/cobalt/thread.c            | 48 +++++++------------------------
 kernel/cobalt/trace/cobalt-core.h | 18 ++++++------
 17 files changed, 40 insertions(+), 65 deletions(-)

-- 
2.51.0

