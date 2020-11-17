From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
Subject: RE: [Xenomai over dovetail] Kernel hang in rcu_barrier after
 xenomai_init
Date: Tue, 17 Nov 2020 12:40:59 +0000
Message-ID: <MWHPR11MB171050871553AA646AE42130F2E20@MWHPR11MB1710.namprd11.prod.outlook.com>
References: <MWHPR11MB17100D1F48C3EF22B3C6A329F2E60@MWHPR11MB1710.namprd11.prod.outlook.com>
 <87lff5rtxl.fsf@xenomai.org>
 <CY4PR11MB170373477D42F1E0F39C1162F2E50@CY4PR11MB1703.namprd11.prod.outlook.com>
 <CY4PR11MB17031A0E3842869F923D353FF2E50@CY4PR11MB1703.namprd11.prod.outlook.com>
 <87tutrolj3.fsf@xenomai.org> <877dqkfgl2.fsf@xenomai.org>
In-Reply-To: <877dqkfgl2.fsf@xenomai.org>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, "xenomai@xenomai.org" <xenomai@xenomai.org>



>-----Original Message-----
>From: Philippe Gerum <rpm@xenomai.org>=20
>Sent: Tuesday, November 17, 2020 6:01 PM
>To: Chen, Hongzhan <hongzhan.chen@intel.com>
>Cc: xenomai@xenomai.org
>Subject: Re: [Xenomai over dovetail] Kernel hang in rcu_barrier after xeno=
mai_init
>
>
>Philippe Gerum <rpm@xenomai.org> writes:
>
>> Chen, Hongzhan <hongzhan.chen@intel.com> writes:
>>
>>> I have some clues about this issue. After xenomai_init is called, it se=
ems that rcu_core
>>> is never called from unknow startpoint ever after call call_rcu, which =
is supposed to be=20
>>> called by rcu softirq handler after we call call_rcu.
>>> I am trying to debug why rcu softirq is not triggerred after then.
>>
>>
>> You may want to make sure this is not offloaded to RCU kthreads,
>> typically in case you run with nocbs settings. This said, tracing
>> rcu_core() would match both.
>>
>> I did not reproduce the issue you observed with the EVL core, testing
>> v5.8, v5.9 and v5.10-rc3. I'm currently running an overnight test to
>> confirm this. This is why we need to be confident that an half-baked
>> port on top of Dovetail is not causing this.
>
>44 hours uninterrupted runtime on armv7, x86 and armv8, under stress: no
>issue detected so far. This does not rule out a Dovetail bug yet, but
>the possibility of a Cobalt issue is real.
>
>--=20
>Philippe.

Thanks for your feedback.  I already found the root cause for the issue. Ac=
cording to my
debug on evl, I found that actually after call tick_install_proxy , the ori=
ginal=20
hrtimer_interrupt would be called by proxy_irq_handler instead of   __sysve=
c_apic_timer_interrupt
so that  rcu_sched_clock_irq still can be successfully called by  update_pr=
ocess_times and
invoke_rcu_core would always be called and callback registerred by call_rcu=
 can be successfully handled.
But in my case, after call tick_install_proxy in xenomai, update_process_ti=
mes is never called and then
cause hang in rcu_barrier issue later. I would continue to check why fail t=
o replace timer irq in my case.

Regards

Hongzhan Chen


