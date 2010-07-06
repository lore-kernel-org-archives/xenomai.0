Message-ID: <4C338142.4070305@domain.hid>
Date: Tue, 06 Jul 2010 21:17:22 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <201003161329.32546.peter@domain.hid>	<4B9FB9AD.2040509@domain.hid>
	<201003162232.23352.peter@domain.hid>	<4BA0654D.5040602@domain.hid>
	<AANLkTim9LqZGROIz--poHWB4ikHWsvPJu2ClX_TanH88@domain.hid>
In-Reply-To: <AANLkTim9LqZGROIz--poHWB4ikHWsvPJu2ClX_TanH88@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] xeno_sigwinch_handler causes segfault
	with	readline
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Peter Soetens <peter@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>

Peter Soetens wrote:
> On Wed, Mar 17, 2010 at 7:14 AM, Gilles Chanteperdrix
> <gilles.chanteperdrix@xenomai.org> wrote:
>> Peter Soetens wrote:
>>> On Tuesday 16 March 2010 18:02:37 Gilles Chanteperdrix wrote:
>>>> Peter Soetens wrote:
>>>>> I'm testing with (don't shoot me)
>>>>> * 2.6.31.1-ipipe-2.4-07 #3 SMP
>>>>> * Xenomai 2.4.93 (please!)
>>>>>
>>>>> But a user reported with:
>>>>> * Kernel 2.6.32.7
>>>>> * Xenomai 2.5.1
>>>>>
>>>>> the same issue. When we first shadow the main thread and then call into
>>>>> readline code, we get segfaults, pointing to xeno_sigwinch_handler.
>>>>>
>>>>> According to docs, we need to be careful when installing a signal handler
>>>>> on winch after shadowing. Is this still the issue (I suppose so), or why
>>>>> don't we get a nice( that's relative) 'abort' explaining what to do
>>>>> instead of a segfault ?
>>>>>
>>>>> I'll delve into libreadline to see on how to override/disable the
>>>>> winching by readline, but I hope there is some standard solution, maybe
>>>>> by one of the Xenomai users.
>>>> We have an awful memory corruption issue with Xenomai 2.5.1, so please
>>>> upgrade to Xenomai 2.5 development head, it will be released as 2.5.2
>>>> this week-end, except maybe for some additions in analogy. Another
>>>> possibility is an issue with stack sizes, it may happen that libreadline
>>>> requires some huge stack sizes. We made some work to increase the
>>>> default stack size, but libreadline may need even more.
>>> I can at least confirm that when setting:
>>>   rl_catch_sigwinch = 0;
>>> before installing the readline signal handlers fixes this issue (but disables
>>> responding to terminal resizes).
>> Right, I am probably on the wrong track. If the application registers a
>> SIGWINCH handler, this handler must be registered with the SA_SIGINFO
>> flag, and call the xeno_sigwinch_handler function.
>>
>> Another solution is to call the function xeno_sigshadow_install(), right
>> after libreadline installs its handler.
> 
> This has been for a while, but the proposed xeno_sigshadow_install()
> solution is outdated, the function disappeared. The documentation
> proposes to forward the signal first to xenomai and then decide if it
> should be handled. What to do if the sigwinch handler is installed by
> a 3rd party app that I can't modify ?

Register your own handler later which forwards first the code to
xenomai, then to the handler registered by the 3rd party app.

-- 
					    Gilles.

