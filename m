Message-ID: <472E06CF.1060305@domain.hid>
Date: Sun, 04 Nov 2007 18:52:15 +0100
From: Philippe Gerum <philippe.gerum@domain.hid>
MIME-Version: 1.0
References: <20071031154106.29f66afc@domain.hid>	<18216.57598.559447.478769@domain.hid>
	<20071104120932.0a396361@domain.hid>
In-Reply-To: <20071104120932.0a396361@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] rt_task_inquire and NULL 2nd arg
Reply-To: philippe.gerum@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Daniel Simon <Daniel.Simon@domain.hid>
Cc: xenomai@xenomai.org

Daniel Simon wrote:
> On Wed, 31 Oct 2007 21:09:34 +0100
> Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote:
> 
>> Daniel Simon wrote:
>>  > Hello all,
>>  > 
>>  > I am testing some former programs with
>>  > xenomai-2.4-rc4/kernel-2.6.23.1/pentiumM;
>>  > 
>>  > Calling rt_task_inquire(Id, NULL) with a null second argument now
>>  > freezes or reboots the pc...
>>  > 
>>  > I had no problem with this call with a former (2.3.1) xenomai version. Is
>>  > it a known behaviour?
>>
>> the rt_task_inquire system call checks that the "info" pointer points to
>> a piece of writable memory and returns -EFAULT otherwise. 
> That was the behaviour I got with xenomai-2.3.1 (I only wanted to check if the
> task was still existing and thus only interested in the value returned)
> 
>> So, what you
>> should get is a segmentation fault, no freeze or reboot. Actually, I
>> have tested a small test which segfaults as expected. Could you provide
>> us with the simple test that causes a freeze or reboot ?
>>
> file testinfo.c and config attached, uncommenting line 201 reboots the system
> at cleaning time after ^C 
> (xeno 2.4-rc5, kernel 2.6.23.1, gcc 4.0.2 with --xeno-cflags and --xeno-ldflags)
> 

As a matter of fact, the address checking code on x86* considers any
address below the page offset as being valid, so passing NULL went
undetected in your case. This was already the case with 2.3.1, you
likely just got lucky with respect to the consequences of another hole -
in the I-pipe this time - which has been plugged recently, and now fixes
up any fault whenever Xenomai has to leave it unhandled:
http://www.denx.de/cgi-bin/gitweb.cgi?p=ipipe-2.6.git;a=commit;h=e7b140c69794521fe8979a39337f36112dbe330c

The fix above was only available when CONFIG_IPIPE_DEBUG was enabled in
the latest patch series, and prevented any ungraceful consequence of
writing to an invalid address from the Xenomai domain. We actually need
to have this fixup done in any case. Next I-pipe patches will include
this change.

In short, rt_task_inquire() has never been meant to accept a NULL
parameter so far, and doing so was not properly caught at Xenomai level.
When using the invalid pointer that went undetected for writing the
output data back, some I-pipe issue let the resulting access fault
unhandled, causing a general panic state in the kernel whenever the
fixup above was not active (older I-pipe support or CONFIG_IPIPE_DEBUG
disabled).

I've slightly improved the address checking code for x86 32/64, so that
it also detects any address lower than the natural page size, which
would have caught the NULL case. We can't do much more, at least on the
fast path, than detecting addresses lower than PAGE_SIZE or located in
kernel memory. Other spurious addresses should trigger a segmentation
violation, which should be properly handled in all cases using an I-pipe
/x86 patch beyond 1.10-11 (the same goes for x86_64, beyond 1.2-05).

Now, it seems reasonable to ask rt_task_inquire() to test whether the
target task exists or not, in which case it may be acceptable to pass a
NULL buffer. This change will likely be applied to the trunk asap, and
will be part of -rc6.

-- 
Philippe.

