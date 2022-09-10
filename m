Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5EB5EA2
	for <xenomai@lists.linux.dev>; Sat, 10 Sep 2022 10:04:22 +0000 (UTC)
Received: (Authenticated sender: philippe.gerum@sourcetrek.com)
	by mail.gandi.net (Postfix) with ESMTPSA id 145F31BF204;
	Sat, 10 Sep 2022 10:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1662804255;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X89wlY2i8zMzb5/qjJ+pM41u659QajkTsWKmDIGBtaQ=;
	b=kx4M0eOvOuLS1Hxt6H+pyym3lf8Wei7BcH29fFPg8gl6l5Uf67KbMuyrQ1SjXPCmr0hNt9
	ElKa5suqEkSxl8QJD/INu+A6kjGxpVQ5bvx58M7Fljk2Slw1hX0u442658u5M2OjjwJ3fW
	38jODxOVypgwjCeEqx/W61tWSUNFP/7gyDjlVo6GC6aJBQYBGsRxGyJFZcmbYj6fK3htE9
	bde/2AZlN96V86Sk1h9Z5qHfL8qcPrbdEkMT25RWBavyTfh2mAuizwfjcH3yp8uZvf2TLB
	2gr+dl1a9HMH/9MNXQfDXP9BoQ+DV+nRO3N4RV2ZEPcYiCvplonhBaLvOB428g==
References: <PH1P110MB10503EB7CC57455924221392E27E9@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <87pmg7ll5k.fsf@xenomai.org>
 <PH1P110MB1050FA42497EBD1CE9F2ECDDE2439@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
User-agent: mu4e 1.6.6; emacs 28.1
From: Philippe Gerum <rpm@xenomai.org>
To: Russell Johnson <russell.johnson@kratosdefense.com>
Cc: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Re: [External] - Re: SIGDEBUG signal received on oob_ioctl() call
 in EVL thread
Date: Sat, 10 Sep 2022 11:17:03 +0200
In-reply-to: <PH1P110MB1050FA42497EBD1CE9F2ECDDE2439@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
Message-ID: <87zgf7zgte.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain


Russell Johnson <russell.johnson@kratosdefense.com> writes:

> [[S/MIME Signed Part:Undecided]]
>> You may have EVL_DEBUG_WOLI enabled, and the cause reported by SIGDEBUG
> relates to this.
>
> So I ended up updating to the latest linux-evl kernel and libevl, and I ran
> some more tests. It appears that every time the EVL core sends the app a
> SIGDEBUG signal on an oob_ioctl call, that the kernel also logs a page fault
> in dmesg.

The core tells the app about the exact cause in the siginfo data passed
to the signal handler, which can be queried by sigdebug_cause().

PF reports in dmesg also give the $PC register value (in user space) at
the time of the fault, can you try matching this address to some portion
of user code using gdb? Knowing the general location of this code, and a
disassembly output starting 20 lines before, ending 20 lines after this
spot may help understanding what is going on.

> I have also seen page faults on other evl system calls such as
> evl_read_clock() (which of course calls oob_ioctl under the hood).

evl_read_clock() is a bit special in the sense that we expect an initial
PF there, which is forcibly triggered by evl_init(). But we should see
this happening once, in a controlled fashion, not more.

Is there any pattern regarding the other syscalls affected by this, or
does this seem to affect any syscall randomly, whatever the application?
Or is it a particular set of calls which is affected and/or a particular
application?

> There
> must be something in the oob_ioctl() code in libevl (such as the varargs)
> that can sometimes lead to re-sizing or some kind of memory allocation (not
> necessarily bad).

varargs handling in C should not involve any reallocation. As you likely
saw already, the oob_ioctl() implementation is trivial, early resolving
to a plain system call trap. Granted, we also call
pthread_setcanceltype() there, but we used that interface extensively
over the years in xenomai2 and xenomai3 as well without any issue. With
a recent glibc at least, this boils down to a cmpxchg basically.

> I am not sure exactly why this would lead to page faults
> however. mlockall() is being used in evl_init(). I also set
> mallopt(M_MMAP_MAX, 0) and mallopt(M_TRIM_THRESHOLD, -1). I believe
> each EVL

This tuning would not protect the app from unwanted mode switches, the
malloc() arena is guarded by a common mutex, which might or might not be
contented at the time of the call, leading to a regular futex syscall or
not. So one never knows whether malloc()/free() would actually cause a
stage switch.

> thread's stack is prefaulted. I even prefault the EVL heap after it is
> setup. Any ideas?
>

Do you think it would be possible to reproduce this issue for one of
these syscalls in a standalone test case?

-- 
Philippe.
