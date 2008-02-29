Message-ID: <2ff1a98a0802290958k3457d577j8e2ad01079612320@domain.hid>
Date: Fri, 29 Feb 2008 18:58:20 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <47C838A9.8040200@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <47C838A9.8040200@domain.hid>
Subject: Re: [Xenomai-help] rt_cond_wait doesn't timeout (xenomai 2.4.1)
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Anders Blomdell <anders.blomdell@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

On Fri, Feb 29, 2008 at 5:54 PM, Anders Blomdell
<anders.blomdell@domain.hid> wrote:
> Hi,
>
>  with xenomai 2.4.1 my call to:
>
>   rt_cond_wait(&cond, &mutex, 1000);
>
>  doesn't timeout (signalling works OK). Kernel version is 2.6.23.12, can it be
>  due to CONFIG_NO_HZ=y, or have I misunderstood something?

What is your system timer setting ? Are you running in periodic or
aperiodic mode ? If aperiodic, 1000 ticks means 1000 ns, that is 1us,
so rt_cond_wait should return instantaneously.

-- 
                                               Gilles Chanteperdrix

