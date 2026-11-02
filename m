Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.136.64.227
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793622400;
	b=jP0KMzquB3qzYkwttQ77aOGqhYGQlD0kaX2/jUexTrDEHMsP5NK9Y+4a3oHeBln5lam7
	 k4/sA2OptzCwV4W8U3FriPEnKWvKClb5BQc6TijbcH1xqIMZwOj6n7ifWfRdb9jvteMGy
	 Sy0Bppgc95GJ6Z2SUuJSrvIYj2+2mRj8H8apS4ESIFYro2soXNWNqMEpEBqfdfZnM/dCa
	 pU+x+OwXwnsfLhOi66g2pzyYoL6EC0jvEoGEOadDIUrtU1vCDhLHC55qGqjcF+igIZL3m
	 Ypfn2qOFdCgaSjPQV5DJ35DsKlmIGsS4jXYvJ+tW9lVkDT9OQ2zQsFD39XQL0/xpPoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793622400;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Subject:From:To:Date:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 MIME-Version:X-Flowmailer-Platform:Feedback-ID;
	bh=PZrxVek2OmsubRMYfrBD08EM1Ccd3+DQEmkbx9OAE1g=;
	b=EdpbTKWAf9FOn03YKtWdEv9eRkIGAziNloaaBKgrGlrV37EUOkmXMUvE+AqPxJKYlVyF
	 1EANNHGcOgotDumsYMlgVDdsWhbTvxZjxGzFQindbYuq0gS/KohZGozfoeNvMO9VzyRyS
	 EGt8RW/LdOF78ARuD6P5TvlZA25YrxLjRGdT3N3e7bsM3ardCBYQ7LPtEF2q+PGZnJVSz
	 zzVP3nWD408e4JnBaWvhj5v/UIx5BEwJHBN+G3nBdP7R4fyEEW8L/lL0cokK/zk/opgke
	 vWVucSom+XbTrUhLUux0vGVXp8v7OkP9ZBiSE5b7MF06hNlwoyBSibxgamftKXAm+zg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=rts-flowmailer.siemens.com;
	dkim=pass header.d=siemens.com header.i=florian.bezdeka@siemens.com header.a=rsa-sha256 header.s=fm2 header.b=pKNuj3sV;
	arc=none smtp.remote-ip=185.136.64.227
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30993606A326
	for <xenomai@lists.linux.dev>; Mon,  2 Nov 2026 12:26:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 30993606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.a=rsa-sha256 header.s=fm2 header.b=pKNuj3sV
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20261102122608fb6c5f7ba000020713
        for <xenomai@lists.linux.dev>;
        Mon, 02 Nov 2026 13:26:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=PZrxVek2OmsubRMYfrBD08EM1Ccd3+DQEmkbx9OAE1g=;
 b=pKNuj3sVaiBRMGkwVs3pCpxFIPnm7IjTyfpjhAlV4dYdo+9MWu0fbQah/YT4mz5A80Y6Va
 uDBlVTbewHOaxO7PDzZSwDBi/B5QGWCMDvaFrtoYF8IkbFYTxKTf9lqEuzJjmTp3bOrulkSk
 w1Q8/Gqqqcn01wqIMQ/lZnmBMsCLeBGnq2CE62HDxaeyLHi3zX2Q9CDRBkLhZ7FYuZgvHvRh
 shY8eu7YsVfnF44aEDAubHAIZTzfOUrzlxeqkBlZ9fCttiBHK7OmYOalL2Ok47F509jOe7Dp
 NLEDv/A2xbealg6ER+BYy7wXfe69BVj3IMGrgL1yYuIhMcLqnRjiXUnA==;
Message-ID: <1a410c7333520471b00d688af1fb261777ddd201.camel@siemens.com>
Subject: Re: Nested dovetail_fault_entry/exit and mark_trap_entry/exit on ARM
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, Philippe Gerum <rpm@xenomai.org>, 
 Xenomai <xenomai@lists.linux.dev>
Date: Mon, 02 Nov 2026 13:26:07 +0100
In-Reply-To: <8ecd3d1a-86d1-4f39-b175-b712c0be6eec@siemens.com>
References: <8ecd3d1a-86d1-4f39-b175-b712c0be6eec@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Post: <mailto:xenomai@lists.linux.dev>
List-Help: <mailto:xenomai+help@lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
List-Owner: <mailto:xenomai+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

On Sun, 2026-11-01 at 21:56 +0800, Jan Kiszka wrote:
> Hi all,
>=20
> while rebasing 6.18.y over a fresh stable version, I noticed some
> inconsistencies in the ARM trap handling in 7.2 / upcoming 7.3. I
> vaguely recall Florian once noticed that as well, but I do not find
> traces of that right now.
>=20
> do_sect_fault calls dovetail_fault_entry/exit around do_bad_area,
> declaring this a ARM_TRAP_SECTION. However, do_bad_area also does
> dovetail_fault_entry/exit with ARM_TRAP_ACCESS for __do_user_fault. The
> other caller of do_bad_area, do_alignment, performs a
> mark_trap_entry/exit(ARM_TRAP_ALIGNMENT) while dovetail_fault_entry/exit
> does that internally as well (but then with different ARM_TRAP).
>=20
> It looks to me like the inner dovetail_fault_entry/exit should be
> dropped, and do_alignment should be switched to
> dovetail_fault_entry/exit. Or are there catches?

In general I agree. This nesting might confuse the co-kernel.

It seems that every caller of __do_{user,kernel}_fault() calls
dovetail_mark_trap_{entry,exit}(ARM_TRAP_ACCESS) around those calls.
That includes do_bad_area() - but only for the user part - which is
inconsistent.

Testing the following ATM (baseline 7.3):

diff --git a/arch/arm/mm/alignment.c b/arch/arm/mm/alignment.c
index 612db267f6246..b7635bc4a1d75 100644
--- a/arch/arm/mm/alignment.c
+++ b/arch/arm/mm/alignment.c
@@ -803,6 +803,7 @@ do_alignment(unsigned long addr, unsigned int fsr, stru=
ct pt_regs *regs)
 {
        union offset_union offset;
        unsigned long instrptr;
+       unsigned long irqflags;
        int (*handler)(unsigned long addr, u32 instr, struct pt_regs *regs)=
;
        unsigned int type;
        u32 instr =3D 0;
@@ -815,7 +816,7 @@ do_alignment(unsigned long addr, unsigned int fsr, stru=
ct pt_regs *regs)
        if (addr >=3D TASK_SIZE && user_mode(regs))
                harden_branch_predictor();
=20
-       mark_trap_entry(ARM_TRAP_ALIGNMENT, regs);
+       irqflags =3D dovetail_fault_entry(ARM_TRAP_ALIGNMENT, regs);
=20
        if (!arch_kentry_test_stalled(regs))
                local_irq_enable();
@@ -1007,7 +1008,7 @@ do_alignment(unsigned long addr, unsigned int fsr, st=
ruct pt_regs *regs)
        }
=20
 out:
-       mark_trap_exit(ARM_TRAP_ALIGNMENT, regs);
+       dovetail_fault_exit(ARM_TRAP_ALIGNMENT, regs, irqflags);
=20
        return ret;
 }
diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index 95870a96a6286..da2420534495e 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -212,17 +212,19 @@ void do_bad_area(unsigned long addr, unsigned int fsr=
, struct pt_regs *regs)
 {
        struct task_struct *tsk =3D current;
        struct mm_struct *mm =3D tsk->active_mm;
-       unsigned long irqflags;
+
+       /*
+        * irq_pipeline: No dovetail_mark_trap_{entry,exit}() here. All cal=
lers
+        * are expected to have informed the co-kernel already.
+        */
=20
        /*
         * If we are in kernel mode at this point, we
         * have no context to handle this fault with.
         */
-         if (user_mode(regs)) {
-               irqflags =3D dovetail_fault_entry(ARM_TRAP_ACCESS, regs);
+         if (user_mode(regs))
                __do_user_fault(addr, fsr, SIGSEGV, SEGV_MAPERR, regs);
-               dovetail_fault_exit(ARM_TRAP_ACCESS, regs, irqflags);
-         } else
+         else
                /*
                 * irq_pipeline: kernel faults are either quickly
                 * recoverable via fixup, or lethal. In both cases, we
