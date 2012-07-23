Message-ID: <500DA033.9090901@xenomai.org>
Date: Mon, 23 Jul 2012 21:04:19 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <5009DF76.5010306@nta-inc.net> <500A6516.10703@xenomai.org>
	<bc8da858918a991cb436fa7f40576b87.squirrel@www.nta-inc.net>
	<500CF868.70208@xenomai.org> <500D86BC.3050507@nta-inc.net>
In-Reply-To: <500D86BC.3050507@nta-inc.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Lockup with Xenomai 2.6.1 / Linux 3.2.21 after bootup
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jeff Webb <jeff.webb@nta-inc.net>
Cc: xenomai@xenomai.org

On 07/23/2012 07:15 PM, Jeff Webb wrote:
> On 07/23/2012 02:08 AM, Gilles Chanteperdrix wrote:
>>>> fasteoi irqs have been reworked in the I-pipe core patch (for linux
>>>> 3.2). It would be nice if you could check whether 3.2 solves the issue
>>>> you have.
>>>
>>> I did try using linux 3.2.21 (?) with the I-pipe core patch, but the
>>> system locks up shortly after the login prompt appears.  I didn't
>>> have an
>>> easy way to post the stack trace, so I haven't reported that issue
>>> yet.  I
>>> was going to look through the mailing list archives to see how you
>>> recommend collecting useful information to report in this situation,
>>> but I
>>> haven't had a chance to do that yet.  What's the next step in debugging
>>> the problem?
>>
>>
>> If there is a stack trace, it is the best lead. In order to collect it,
>> you need another computer, and either use the serial console or
>> netconsole. In the past, we have already received photos of a stack
>> trace.
>>
>
> I changed the subject line to something more appropriate to avoid
> confusion, since we're talking about the 3.x series now.  Thanks for the
> advice -- I was able to get a stack trace using the serial console.  It
> seems like moving the mouse may have triggered the lockup.  Here is the
> stack trace:
>

Actually, the pipeline reports the same issue than the regular irq 
subsystem did earlier, in its own way though, via a BUG() assertion. We 
have a seemingly unassigned vector triggering an IRQ. Weird.

> ------------[ cut here ]------------
> kernel BUG at arch/x86/kernel/ipipe.c:592!

...

> do_IRQ: 30 callbacks suppressed
> do_IRQ: 0.153 No irq handler for vector (irq -1)
>
>
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> http://www.xenomai.org/mailman/listinfo/xenomai
>


-- 
Philippe.



