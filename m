References: <MWHPR11MB17100D1F48C3EF22B3C6A329F2E60@MWHPR11MB1710.namprd11.prod.outlook.com>
 <87lff5rtxl.fsf@xenomai.org>
 <CY4PR11MB170373477D42F1E0F39C1162F2E50@CY4PR11MB1703.namprd11.prod.outlook.com>
 <CY4PR11MB17031A0E3842869F923D353FF2E50@CY4PR11MB1703.namprd11.prod.outlook.com>
 <87tutrolj3.fsf@xenomai.org> <877dqkfgl2.fsf@xenomai.org>
 <MWHPR11MB171050871553AA646AE42130F2E20@MWHPR11MB1710.namprd11.prod.outlook.com>
 <87lfezetj9.fsf@xenomai.org>
 <MWHPR11MB1710A24CFCD223D9DC4E955FF2E00@MWHPR11MB1710.namprd11.prod.outlook.com>
 <MWHPR11MB17102B8431E8FB361CBA7637F2E00@MWHPR11MB1710.namprd11.prod.outlook.com>
 <72043f71-f89a-9167-b0cb-034493b966ee@siemens.com>
 <87k0uh4j7f.fsf@xenomai.org>
 <MWHPR11MB1710FF22D02B4C31494AA315F2FF0@MWHPR11MB1710.namprd11.prod.outlook.com>
 <877dqg2h0j.fsf@xenomai.org>
 <MWHPR11MB17104A3ABA4757E973ED5736F2F90@MWHPR11MB1710.namprd11.prod.outlook.com>
 <87wny591q6.fsf@xenomai.org>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: [Xenomai over dovetail] Kernel hang in rcu_barrier after
 xenomai_init
In-reply-to: <87wny591q6.fsf@xenomai.org>
Date: Sat, 28 Nov 2020 12:33:24 +0100
Message-ID: <87tut990mz.fsf@xenomai.org>
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
To: Philippe Gerum <rpm@xenomai.org>
Cc: "Chen, Hongzhan" <hongzhan.chen@intel.com>, xenomai@xenomai.org


Philippe Gerum via Xenomai <xenomai@xenomai.org> writes:
> Eventually, you may want to instrument/ftrace the idling code inside the
> do_idle() loop (kernel/sched/idle.c) to make sure that in-band irqs are
> enabled as expected (i.e. irqs_enabled() == true) every time

errr, well, this would make more sense: irqs_disabled() == false

-- 
Philippe.

