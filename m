From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
Subject: RE: [Xenomai over dovetail] Kernel hang in rcu_barrier after
 xenomai_init
Date: Sat, 14 Nov 2020 01:55:00 +0000
Message-ID: <CY4PR11MB170373477D42F1E0F39C1162F2E50@CY4PR11MB1703.namprd11.prod.outlook.com>
References: <MWHPR11MB17100D1F48C3EF22B3C6A329F2E60@MWHPR11MB1710.namprd11.prod.outlook.com>
 <87lff5rtxl.fsf@xenomai.org>
In-Reply-To: <87lff5rtxl.fsf@xenomai.org>
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
>Sent: Saturday, November 14, 2020 2:30 AM
>To: Chen, Hongzhan <hongzhan.chen@intel.com>
>Cc: xenomai@xenomai.org
>Subject: Re: [Xenomai over dovetail] Kernel hang in rcu_barrier after xeno=
mai_init
>
>
>Chen, Hongzhan via Xenomai <xenomai@xenomai.org> writes:
>
>> Recently I have been working on wip/dovetail branch to port xenomai over
>> dovetail. After fixed all TODOs for porting xenomai, kernel init now can
>> successfully finish xenomai init till hang in rcu_barrier.=20
>> Its call path is like this start_kernel->arch_call_rest_init->rest_init-=
>
>> kernel_thread(kernel_init, NULL, CLONE_FS)->kernel_init->mark_readonly
>> ->rcu_barrier when hang issue happen.=20
>>
>> According to my debug , before call xenomai_init, all callback function=
=20
>> registerred with call_rcu can be invoked successfully after a period of =
time.
> The first problematic call_rcu which its callback never be invoked can be=
=20
> traced back to call xenomai_init  (actually I just found only one call_rc=
u=20
> called during xenomai_init) before call rcu_barrier.=20
>
> In addition , after xenomai_init is completed , all following callbacks w=
ith=20
> registerred through call_rcus called by other driver init are also never=
=20
> invoked till call rcu_barrier.
>
> Is it not safe to call call_rcu with enabling xenomai over dovetail in th=
is=20
> case?
>
>Such a restriction would not make any sense, making Dovetail pretty much
>unusable, right? So, no.
>
>> What I should do to fix this issue?  Please help comment.
>>
>> I have pushed all my patches onto my public branch=20
>> https://github.com/hongzhanchen/xenomai/tree/hzchen/dovetail ,please fee=
l=20
>> free to check them.=20
>>
>
>Unfortunately, the tree you mentioned does not even remotely builds,
>tons of code commented out triggering warning about a collection of
>pending TODOs, also with plain errors like:
>
>/work/git/worktrees/xenomai+dovetail-5.8/kernel/xenomai/intr.c:284:37: err=
or: 'IPIPE_NR_IRQS' undeclared here (not in a function)
>/work/git/worktrees/xenomai+dovetail-5.8/kernel/xenomai/intr.c:472:6:
>error: implicit declaration of function '__ipipe_irq_handler'; did you
>mean 'xnintr_irq_handler'? [-Werror=3Dimplicit-function-declaration]
>
>I tried to build it on top of dovetail-v5.8 from [1], which is the
>reference version for that kernel. I would suggest to address the
>pending work - at least the obviously critical one - in the Cobalt core
>first, before going for any meaningful debug next.
>
>[1] https://git.evlproject.org/linux-evl.git/tag/?h=3Dv5.8-dovetail
>
>--=20
>Philippe.
=20
Thanks for your feedback. Sorry for the confusion because I forgot to=20
point out the config which I am using to build kernel. =20
Please use https://github.com/hongzhanchen/xenomai/blob/hzchen/dovetail/ATT=
51154_IGB.config to build kernel.=20
With using this config,the kernel would hang in igb driver at first,=20
which issue Jan promised to help debug. Please disable IGB=20
driver before you build and after then the kernel built is supposed=20
to be reproducible for hang in icu_barrier issue.
Yes, there is still some TODO warning like in intr.c. But as you mentioned =
in
 https://xenomai.org/pipermail/xenomai/2020-February/042488.html,=20
"kernel/cobalt/irq.c and related can go".=20
Actually there is no kernel/cobalt/irq.c file but kernel/cobalt/intr.c.=20
Per my understanding , only kernel/cobalt/intr.c
 involve irq management so that means most of TODOs mentioned in intr.c sho=
uld be NA.=20
Please correct me if I am wrong.  Actually before I debug kernel , I double=
 check if I have fixed all critical issues.
After then , I encouraged myself to move forward. But I maybe miss somethin=
g referring to
critical issue because I  am newer to both Xenomai and dovetail. If you fou=
nd that there is other=20
critical issues I have not fixed or something wrong with my fixing, please =
help point out. I would appreciate it.
Thanks for your time and suggestions again.

Regards

Hongzhan Chen


