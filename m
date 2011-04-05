Message-ID: <4D9B69A4.7050902@domain.hid>
Date: Tue, 05 Apr 2011 21:12:36 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <COL122-W376680783697A8A880DC2BBDA20@domain.hid>	<infaa9$eoe$1@domain.hid>	<4D9B4EC0.5080701@domain.hid>
	<infnf9$6jm$1@domain.hid>
In-Reply-To: <infnf9$6jm$1@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Tiny Core Linux + xenomai/RTAI
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: gmane@domain.hid
Cc: xenomai@xenomai.org

Robert Berger wrote:
> Hi Gilles,
> 
> On 04/05/2011 08:17 PM, Gilles Chanteperdrix wrote:
>> Ok, we are on Xenomai-core, so, let us discuss. If we admit that the OP
>> is indeed talking about latencies (a quantifiable measure of
>> determinism), suggesting that the effect on cache of the Linux kernel
>> might influence the latencies is not completely irrelevant: the
>> benchmark we make with Xenomai tend to consistently show that cache
>> thrashing by the Linux kernel has an effect on latencies.
> 
> Yes this did not immediately come into my mind. Linux cache thrashing
> affects latencies of threads running under Xenomai (user and/or kernel
> space), but as you point out (
> http://permalink.gmane.org/gmane.linux.real-time.xenomai.devel/8167 )
> that is distro independent.

Yes, and I completely agree with your answer, I was just replying for
the sake of completeness.

> 
> I know that the answer to this question might not be trivial, but what
> would you suggest could be done to minimize cache thrashing?

If we are talking embedded systems, you have control over the non
real-time activities you run, you can try and be greedy in the way they
use cache (I am not sure anyone really does that, I, for one, tried and
optimize a toy application for cache usage to see that the effect is
impressive).

The other way, is not to minimize cache thrashing, but to minimize its
effect on latencies. You can do that by increasing the frequency of the
"critical" real-time task. By increasing its frequency, you make it more
likely to remain in cache, and so decrease its latency. This is why, for
instance, on most (*) platforms you get a better latency with smaller
periods.

On some embedded platforms, you also have the choice to lock some cache
lines, or move some data or code to some fast memory essentially as fast
as cache (TCMs or SRAMs on ARM). This is a promising solution, at least
on ARM, where many SOCs have such special memory, but as far as I know,
nobody tried yet and reported success of failure.

(*) the exception being armv4 or armv5 without the FCSE extension, where
the cache is flushed all the time anyway.

> 
>> Also, having shorter latencies means that we cover a larger range of
>> user-application needs. So, we try to have short latencies.
>>
> 
> Whoever wants to see Xenomai latencies in action can compile cyclictest
> with and without Xenomai and see the differences. On the platforms I've
> tried so far the differences are clearly visible;)

Again, I agree with your answer, determinism, i.e. worst case latency is
what matters for a real-time system, but:
- smaller worst case latency covers a broader range of applications;
- smaller average case latency means more CPU cycles for the Linux
kernel to run, so, the dual-kernels based solutions still try to
preserve the average case latency and are a bit special with regard to
that particular question.

-- 
                                                                Gilles.

