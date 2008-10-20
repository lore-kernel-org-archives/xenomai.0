Message-ID: <48FCF8D4.6030507@domain.hid>
Date: Mon, 20 Oct 2008 23:32:04 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <48FCDC52.1070507@domain.hid>
	<48FCE40C.1080100@domain.hid>	<48FCEB70.7030808@domain.hid>
	<48FCEC25.2040200@domain.hid>	<48FCED48.5050608@domain.hid>
	<48FCF14C.8050103@domain.hid> <48FCF2E2.8050809@domain.hid>
	<48FCF4FB.1040104@domain.hid> <48FCF74E.1090102@domain.hid>
	<48FCF86F.3030007@domain.hid>
In-Reply-To: <48FCF86F.3030007@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Warning when compiling trunk.
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Xenomai core <Xenomai-core@domain.hid>

Jan Kiszka wrote:
> Gilles Chanteperdrix wrote:
>> Jan Kiszka wrote:
>>> Gilles Chanteperdrix wrote:
>>>> Gilles Chanteperdrix wrote:
>>>>> Jan Kiszka wrote:
>>>>>> Gilles Chanteperdrix wrote:
>>>>>>> Gilles Chanteperdrix wrote:
>>>>>>>> Jan Kiszka wrote:
>>>>>>>>> Gilles Chanteperdrix wrote:
>>>>>>>>>> I get this warning when compiling trunk:
>>>>>>>>>>
>>>>>>>>>> checking for __thread... rm: cannot remove `conftest1.dir': Is a directory
>>>>>>>>>> yes
>>>>>>>>>>
>>>>>>>>> That simple, it's a typo in this line:
>>>>>>>>>
>>>>>>>>> http://www.rts.uni-hannover.de/xenomai/lxr/source/configure.in?v=SVN-trunk#394
>>>>>>>>>
>>>>>>>>> Also, that rm should be done outside the if block to play safe.
>>>>>>>> Ok. But once this is fixed, I get a segmentation fault with __thread on
>>>>>>>> ARM in rt_task_trampoline. I am currently testing the SIGWINCH thing,
>>>>>>>> and if __thread is disabled, there is no segfault.
>>>>>>> If a #ifdef 0 xeno_set_current, there is no segfault.
>>>>>>>
>>>>>> Interesting. What about removing the initial-exec attributes? Is
>>>>>> __thread otherwise know to work on your platform?
>>>>> Yes. This is a race condition, the real bug is, IMHO:
>>>>> 	__native_self = *iargs->task;
>>>>> When the segfault happens iargs->task is NULL. I suspect you are not
>>>>> supposed to use iargs after the __native_task_create syscall.
>>>> Yes, that was the problem.
>>> What did you change? Can you explain the why to me?
>> Because I guess iargs is no longer valid at this point. So, I saved the
>> task pointer and reused it.
>>
> 
> Sorry, makes no sense to me: *iargs is on the stack of the
> rt_task_create caller, and that one is not expected to proceed until we
> issue __xn_sys_barrier.

Well I am busy with the ARM FCSE now. Do you want my test case ?

-- 
					    Gilles.

