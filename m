Message-ID: <4FCC98F7.9060103@xenomai.org>
Date: Mon, 04 Jun 2012 13:16:07 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <4FC8F8EE.4010901@xenomai.org> <4FC8FBD0.3020206@siemens.com>
	<4FC90486.4010308@xenomai.org>
In-Reply-To: <4FC90486.4010308@xenomai.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] x86_32 mayday
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

On 06/01/2012 08:05 PM, Gilles Chanteperdrix wrote:
> On 06/01/2012 07:28 PM, Jan Kiszka wrote:
>> On 2012-06-01 19:16, Gilles Chanteperdrix wrote:
>>>
>>> Hi,
>>>
>>> with the current tip of xenomai 2.6 branch, the "sigdebug" test testing
>>> the "mayday" code ends up with a segfault on x86_32. I tried to have a
>>> look at it, but could not really understand what happens: the register
>>> on return from the syscall are ok, but the segfault happens after return
>>> from the signal handler, when returning from the interrupted function.
>>> It looks like either ebp, or the function return adress are wrong.
>>>
>>> If anyone wants to have a look at it... Jan maybe?
>>
>> Can't promise, but will try to find a slot.
>>
>> I think I didn't test on x86-32 so far. Is this a regression or did you
>> run the test for the first time as well?
>
> First time since 2.6.0, and with 2.6.0, mayday was segfaulting
> everywhere anyway.
>

Silly nasty bug. This is fixed now:
http://git.xenomai.org/?p=xenomai-2.6.git;a=commit;h=3bd460bd22295e87a9850fd8439e94557f094904

Basically, mayday over x86_32 never worked properly with SEP enabled.

This is quite weird that this went unnoticed for such a long time. So 
either most people do not mention --enable-x86-sep albeit they most 
likely should these days, or they don't install any SIGDEBUG handler, or 
they call exit() from within that handler. The net effect of this bug 
was that returning from any routine in user-space after the mayday fixup 
happened, would pop an invalid IP off the stack.

Btw, I don't think it makes sense to keep sysentry/sysexit support 
disabled by default for x86 anymore. The same way we already assume 
x86-tsc is present by default, we should assume x86-sep is there too. 
People running pre-Pentium II CPUs (seriously?) would have to switch it 
off explicitly via --disable-x86-sep.

If nobody freaks out badly contemplating this idea, I'll push a patch.

-- 
Philippe.

