References: <MWHPR11MB17100D1F48C3EF22B3C6A329F2E60@MWHPR11MB1710.namprd11.prod.outlook.com>
 <87lff5rtxl.fsf@xenomai.org>
 <CY4PR11MB170373477D42F1E0F39C1162F2E50@CY4PR11MB1703.namprd11.prod.outlook.com>
 <CY4PR11MB17031A0E3842869F923D353FF2E50@CY4PR11MB1703.namprd11.prod.outlook.com>
 <87tutrolj3.fsf@xenomai.org>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: [Xenomai over dovetail] Kernel hang in rcu_barrier after
 xenomai_init
In-reply-to: <87tutrolj3.fsf@xenomai.org>
Date: Tue, 17 Nov 2020 11:00:41 +0100
Message-ID: <877dqkfgl2.fsf@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Chen, Hongzhan" <hongzhan.chen@intel.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>


Philippe Gerum <rpm@xenomai.org> writes:

> Chen, Hongzhan <hongzhan.chen@intel.com> writes:
>
>> I have some clues about this issue. After xenomai_init is called, it seems that rcu_core
>> is never called from unknow startpoint ever after call call_rcu, which is supposed to be 
>> called by rcu softirq handler after we call call_rcu.
>> I am trying to debug why rcu softirq is not triggerred after then.
>>
>
> You may want to make sure this is not offloaded to RCU kthreads,
> typically in case you run with nocbs settings. This said, tracing
> rcu_core() would match both.
>
> I did not reproduce the issue you observed with the EVL core, testing
> v5.8, v5.9 and v5.10-rc3. I'm currently running an overnight test to
> confirm this. This is why we need to be confident that an half-baked
> port on top of Dovetail is not causing this.

44 hours uninterrupted runtime on armv7, x86 and armv8, under stress: no
issue detected so far. This does not rule out a Dovetail bug yet, but
the possibility of a Cobalt issue is real.

-- 
Philippe.

