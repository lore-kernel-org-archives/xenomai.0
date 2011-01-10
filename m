Message-ID: <4D2B6A91.5090702@domain.hid>
Date: Mon, 10 Jan 2011 21:22:41 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <201101101718.58201.peter@domain.hid>
	<201101101741.52481.peter@domain.hid>
	<4D2B4F2C.7060603@domain.hid>
	<201101102115.01996.peter@domain.hid>
In-Reply-To: <201101102115.01996.peter@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Correct use of xeno_sigshadow_install()
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Peter Soetens <peter@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

Peter Soetens wrote:
> On Monday 10 January 2011 19:25:48 Gilles Chanteperdrix wrote:
>> Peter Soetens wrote:
>>> On Monday 10 January 2011 17:24:28 Gilles Chanteperdrix wrote:
>>>> Peter Soetens wrote:
>>>>> Hi,
>>>>>
>>>>> A while ago, I was advised to call xeno_sigshadow_install() after a
>>>>> library installed a sigwinch signal handler (I believe this was Xenomai
>>>>> 2.5.1). Could it be that this is no longer supported in recent versions
>>>>> ? What is the correct way to avoid a segfault if an application
>>>>> installed a sigwinch handler after Xenomai did ?
>>>> I think we already answered that at the time, but if you install your
>>>> own sigwinch handler, you should:
>>>> - register it with the SA_SIGINFO flag
>>>> - call xeno_sigwinch_handler and consider that the signal is for the
>>>> application only if this function returns 0.
>>> This is indeed in the API docs, but it's not an option since it's a third
>>> party library (readline) doing this, it doesn't depend on or know
>>> Xenomai.
>> Actually, readline behaviour is highly configurable, and looking a bit
>> at its documentation, we find that its behaviour with regard to sigwinch
>> is configurable, see:
>> rl_catch_sigwinch
>> rl_resize_terminal
> 
> But we *want* to catch sigwinch/resize_terminal, since this happens quite 
> often. Without this signal the terminal width is not being communicated to the 
> readline library and it displays its columns in a too large or too small 
> width.
> 
> It's the terminal emulator giving us this signal, and it is meaningful to us. 
> It's Xenomai doing something fundamentally flawed, or I fundamentally 
> misunderstand it. 

Look at the documentation of rl_catch_sigwinch, rl_resize_terminal, they
have been made precisely, for your use-case. rl_catch_sigwinch will get
readline not to catch the signal.

Then you will register a signal handler for your application, which
calls, xeno_sigwinch_handler, and if that returns zero, calls
rl_resize_terminal.

> Why can't you register a signal handler, without interfering 
> with other handlers for the same signal ?

Well, signal handlers are a per-process global ressource, look at
sigaction documentation, this API is done this way, this is not
Xenomai's fault, not even Linux' fault, you are barking at the wrong
tree. That is precisely the reason why readline gives you access to
rl_catch_sigwinch, rl_resize_terminal, and Xenomai to xeno_sigwinch_handler.

-- 
                                                                Gilles.

