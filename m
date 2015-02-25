From: Lowell Gilbert <kludge@be-well.ilk.org>
References: <44bnkqho7e.fsf@lowell-desk.lan>
 <20150218220804.GR30317@hermes.click-hack.org>
 <44pp9633yh.fsf@lowell-desk.lan> <447fvc5q6z.fsf@be-well.ilk.org>
 <20150220225712.GE2356@hermes.click-hack.org>
 <448ufmewxt.fsf@be-well.ilk.org>
 <20150224233439.GL14148@hermes.click-hack.org>
Date: Wed, 25 Feb 2015 11:22:19 -0500
In-Reply-To: <20150224233439.GL14148@hermes.click-hack.org> (Gilles
 Chanteperdrix's message of "Wed, 25 Feb 2015 00:34:39 +0100")
Message-ID: <44siduq7us.fsf@be-well.ilk.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Xenomai] interrupt service
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Thanks for the help, even if I'm not making much progress yet.

Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> writes:

> On Tue, Feb 24, 2015 at 06:01:18PM -0500, Lowell Gilbert wrote:

> To have a real basic configuration, you should use Xenomai 2.6.4 and
> with the latest I-pipe patch for Linux 3.14. Unmodified.

I went ahead and did that, just to be sure. Results were the same.

>> put the i-pipe TSC code back into smp_twd.c
>> to get a high-resolution clock.
>
> The TSC code in smp_twd.c conflicts with Linux global timer driver.
> Simply enable the global timer driver if you want to use the global
> timer as tsc.

Got it. Thanks.


Philippe Gerum <rpm@xenomai.org> writes:

> -	return 0;
> +	return RTDM_IRQ_HANDLED;

Yes, that bug crept in when I was building the simplified test case.
My original driver used the correct return values.


I'm still confused by the fact that the thread wakes up fine if it's
signalled (or unblocked, etc.) from a driver operation. But if the ISR
tries to do the same, it fails. In fact, if I use rtdm_task_unblock(), I
get an error (0) returned to the ISR.


Be well.

