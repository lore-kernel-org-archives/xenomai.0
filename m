Subject: Re: [Xenomai over dovetail] Kernel hang in rcu_barrier after
 xenomai_init
References: <MWHPR11MB17100D1F48C3EF22B3C6A329F2E60@MWHPR11MB1710.namprd11.prod.outlook.com>
 <87lff5rtxl.fsf@xenomai.org>
 <CY4PR11MB170373477D42F1E0F39C1162F2E50@CY4PR11MB1703.namprd11.prod.outlook.com>
 <87h7pss052.fsf@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <2e5710b1-a763-ed6e-5291-0be22ec46cc9@siemens.com>
Date: Sat, 14 Nov 2020 12:30:57 +0100
MIME-Version: 1.0
In-Reply-To: <87h7pss052.fsf@xenomai.org>
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
To: Philippe Gerum <rpm@xenomai.org>, "Chen, Hongzhan" <hongzhan.chen@intel.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 14.11.20 11:28, Philippe Gerum via Xenomai wrote:
> 
> Chen, Hongzhan <hongzhan.chen@intel.com> writes:
> 
>>> -----Original Message-----
>>> From: Philippe Gerum <rpm@xenomai.org> 
>>> Sent: Saturday, November 14, 2020 2:30 AM
>>> To: Chen, Hongzhan <hongzhan.chen@intel.com>
>>> Cc: xenomai@xenomai.org
>>> Subject: Re: [Xenomai over dovetail] Kernel hang in rcu_barrier after xenomai_init
>>>
>>>
>>> Chen, Hongzhan via Xenomai <xenomai@xenomai.org> writes:
>>>
>>>> Recently I have been working on wip/dovetail branch to port xenomai over
>>>> dovetail. After fixed all TODOs for porting xenomai, kernel init now can
>>>> successfully finish xenomai init till hang in rcu_barrier. 
>>>> Its call path is like this start_kernel->arch_call_rest_init->rest_init->
>>>> kernel_thread(kernel_init, NULL, CLONE_FS)->kernel_init->mark_readonly
>>>> ->rcu_barrier when hang issue happen. 
>>>>
>>>> According to my debug , before call xenomai_init, all callback function 
>>>> registerred with call_rcu can be invoked successfully after a period of time.
>>> The first problematic call_rcu which its callback never be invoked can be 
>>> traced back to call xenomai_init  (actually I just found only one call_rcu 
>>> called during xenomai_init) before call rcu_barrier. 
>>>
>>> In addition , after xenomai_init is completed , all following callbacks with 
>>> registerred through call_rcus called by other driver init are also never 
>>> invoked till call rcu_barrier.
>>>
>>> Is it not safe to call call_rcu with enabling xenomai over dovetail in this 
>>> case?
>>>
>>> Such a restriction would not make any sense, making Dovetail pretty much
>>> unusable, right? So, no.
>>>
>>>> What I should do to fix this issue?  Please help comment.
>>>>
>>>> I have pushed all my patches onto my public branch 
>>>> https://github.com/hongzhanchen/xenomai/tree/hzchen/dovetail ,please feel 
>>>> free to check them. 
>>>>
>>>
>>> Unfortunately, the tree you mentioned does not even remotely builds,
>>> tons of code commented out triggering warning about a collection of
>>> pending TODOs, also with plain errors like:
>>>
>>> /work/git/worktrees/xenomai+dovetail-5.8/kernel/xenomai/intr.c:284:37: error: 'IPIPE_NR_IRQS' undeclared here (not in a function)
>>> /work/git/worktrees/xenomai+dovetail-5.8/kernel/xenomai/intr.c:472:6:
>>> error: implicit declaration of function '__ipipe_irq_handler'; did you
>>> mean 'xnintr_irq_handler'? [-Werror=implicit-function-declaration]
>>>
>>> I tried to build it on top of dovetail-v5.8 from [1], which is the
>>> reference version for that kernel. I would suggest to address the
>>> pending work - at least the obviously critical one - in the Cobalt core
>>> first, before going for any meaningful debug next.
>>>
>>> [1] https://git.evlproject.org/linux-evl.git/tag/?h=v5.8-dovetail
>>>
>>> -- 
>>> Philippe.
>>  
>> Thanks for your feedback. Sorry for the confusion because I forgot to 
>> point out the config which I am using to build kernel.  
>> Please use https://github.com/hongzhanchen/xenomai/blob/hzchen/dovetail/ATT51154_IGB.config to build kernel. 
>> With using this config,the kernel would hang in igb driver at first, 
>> which issue Jan promised to help debug. Please disable IGB 
>> driver before you build and after then the kernel built is supposed 
>> to be reproducible for hang in icu_barrier issue.
>> Yes, there is still some TODO warning like in intr.c. But as you mentioned in
>>  https://xenomai.org/pipermail/xenomai/2020-February/042488.html, 
>> "kernel/cobalt/irq.c and related can go". 
>> Actually there is no kernel/cobalt/irq.c file but kernel/cobalt/intr.c. 
>> Per my understanding , only kernel/cobalt/intr.c
>>  involve irq management so that means most of TODOs mentioned in
>> intr.c should be NA.
>> Please correct me if I am wrong.  Actually before I debug kernel , I double check if I have fixed all critical issues.
>> After then , I encouraged myself to move forward. But I maybe miss something referring to
>> critical issue because I  am newer to both Xenomai and dovetail. If you found that there is other 
>> critical issues I have not fixed or something wrong with my fixing, please help point out. I would appreciate it.
>> Thanks for your time and suggestions again.
>>
> 
> FWIW, I would take a whole different approach to porting Xenomai over
> Dovetail than the one that took place so far: instead of substituting
> calls here and there mostly by looking for drop-in replacements between
> the I-pipe and Dovetail interfaces - which may or may not exist -
> playing whack-a-mole with build and runtime issues eventually, it may be
> better to abstract the pipeline-specific code the generic core needs in
> a dedicated layer first, eliminating the redundant interfaces in the
> process (e.g. xnintr, xnapc). Next, only the pipeline-specific code
> would need be ported to Dovetail.
> 
> As an illustration of this, I started working on such a port a year ago
> [1] but did not finish it (I concluded that Cobalt would require more
> than a simple port to Dovetail in order to fix basic design issues). The
> upside of going this way is that you can get a precise picture of the
> dependencies between the core and the pipeline code, using drop-in
> replacements only when applicable, even questioning some aspects of the
> generic core implementation when it comes to interfacing with the host
> kernel.
> 
> [1] https://lab.xenomai.org/xenomai-rpm.git/log/?h=wip/dovetail
> 

An abstraction layer is obviously the next step after understanding all
the adaptation needs. Having that picture upfront, in all its details,
was your privilege so far. The whack-a-mole prototype was supposed to
develop that knowledge for more people.

Would have been nice to be reminded of this preexisting work earlier
this year, when I started the porting discussion. You shared it last
year in some thread as I just found again, but I likely forgot that fact.

Jan
-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux


