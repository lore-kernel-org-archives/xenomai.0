Message-ID: <52D19762.5010001@xenomai.org>
Date: Sat, 11 Jan 2014 20:11:30 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <44lhyrmuw9.fsf@be-well.ilk.org>
 <52CC7D71.4040703@steinkuehler.net> <52CC83F1.40000@xenomai.org>
 <52CC85C5.4060703@steinkuehler.net> <52CC8A18.2020807@xenomai.org>
 <52CCA101.2040604@steinkuehler.net>
 <3FA64D57-1BB1-4B4A-AB25-AC8E280105F8@mah.priv.at>
 <52D18B7D.5080705@xenomai.org> <52D18D0A.8010905@xenomai.org>
 <52D194F4.6030706@xenomai.org>
In-Reply-To: <52D194F4.6030706@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] i-pipe tracer on in production kernels? (was Re:
 Altera Cyclone V)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 01/11/2014 08:01 PM, Philippe Gerum wrote:
> On 01/11/2014 07:27 PM, Gilles Chanteperdrix wrote:
>> On 01/11/2014 07:20 PM, Philippe Gerum wrote:
>>> On 01/11/2014 11:22 AM, Michael Haberler wrote:
>>>> 
>>>> http://www.xenomai.org/index.php/I-pipe:Tracer describes the
>>>> trace API, which could be useful to track down issues
>>>> 
>>>> Q: does enabling the tracer incur significant overhead if
>>>> compiled in but unused, or is it reasonable to leave it on in a
>>>> production kernel?
>>>> 
>>>> if the former, we might have to build/make available a second
>>>> i-pipe tracer enabled kernel to track down issues 'in the
>>>> field'; if the latter, it'd be less build/distribution chores
>>>> 
>>> 
>>> The I-pipe tracer is based on the ftrace infrastructure, so
>>> tracepoints are left out when the tracer is disabled. If you can
>>> live with the minimal overhead ftrace adds, then leaving the
>>> I-pipe tracer code built in may be an option.
>> 
>> That is less true without DYNAMIC_FTRACE than with DYNAMIC_FTRACE.
>> 
>> 
> 
> This is about 10% overhead on low-end 52xx, 5-7% on am335x. I did not
> check on typical x86 < 2 Ghz yet, but this should be around 3-5%. It
> is just a matter of how much is too much.
> 
> Regarding DYNAMIC_FTRACE, we have had this out for too many moons
> (2.6.2x...), and we need to reconsider this (this looks somewhat like
> an old writing from an ancient book, nobody really remembers the
> meaning of - I wonder if I was not the guy who switched this off, out
> of some nightmare debugging session).

I believed it was me, but checking the logs, it seems to be due to this
commit:

https://git.xenomai.org/ipipe-gch.git/commit/kernel/trace/Kconfig?h=for-ipipe-2.6.29-arm&id=6e8b204b6ec92ca007ec099f2878c340f5b64b48

So, it seems it has been that way since the I-pipe tracer is based on
ftrace.

> 
> Anyway, enabling it on am335x looks ok at first sight, and I suspect
> that the usual problem of synchronizing better and harder against the
> code patching loop is gone.

I have tried on OMAP3 on my side, and I agree it seems to work. The code
patching is done within an ipipe_critical added by the I-pipe patch.

-- 
                                                                Gilles.

