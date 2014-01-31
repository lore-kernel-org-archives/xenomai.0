Message-ID: <52EB6BBC.8040600@xenomai.org>
Date: Fri, 31 Jan 2014 10:24:12 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAN1+YZVvgPNNHFub5QAkw6SeSUPuf1dv_94kYGqhbjMpNt70Sg@mail.gmail.com>
 <CAN1+YZWOjxf=s+6LH3Xymzx_mwWa6XmO_Xt7SHF589RzJCANBA@mail.gmail.com>
 <52D8609C.5050903@xenomai.org>
 <CAN1+YZW+nJgMb0hLy2JWZW6JrxA+mZzA+-oN-gjQgeGTcoe0jg@mail.gmail.com>
 <CAN1+YZUY_3FExF=qrUtMQDQxTqossnQsPCy6zfPjfqp8PitZCg@mail.gmail.com>
 <52D9984F.9080203@xenomai.org>
 <CAN1+YZWnLC=MLxWqYd9xH1URimWnOdEhU4mwZ0S3QFdpghUaGQ@mail.gmail.com>
 <52DAE756.3070606@xenomai.org>
 <CAN1+YZWmjvsu7My92EBktFhWYhheRJvdYrEq=r3+Ravp_Wzoyw@mail.gmail.com>
 <52DBC5FE.6060806@xenomai.org> <52DBD649.2000908@xenomai.org>
 <CAN1+YZWCMh4mR0ccw2v7FeuLKpYDUoPoB-FGHZmutj623DW7hw@mail.gmail.com>
In-Reply-To: <CAN1+YZWCMh4mR0ccw2v7FeuLKpYDUoPoB-FGHZmutj623DW7hw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Fwd: Kernel Compilation Problems
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Andy Pugh <andy@bodgesoc.org>
Cc: xenomai <xenomai@xenomai.org>

On 01/31/2014 01:05 AM, Andy Pugh wrote:
> On 19 January 2014 13:42, Gilles Chanteperdrix
> <gilles.chanteperdrix@xenomai.org> wrote:
> 
>>> Could you try the following patch to see if it improves anything?
>>
>> Sorry, wrong patch version. Please try this one instead:
> 
> The patch appears to reduce the latency to about 60uS.
> 
> I thought that setenv isolcpus=0 had had an effect, as I opened
> Firefox and didn't see max latency increase over the 45uS it was at,
> but then opening Chromium too pushed it up to 60uS.
> 
> Does Xenomai automatically choose the isolated CPU, or is some config needed?
> 
> In fact, how do I tell that I have an isolated CPU?

Use the xeno_hal.supported_cpus parameter, it is a bitfield, so 1 is for
cpu 0.

There is more we can do to improve performances on imx6:
- enable more features in the L2 cache auxiliary control register (the
value of this register is passed to the l2x0_init function, and
currently imx6 passes all 0)
- use the L2 cache "lockdown by master" feature, to reserve several
cache ways to the core where xenomai runs.

l2x0_init prints the value of the auxiliary control register at boot,
could you show me the boot logs you get to see which bits exactly are
already enabled?

Regards.

-- 
                                                                Gilles.

