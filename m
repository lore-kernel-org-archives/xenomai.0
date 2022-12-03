Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [217.70.178.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ACDA1FA0
	for <xenomai@lists.linux.dev>; Sat,  3 Dec 2022 16:43:56 +0000 (UTC)
Received: (Authenticated sender: philippe.gerum@sourcetrek.com)
	by mail.gandi.net (Postfix) with ESMTPSA id CFBD4240009;
	Sat,  3 Dec 2022 16:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1670085828;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1xQzGuAhv6EXeN2r7vr4oaFIbkpZLYujVqskBQfM4Zw=;
	b=LtYWMLax+cb4Cb1z2iYqIU6nxhvOo5KXc6e7EeeqXTh/m0qZy+YrTwWImEzo8yjEDnw7c2
	t6OoA+rvRFANANcTUoHVJoeufLHH6XgIi4aEHOs3cA5sV/17ZzbWiNWIdF4Bc7ACi+7pPM
	PYSqu+szOEFlBQrgFROP5hvtgCqx10RMscaDvt/vEhjzwAxUviKbAe766ObU2U70Ay8x3h
	XonakiZrqOn8UgKZ9Fw1LYobmGPzaDScvmXE6s6eXlzb2nA7asFPvcJ+igxJoQ71Tv1PHr
	ARUiPTcwOKikPEn4w8mV3LhBGhD/xUV67n/X751gzDnfqCVOSvgJawlz7C6t2Q==
References: <CAAm9oxrZ+g7RgBV0SC5GkvEeKKGXOZb2R_BRjf0qRObQM1wCgg@mail.gmail.com>
 <87mt84h3h0.fsf@xenomai.org>
User-agent: mu4e 1.6.6; emacs 28.1
From: Philippe Gerum <rpm@xenomai.org>
To: Sri Subramanian <sridhar.subramanian@gmail.com>
Cc: xenomai@lists.linux.dev
Subject: Re: Xenomai crash in timer IRQ
Date: Sat, 03 Dec 2022 17:33:37 +0100
In-reply-to: <87mt84h3h0.fsf@xenomai.org>
Message-ID: <87ilish1z0.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain


Philippe Gerum <rpm@xenomai.org> writes:

> Sri Subramanian <sridhar.subramanian@gmail.com> writes:
>
>> Hello,
>>
>> I have an application waking up every 500us (waiting with an
>> oob_read() on an EVL monotonic clock) and taking action.
>>
>> The application also has an interface to enable/disable NTP and set
>> the clock manually. The system will run over days without any issues.
>> But if NTP is disabled, and the clock is set manually, then NTP is
>> re-enabled, a short time after (order of minutes), the OS crashes and
>> the system reboots. It is reproducible every time.
>>

I cannot reproduce this using a plain hwclock -s while latmus
runs.

>> Should the monotonic clock be affected by an RTC clock setting? I was
>> assuming not, but I am not so sure now.
>>
>
> Not EVL_CLOCK_MONOTONIC.
>
>> Hardware environment: Raspberry PI CM4 with a standard CM4-IO board.
>> Xenomai tag: 5.15.77-evl-rebase
>> Stack and config as below:
>>
>> Thanks for any help,
>> Sri
>> ==========
>> [  363.094612] CPU: 3 PID: 706 Comm: EcatCyclic-tid_ Tainted: G
>>  C        5.15.35-xeno-v5.15.77-evl1-rebase #1
>> [  363.094617] Hardware name: Raspberry Pi Compute Module 4 Rev 1.0 (DT)
>> [  363.094619] IRQ stage: Linux
>> [  363.094621] pstate: 200000c5 (nzCv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>> [  363.094626] pc : evl_get_timer_overruns+0x1b8/0x1c4
>> [  363.094630] lr : evl_get_timer_overruns+0x54/0x1c4
>> [  363.094634] sp : ffffffc00a283c40
>> [  363.094635] x29: ffffffc00a283c40 x28: 0000000000000000 x27: ffffff810103acc0
>> [  363.094642] x26: ffffff810103ac00 x25: ffffffc008deb320 x24: ffffffc008c6aae8
>> [  363.094647] x23: 0000000000000000 x22: ffffff81fefde3e0 x21: 0000000000000001
>> [  363.094652] x20: 000000548931dc32 x19: ffffff810103ac00 x18: 0000000000000000
>> [  363.094658] x17: 0000000000000000 x16: 0000000000000001 x15: 0000000000000000
>> [  363.094662] x14: 0000000000000000 x13: ffffffc00898a790 x12: 00000000fa83b2da
>> [  363.094667] x11: 0000000000000029 x10: 0000000000000930 x9 : ffffffc00a283c30
>> [  363.094673] x8 : ffffff811c496810 x7 : 000000000000b7df x6 : 00000004a520e245
>> [  363.094678] x5 : 00ffffffffffffff x4 : 0011bdb637657ad8 x3 : 000000000007a120
>> [  363.094683] x2 : 0000000000000001 x1 : 0000000000000005 x0 : 0000000000000005
>> [  363.094688] Call trace:
>> [  363.094691]  evl_get_timer_overruns+0x1b8/0x1c4
>> [  363.094695]  timerfd_oob_read+0x200/0x290

Since the crash is easily reproducible, you should be able to trace it
directly into the kernel code, i.e. from evl_get_timer_overruns(), to
figure out which line is causing this. Or you could disassemble your
vmlinux image compiled with CONFIG_DEBUG_INFO set, and look for a
statement which matches $pc as reported in the register dump.

I pushed a change addressing a potential load tearing issue in the timer
code to the next-evl-rebase. I don't think this fixes the issue you
observed, but at the very least you may want that change in.

Next step for you would be to enable the ftracer (using next-evl-rebase,
it contains fixes you need for tracing), then post a snapshot of the
global trace buffer until the crash happens. ftrace_dump_on_oops may be
useful if you cannot access the machine after the oops, with a bit of
luck the snapshot should be sent to the console stream.

-- 
Philippe.
