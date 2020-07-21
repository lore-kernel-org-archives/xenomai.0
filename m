Subject: Re: Dovetail <-> PREEMPT_RT hybridization
References: <2c2da877-f9e7-9be7-d659-c51235738bc0@xenomai.org>
 <BYAPR11MB3765087193BDF5EB45094A5DEE780@BYAPR11MB3765.namprd11.prod.outlook.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <b4c53b27-3de9-3264-0a3f-0563f95321ec@xenomai.org>
Date: Tue, 21 Jul 2020 19:18:21 +0200
MIME-Version: 1.0
In-Reply-To: <BYAPR11MB3765087193BDF5EB45094A5DEE780@BYAPR11MB3765.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Meng, Fino" <fino.meng@intel.com>, Evl <evl@evlproject.org>
Cc: "Xenomai (xenomai@xenomai.org)" <xenomai@xenomai.org>

On 7/21/20 7:26 AM, Meng, Fino wrote:
> 
>> Sent: Tuesday, July 21, 2020 4:47 AM
>>
>> FWIW, I'm investigating the opportunity for rebasing Dovetail - and therefore the EVL core - on the PREEMPT_RT code base,
>> ahead of the final integration of the latter into the mainline kernel tree. In the same move, the goal would be to leverage the
>> improvements brought by native preemption with respect to fine-grained interrupt protection, while keeping the alternate
>> scheduling [1] feature, which still exhibits significantly shorter preemption times and much cleaner jitter compared to what
>> is - at least currently - achievable with a plain PREEMPT_RT kernel under meaningful stress.
>>
>> With such hybridization, the Dovetail implementation should be even simpler.
>> Companion cores based on it could run on the out-of-band execution stage unimpeded by other forms of preemption
>> disabling in the in-band kernel (e.g.
>> locks). This would preserve the most significant advantage of the pipelining model when it comes to reliable response times
>> for applications at a modest processing cost by a lightweight real-time infrastructure.
>>
>> This work entails porting the latest Dovetail code base I have been working on lately from 5.8 back to 5.6-rt, since this is the
>> most recent public release of PREEMPT_RT so far. In addition, interrupt-free sections which are deemed too long for the
>> companion core on top to cope with, need to be identified in the target PREEMPT_RT release so that they could be mitigated
>> (see below for an explanation about how it could be done). In the future, a way to automate such research should be
>> looked for, since finding these spots is likely going to be the boring task to carry out each time this new Dovetail
>> implementation is ported to the next PREEMPT_RT release. Plus, the truckload of other tricky issues I may have overlooked.
>>
>> If anyone is interested in participating in this work, let me know. I cannot guarantee success, but the data I have collected
>> over time with both the dual kernel and native preemption models leaves me optimistic about the outcome if they are
>> combined the right way.
> 
> Hi Philippe,
> 
> I would like to participate. One the of motivation is the TSN stack is now within Preempt-RT Linux. 
> Some time ago we have discussed with Jan about similar idea, patch Ipipe/Xenomai onto Preempt-RT kernel but not vanilla kernel, 
> then separate Cobalt thread and Preempt-RT's RT thread to different cores.
> 

Ok. As far as I'm concerned, I'm only scratching an itch, I find some interest
in looking for ways to downsize the hardware for running applications with
demanding response time requirements, without necessarily resorting to a plain
rtos.

Back to the initial point, this work should involve, roughly:

- implementing a Dovetail variant in the native preemption kernel. This is
actually not a direct port, the new implementation would depart from the
current Dovetail code in significant ways, although the basics would be the
same, only used differently. I plan to work on this, although it would be much
better if other folks would join me in the implementation once the thing is
bootstrapped.

- identifying and quantifying the longest interrupt-free sections in the
target preempt-rt kernel under meaningful stress load, with the irqoff tracer.
I wrote down some information [1] about the stress workloads which actually
make a difference when benchmarking as far as I can tell. At any rate, the
results we would get there would be crucial in order to figure out where to
add the out-of-band synchronization points, and likely of some interest
upstream too. I'm primarily targeting armv7 and armv8, it would be great if
you could help with x86.

- the two previous points are obviously part of an iterative process centered
on testing the implementation with a real-time core. I'm going to use the EVL
core for this, since it is sitting on Dovetail already.

[1] https://evlproject.org/core/benchmarks/#stress-load

-- 
Philippe.

