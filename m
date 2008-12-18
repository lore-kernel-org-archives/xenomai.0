Message-ID: <494A3AFD.3000905@domain.hid>
Date: Thu, 18 Dec 2008 12:58:53 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <20081218111539.501A51C066@domain.hid>
In-Reply-To: <20081218111539.501A51C066@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Window Resize issue
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: stefano.franzoni@domain.hid
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

stefano.franzoni@domain.hid wrote:
> Dear experts
> 
> we have 2 systems with Ubuntu Linux 2.6.25.11 and Xenomai 2.4.4.
> 
> One has an Intel(R) Pentium(R) M processor 1.73GHz and the other one has
> Pentium III (Coppermine) 1GHz.
> The Xenomai installation seems to be ok and also native application tests
> give right results.
> 
> The issue, on both the systems, is that if I run, for example,
> trivial-periodic sample in a windows and I resize the window the rt task
> aborts and the application exits.
> 
> Any suggestion?

When resizing a terminal, the SIGWINCH signal is sent to the running
application. Unfortunately, SIGWINCH is also used internally by Xenomai.
A simple workaround is to recompile Xenomai to use another signal by
replacing the define in asm-generic/syscall.h. However, your choices are
limited if you want a signal that does not interfere with gdb.

-- 
					    Gilles.

