Message-ID: <4D2B38BD.2050708@domain.hid>
Date: Mon, 10 Jan 2011 17:50:05 +0100
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
> 
>> If you can not do that, then redefine SIGSHADOW in
>> include/asm-generic/syscall.h to a different value, and recompile both
>> Xenomai user-space and kernel-space support. Note however that when
>> starting applications in gdb you will then have to type:
>>
>> handle <the_new_signal> pass nostop print
>>
>> If you want to be able to debug Xenomai applications.
> 
> Hmm....
> 
> So defining the xeno_sigshadow_install() function ourselves (since it's not in 
> any Xenomai header) and calling it after the readline signal handlers were 
> installed is not gonna work ?

The thing is that xeno_sigshadow_installi is an internal function,
particularily, it is not thread safe. The exported function is
xeno_sigshadow_install_once, but it will not do anything the second time
it gets called.

If you take care of this thread-safety issue, calling
xeno_sigshadow_install should be OK, since it just installs
xeno_sigshadow_handler as a handler for SIGSHADOW, calling
xeno_sigwinch_handler, then the handler your application registered
before. All this code is relatively simple, and you will find it in
src/skins/common/sigshadow.c

Now, I suspect the issue you have is something else, so, could you post
the faulting code, reduced to a simple self-contained test case?

-- 
                                                                Gilles.

