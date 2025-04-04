Received: from lithops.sigma-star.at (mailout.nod.at [116.203.167.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9994145B25
	for <xenomai@lists.linux.dev>; Fri,  4 Apr 2025 19:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.167.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743794235; cv=none; b=EuR2fZ8hIUzGlShbVz+eYDoenCw05zWLQzpxLRqfpDJQAzZ/of4oWCtzABAMa19yVDC8YdIFNwhk9nBPF6nunNsBhCtiOjGYRHewX3HjeIZf/zzeJPL1dXr3WRAC5l1M43tsDgz3FlHdaBNgju/FuJ28Z5MKCbVFJxhMQ1lwDDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743794235; c=relaxed/simple;
	bh=Z4BFZGXejZwTZQ/36FOZPfqIACJc3YVysQMMkM8Mp24=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NbSd4/ZU0wQLg5WtR7kNT8lh9in1V8NyKc5vkKdTatJU0mjlXcG/CIPVXGXS68gIjy5HTwnf5WA8ZXlbK1S/K5i6jnGDABsJ+VVeTv/AVLRN0ErPpdeDi1SxcYCC/sAdHnyxSEMBianXZ/SMpQcKfVMT6jdHYEz+FBw0DZatWXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=116.203.167.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 9066E298576;
	Fri,  4 Apr 2025 21:09:08 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id VKem7nPHpzyf; Fri,  4 Apr 2025 21:09:08 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 32A0229857D;
	Fri,  4 Apr 2025 21:09:08 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Ci05ePeI7JVQ; Fri,  4 Apr 2025 21:09:08 +0200 (CEST)
Received: from foxxylove.corp.sigma-star.at (unknown [82.150.214.1])
	by lithops.sigma-star.at (Postfix) with ESMTPSA id F2FF9298576;
	Fri,  4 Apr 2025 21:09:07 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: xenomai@lists.linux.dev
Cc: upstream+xenomai@sigma-star.at,
	Richard Weinberger <richard@nod.at>
Subject: [PATCH] cobalt/dovetail: Fill fault statistics counters
Date: Fri,  4 Apr 2025 21:08:57 +0200
Message-ID: <20250404190857.17773-1-richard@nod.at>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

/proc/xenomai/faults reports always zeros on dovetail.
Looks like filling these counters was forgotten
for the dovetail case.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 kernel/cobalt/dovetail/kevents.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/cobalt/dovetail/kevents.c b/kernel/cobalt/dovetail/ke=
vents.c
index 0f70dbc27..9fa75faa1 100644
--- a/kernel/cobalt/dovetail/kevents.c
+++ b/kernel/cobalt/dovetail/kevents.c
@@ -43,6 +43,8 @@ void handle_oob_trap_entry(unsigned int trapnr, struct =
pt_regs *regs)
 	 */
 	trace_cobalt_thread_fault(xnarch_fault_pc(regs), trapnr);
=20
+	raw_cpu_ptr(&cobalt_machine_cpudata)->faults[trapnr]++;
+
 	if (xnthread_test_state(thread, XNROOT))
 		return;
=20
--=20
2.43.0

