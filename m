Message-ID: <4D2B4F2C.7060603@domain.hid>
Date: Mon, 10 Jan 2011 19:25:48 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <201101101718.58201.peter@domain.hid>
	<4D2B32BC.8080308@domain.hid>
	<201101101741.52481.peter@domain.hid>
In-Reply-To: <201101101741.52481.peter@domain.hid>
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
> On Monday 10 January 2011 17:24:28 Gilles Chanteperdrix wrote:
>> Peter Soetens wrote:
>>> Hi,
>>>
>>> A while ago, I was advised to call xeno_sigshadow_install() after a
>>> library installed a sigwinch signal handler (I believe this was Xenomai
>>> 2.5.1). Could it be that this is no longer supported in recent versions
>>> ? What is the correct way to avoid a segfault if an application
>>> installed a sigwinch handler after Xenomai did ?
>> I think we already answered that at the time, but if you install your
>> own sigwinch handler, you should:
>> - register it with the SA_SIGINFO flag
>> - call xeno_sigwinch_handler and consider that the signal is for the
>> application only if this function returns 0.
> 
> This is indeed in the API docs, but it's not an option since it's a third 
> party library (readline) doing this, it doesn't depend on or know Xenomai.

Actually, readline behaviour is highly configurable, and looking a bit
at its documentation, we find that its behaviour with regard to sigwinch
is configurable, see:
rl_catch_sigwinch
rl_resize_terminal

-- 
                                                                Gilles.

