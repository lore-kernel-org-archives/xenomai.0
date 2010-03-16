Message-ID: <4B9FB9AD.2040509@domain.hid>
Date: Tue, 16 Mar 2010 18:02:37 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <201003161329.32546.peter@domain.hid>
In-Reply-To: <201003161329.32546.peter@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] xeno_sigwinch_handler causes segfault with
	readline
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
Cc: xenomai-help <xenomai@xenomai.org>

Peter Soetens wrote:
> I'm testing with (don't shoot me)
> * 2.6.31.1-ipipe-2.4-07 #3 SMP
> * Xenomai 2.4.93 (please!)
> 
> But a user reported with:
> * Kernel 2.6.32.7
> * Xenomai 2.5.1 
> 
> the same issue. When we first shadow the main thread and then call into 
> readline code, we get segfaults, pointing to xeno_sigwinch_handler.
> 
> According to docs, we need to be careful when installing a signal handler on 
> winch after shadowing. Is this still the issue (I suppose so), or why don't we 
> get a nice( that's relative) 'abort' explaining what to do instead of a 
> segfault ? 
> 
> I'll delve into libreadline to see on how to override/disable the winching by 
> readline, but I hope there is some standard solution, maybe by one of the 
> Xenomai users.

We have an awful memory corruption issue with Xenomai 2.5.1, so please
upgrade to Xenomai 2.5 development head, it will be released as 2.5.2
this week-end, except maybe for some additions in analogy. Another
possibility is an issue with stack sizes, it may happen that libreadline
requires some huge stack sizes. We made some work to increase the
default stack size, but libreadline may need even more.

> 
> Cheers,
> Peter
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
> 


-- 
Gilles Chanteperdrix, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com

