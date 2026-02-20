Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0ED337BAD
	for <xenomai@lists.linux.dev>; Fri, 20 Feb 2026 10:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771582109; cv=none; b=aAjpnCGLDShw0RMF/3Ssb/aSGMiQlhn+GSok6kbQDZFK8ZybAeGmvK8JSj/VzRXnnVRJ/CYWiGZ0ZanbhTCaWsHbQNjQRkeWki+FbAxeGVgDQdbyP/fRymGgxs1LdQwRfKgec7wi2ayzEcWtrezNEV0ogduEg1QTJe/fLO53QCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771582109; c=relaxed/simple;
	bh=8PmPFooObj08vQslldFmkPAvAj/7iFz65mmUz8YI8c4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XxZO2dMV6C1yOA32bSBIlfv+N0Ct7IzBGTZY95r6nkCxzPOS4nHJ7ptt4XVmKPFWMN8UyUiMK+V9YXYBSrpyrYv98vEZawHzGH7IdPxf8nboIlythvfOzpeisXhER/pznqubcLg3IZecyZQsY6phM7/UwlApFYa7qTgKzUy9+fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=nw6SO5Ik; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="nw6SO5Ik"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1A51B41D3B;
	Fri, 20 Feb 2026 10:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1771582099;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mskmdKK60Bkwe0uwqtZZPDMl1axmMBbWQsXNTjxhDHs=;
	b=nw6SO5IkoeT+rKS6CsM1YyVDn7Md9b8WioppuW9pbSILiVY/rgh1v1dI4nV9BWVUR/VsYu
	wCOQfSlN5iUGk0jwhMkObCI/rBPYxMrdYCJ5m+0W58GhItX43bQeQhzBoPI4X2Sanxsn5Q
	8zVxEfooBvPzqPpRLg7/xSVBNRzAOyPHM8/aStrOymvwYn3nJSL2guCJMHTH8Uo0rEelXF
	uzsqrtBQwO0ell31u1XO+8iZLXTMVoPhtBZ9QUD0qvjkYTIrYPpzb0gI/IgvcfZ5BbbIGC
	3O3jyniIRJEjxCjr06/FW1nqT9gQMSQ7XqmREgK2N2A3YDnEpUoobnREYlDQnw==
From: Philippe Gerum <rpm@xenomai.org>
To: Tobias Schaffner <tobias.schaffner@siemens.com>
Cc: xenomai@lists.linux.dev,  Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: evl: ptrace continue without hardware singlestepping support
In-Reply-To: <40a86435-758d-49c5-8ae3-078ea32b5e0f@siemens.com> (Tobias
	Schaffner's message of "Thu, 19 Feb 2026 15:03:07 +0100")
References: <40a86435-758d-49c5-8ae3-078ea32b5e0f@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Fri, 20 Feb 2026 11:08:18 +0100
Message-ID: <87o6ljhgml.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: rpm@xenomai.org
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdekudehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtgfesthhqredttderjeenucfhrhhomheprfhhihhlihhpphgvucfivghruhhmuceorhhpmhesgigvnhhomhgrihdrohhrgheqnecuggftrfgrthhtvghrnhepvdehiefhgffffeelueetiefgieejhfegvefhlefgvdeiudfhffdutddvffduheeunecuffhomhgrihhnpehgnhhurdhorhhgnecukfhppedvrgdtudemvgdtrgemudelsgemfegtugdtmeelkeelrgemhegtgegsmegsjehffhemsggrfhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgdtrgemudelsgemfegtugdtmeelkeelrgemhegtgegsmegsjehffhemsggrfhdphhgvlhhopehphihrohdpmhgrihhlfhhrohhmpehrphhmseigvghnohhmrghirdhorhhgpdhqihgupeduteehudeugeduffefuedpmhhouggvpehsmhhtphhouhhtpdhnsggprhgtphhtthhopeefpdhrtghpthhtohepjhgrnhdrkhhishiikhgrsehsihgvmhgvnhhsrdgtohhmpdhrtghpthhtohepgigvnhhomhgriheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehtohgsihgrshdrshgthhgrfhhfnhgvr
 hesshhivghmvghnshdrtghomh
X-GND-State: clean
X-GND-Score: -100

Tobias Schaffner <tobias.schaffner@siemens.com> writes:

> Hi Philippe,
>
> the RISC-V port has an open issue regarding OOB synchronization of
> threads in the EVL ptrace implementation, which leads to a deadlock
> when running the ptrace-sync test.
>
> RISC-V currently does not support hardware-based single stepping, and
> GDB=E2=80=99s behavior on `continue` with multiple threads is different.
>
> If hardware single stepping is available, GDB single-steps the hitter
> with PTRACE_SINGLESTEP and continues the other threads with
> PTRACE_CONT. All threads are continued and can pass the
> evl_wait_event() barrier in handle_ptstop_event(). The hitter breaks
> again and is finally continued.
>
> In contrast, if hardware single stepping is not available, GDB adds a
> breakpoint to the next instruction, wakes only the hitter with
> PTRACE_CONT, and waits for it to make its step before waking its
> siblings. However, the hitter is not able to make its step because it
> waits in the kernel for its siblings in evl_wait_event(), which are
> not going to be woken by GDB until the hitter makes its step.
>
> The attached strace files show the behavior of GDB on both
> architectures when continuing the breaking worker thread in
> `ptrace.c`.
>
> Jan already pointed out that there may be a general problem with
> expecting GDB to always continue all threads, and I think he is
> right. Changing the scheduler-locking mode in All-Stop Mode [1], as
> well as switching to Non-Stop Mode [2], should lead to similar issues.
>

Stop mode would be an issue if the synchronization fully happened on
PTCONT, but the evl core requires threads to wait on the sync barrier
only if they received PTSTOP in the first place. Did you observe any
actual issue with enabling non-stop mode by testing on your end? I just
tested with ptrace-sync and observed the right behavior. This does not
preclude the issue observed with sw breakpoints though, but this would
be a different problem.

root@corei7-64-evl:~# __EVL_DEBUGGEE__=3D1 gdb /usr/libexec/evl/tests/ptrac=
e-sync=20
GNU gdb (GDB) 16.3
Copyright (C) 2024 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.htm=
l>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.
Type "show copying" and "show warranty" for details.
This GDB was configured as "x86_64-blade-linux".
Type "show configuration" for configuration details.
For bug reporting instructions, please see:
<https://www.gnu.org/software/gdb/bugs/>.
Find the GDB manual and other documentation resources online at:
    <http://www.gnu.org/software/gdb/documentation/>.

For help, type "help".
Type "apropos word" to search for commands related to "word"...
Reading symbols from /usr/libexec/evl/tests/ptrace-sync...
(gdb) b bp
warning: could not convert 'bp' from the host encoding (ANSI_X3.4-1968) to =
UTF-32.
This normally should not happen, please file a bug report.
Breakpoint 1 at 0x26db: bp. (3 locations)
(gdb) set non-stop on
(gdb) r
Starting program: /usr/libexec/evl/tests/ptrace-sync=20
[Thread debugging using libthread_db enabled]
Using host libthread_db library "/lib/libthread_db.so.1".
[New Thread 0x7ffff7d166c0 (LWP 595)]
[New Thread 0x7ffff7d056c0 (LWP 596)]

Thread 1 "gdb-main:592" hit Breakpoint 1.1, bp () at ../../../../git/xenoma=
i/v4/libevl/tests/ptrace-sync.c:59
warning: 59	../../../../git/xenomai/v4/libevl/tests/ptrace-sync.c: No such =
file or directory
(gdb) info thr
  Id   Target Id                                        Frame=20
* 1    Thread 0x7ffff7d17b40 (LWP 592) "gdb-main:592"   bp ()
    at ../../../../git/xenomai/v4/libevl/tests/ptrace-sync.c:59
  2    Thread 0x7ffff7d166c0 (LWP 595) "gdb-test:592.1" (running)
  3    Thread 0x7ffff7d056c0 (LWP 596) "gdb-test:592.2" (running)
(gdb) c
Continuing.

Thread 3 "gdb-test:592.2" hit Breakpoint 1.3, bp ()
    at ../../../../git/xenomai/v4/libevl/tests/ptrace-sync.c:59
59	in ../../../../git/xenomai/v4/libevl/tests/ptrace-sync.c
(gdb) info thr
  Id   Target Id                                        Frame=20
* 1    Thread 0x7ffff7d17b40 (LWP 592) "gdb-main:592"   (running)
  2    Thread 0x7ffff7d166c0 (LWP 595) "gdb-test:592.1" (running)
  3    Thread 0x7ffff7d056c0 (LWP 596) "gdb-test:592.2" bp ()
    at ../../../../git/xenomai/v4/libevl/tests/ptrace-sync.c:59
(gdb) thr 3
[Switching to thread 3 (Thread 0x7ffff7d056c0 (LWP 596))]
#0  bp () at ../../../../git/xenomai/v4/libevl/tests/ptrace-sync.c:59
59	in ../../../../git/xenomai/v4/libevl/tests/ptrace-sync.c
(gdb) c
Continuing.

Thread 2 "gdb-test:592.1" hit Breakpoint 1.3, bp ()
    at ../../../../git/xenomai/v4/libevl/tests/ptrace-sync.c:59
59	in ../../../../git/xenomai/v4/libevl/tests/ptrace-sync.c
(gdb) info thr
  Id   Target Id                                        Frame=20
  1    Thread 0x7ffff7d17b40 (LWP 592) "gdb-main:592"   (running)
  2    Thread 0x7ffff7d166c0 (LWP 595) "gdb-test:592.1" bp ()
    at ../../../../git/xenomai/v4/libevl/tests/ptrace-sync.c:59
* 3    Thread 0x7ffff7d056c0 (LWP 596) "gdb-test:592.2" (running)
(gdb) thr 2
[Switching to thread 2 (Thread 0x7ffff7d166c0 (LWP 595))]
#0  bp () at ../../../../git/xenomai/v4/libevl/tests/ptrace-sync.c:59
59	in ../../../../git/xenomai/v4/libevl/tests/ptrace-sync.c
(gdb) c
Continuing.
[Thread 0x7ffff7d056c0 (LWP 596) exited]
[Thread 0x7ffff7d166c0 (LWP 595) exited]
[Inferior 1 (process 592) exited normally]

> Do you have a suggestion how to solve this?
>

Regarding sw breakpoints, there may be two options based on your
findings:

- defer the PTCONT notification to the real-time core
  (inband_ptcont_notify) until after the ptracer notices the wake up of
  the debuggee, allowing it to wake up the siblings in turn. Currently,
  PTSTOP/PTCONT are sent by the debuggee around its stop point.

- check whether we could monitor the PTSTEP event which is sent by the
  ptracer when it resumes a debuggee.

I'll have a look at this.

--=20
Philippe.
