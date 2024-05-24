Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3743128396
	for <xenomai@lists.linux.dev>; Fri, 24 May 2024 08:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.40.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716539850; cv=none; b=DA7Tyr9hWTgTtiVsdSIGdhFyaD7KDfpJ3UzpvraFegy6T4Yga2dKE1wxs/nlqqYiB0tktm9M9YNPp5gzKn0SfyD++TwiSWQ4PDMGXRIOpJwKQkDPuQJPZOs5dfwYZiaf/nepuy+uFYjJ1+3xD0avzpWD6Rge0imzhsBHtTOBo/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716539850; c=relaxed/simple;
	bh=ZjAbQTu5khwpZcI+NzEwAcW0cQdbX1BDxtiCJR8cDaE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pyKqn7jtJrhhBauK5Czh/ZwXW5j9BBCz404L6TL5Zvge/+eQbfOpxOpJImYpCJmA+SPZcZ82fRhiaYAJKmuNyEFgKOM2hy5tiMPy5XNClM8jMRnczOENCs0jUayCDLpKmWzYuChEOx+1iqapKaUXpHxKQtGC3pUCmf/uE1BHrIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=195.201.40.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id C43086340E1A;
	Fri, 24 May 2024 10:37:18 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id vYqy0jkOLWec; Fri, 24 May 2024 10:37:18 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 601FD62348A5;
	Fri, 24 May 2024 10:37:18 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id WPpwCAQpe3Zr; Fri, 24 May 2024 10:37:18 +0200 (CEST)
Received: from foxxylove.corp.sigma-star.at (unknown [82.150.214.1])
	by lithops.sigma-star.at (Postfix) with ESMTPSA id 237EA6195FCF;
	Fri, 24 May 2024 10:37:18 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: xenomai@lists.linux.dev
Cc: lorenz@sigma-star.at,
	Richard Weinberger <richard@nod.at>
Subject: [PATCH v2 0/2] Fix rt_task_unblock for RT_MUTEX
Date: Fri, 24 May 2024 10:36:40 +0200
Message-Id: <20240524083642.19434-1-richard@nod.at>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Changes since v1 [0]:
- Better names for EINTR capable functions
- Remove want_eintr flag and loop around __pthread_mutex_lock()
- Correctly integrate mutex-2 test into smokey test framework

[0]: https://lore.kernel.org/xenomai/91a15d69-ea68-49a9-8daf-d52ae31f6d49=
@siemens.com/T/#mf76a46eaa5ec033bacdfc63ca219af3bb84356b3

Richard Weinberger (2):
  Alchemy: Fix rt_task_unblock() for RT_MUTEX
  alchemytests: Add test case for RT_MUTEX and -EINTR

 include/cobalt/pthread.h                     |   5 +
 lib/alchemy/mutex.c                          |   8 ++
 lib/cobalt/mutex.c                           |  44 ++++++--
 testsuite/smokey/alchemytests/Makefile.am    |   5 +
 testsuite/smokey/alchemytests/alchemytests.c |   1 +
 testsuite/smokey/alchemytests/mutex-2.c      | 111 +++++++++++++++++++
 6 files changed, 164 insertions(+), 10 deletions(-)
 create mode 100644 testsuite/smokey/alchemytests/mutex-2.c

--=20
2.35.3

