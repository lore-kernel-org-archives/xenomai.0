MIME-Version: 1.0
In-Reply-To: <5357C92F.2060206@xenomai.org>
References: <CAPRPZsBD_5ufxFAhPCFqRf9YZSm1FhqfcmL+MTbhJ=1Sb7ED_g@mail.gmail.com>
 <CAPRPZsBsOmiaWPJmPR9RK0uv_BXbw_s43rarKOvVoGfN2gWZjQ@mail.gmail.com>
 <CAPRPZsCnAJH_-070SbSMB+Q_dQwf+FYfKpmp1wzwtz=zMA2bcA@mail.gmail.com>
 <5357C92F.2060206@xenomai.org>
Date: Wed, 23 Apr 2014 22:54:02 +0200
Message-ID: <CAPRPZsAvxx9XVB5MYi65m1FPaz2p7Rgh7+M4U357exJBbo0kHQ@mail.gmail.com>
From: Jeroen Van den Keybus <jeroen.vandenkeybus@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] Reading /proc/xenomai/stat causes high latencies
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, "xenomai@xenomai.org" <xenomai@xenomai.org>

> Do you get the same behaviour if you only enable the tracer after loading
> the xeno_native module?

Yes. but I just found out that the intel_idle driver option is causing
the stalls. Limiting to C1 state (using intel_idle.max_cstate=1)
apparently isn't cutting it and other nasty things must be happening
in this driver. After turning it off, the random stalling stopped.
Good.

Apart from that, I somehow managed to stop the high latencies from
occurring, I then saved the .config and then double-checked that (by
turning it off again) turning _on_ 'Run-time PM core functionality'
had solved the problem.

Surprisingly, the latencies are high again. But even with the stored
.config I have not been able to recreate the situation with tracer off
and normal latencies when reading xenomai/stat.


Jeroen.

