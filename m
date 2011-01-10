From: Peter Soetens <peter@domain.hid>
Date: Mon, 10 Jan 2011 17:41:52 +0100
References: <201101101718.58201.peter@domain.hid>
	<4D2B32BC.8080308@domain.hid>
In-Reply-To: <4D2B32BC.8080308@domain.hid>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <201101101741.52481.peter@domain.hid>
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-help <xenomai@xenomai.org>

On Monday 10 January 2011 17:24:28 Gilles Chanteperdrix wrote:
> Peter Soetens wrote:
> > Hi,
> > 
> > A while ago, I was advised to call xeno_sigshadow_install() after a
> > library installed a sigwinch signal handler (I believe this was Xenomai
> > 2.5.1). Could it be that this is no longer supported in recent versions
> > ? What is the correct way to avoid a segfault if an application
> > installed a sigwinch handler after Xenomai did ?
> 
> I think we already answered that at the time, but if you install your
> own sigwinch handler, you should:
> - register it with the SA_SIGINFO flag
> - call xeno_sigwinch_handler and consider that the signal is for the
> application only if this function returns 0.

This is indeed in the API docs, but it's not an option since it's a third 
party library (readline) doing this, it doesn't depend on or know Xenomai.

> 
> If you can not do that, then redefine SIGSHADOW in
> include/asm-generic/syscall.h to a different value, and recompile both
> Xenomai user-space and kernel-space support. Note however that when
> starting applications in gdb you will then have to type:
> 
> handle <the_new_signal> pass nostop print
> 
> If you want to be able to debug Xenomai applications.

Hmm....

So defining the xeno_sigshadow_install() function ourselves (since it's not in 
any Xenomai header) and calling it after the readline signal handlers were 
installed is not gonna work ?

Peter

