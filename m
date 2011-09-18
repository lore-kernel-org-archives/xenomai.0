Message-ID: <4E76058F.8050609@domain.hid>
Date: Sun, 18 Sep 2011 16:51:59 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CABm7fFPcAjLu3_xVi+t8fCYy_VYKR6A7pgTF-WeHv4ifw9V5qA@mail.gmail.com>	<4E75ED9E.9000708@domain.hid>
	<CABm7fFP-zWkpqqmSVxuK-996LsW2xkG6g7L7SVHk2kcCnRpoSQ@mail.gmail.com>
In-Reply-To: <CABm7fFP-zWkpqqmSVxuK-996LsW2xkG6g7L7SVHk2kcCnRpoSQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Port to stmp3xxx (arm based)
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Bertold Van den Bergh <vandenbergh@domain.hid>
Cc: xenomai@xenomai.org

On 09/18/2011 04:43 PM, Bertold Van den Bergh wrote:
> Hello,
> 
> Thanks for the reply. The timer register has the following layout: bit
> 0-15: reload, bit 16-31: counter. Thats why I put 0xFFFF0000. Looking
> at the code this cannot work so I added an extra field to indicate the
> shift after applying the mask.

You should really upgrade your I-pipe tree to a more recent one, where
the support for tsc emulation was factored. You would add the new case
to the tsc implementations in kernel-space, and nowhere else. When you
are done, please send a patch.

> 
> Now the userspace latency test prorgam gives valid latencies, sadly
> it's still -1ms to 3ms latency.
> 
> How should I proceed troubleshooting this?
> Looking at the ipipe trace it looks the task is brought op quite fast
> after the interrupt fires so I think it is set at the wrong time, I'm
> going to look into this.

The I-pipe tracer has a trace point at the point where the timer was
supposed to tick.

-- 
                                                                Gilles.

