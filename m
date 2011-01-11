Message-ID: <4D2C4622.6040708@domain.hid>
Date: Tue, 11 Jan 2011 12:59:30 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <201101111223.46697.peter@domain.hid>
In-Reply-To: <201101111223.46697.peter@domain.hid>
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
>> - define your own signal and handle correctly both Xenomai and
>> libreadline signals in that handler.
> 
> So what I did to get it to work is this:
> 
> declare in my own files (a C++ program):
> extern "C"
> int xeno_sigwinch_handler(int sig, siginfo_t *si, void *ctxt);
> 
> -> this function is nowhere declared in a header

We can probably arrange that, we would have to put this declaration in a
header included in all the skin headers.

> Then write:
> void rl_sigwinch_handler(int sig, siginfo_t *si, void *ctxt) {
>         if (xeno_sigwinch_handler(sig, si, ctxt) == 0)
>             rl_resize_terminal();
> }
> 
> And when initializing readline:
> 
>         rl_catch_sigwinch = 0;
>         struct sigaction sa;
>         sa.sa_sigaction = &rl_sigwinch_handler;
>         sa.sa_flags = SA_SIGINFO;
>         sigaction(SIGWINCH, &sa, 0);
> 
> which works. I have guarded the xenomai-specific code with #if 
> CONFIG_XENO_VERSION_MAJOR == 2 && CONFIG_XENO_VERSION_MINOR >= 5
> stanzas. I'm not sure at which exact version this function was introduced.

This was introduced in 2.5.0. So, this is correct. In 2.4, each skin had
its own signal handler, and they ended up being chained if you used
several skins.

-- 
					    Gilles.

