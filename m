MIME-Version: 1.0
In-Reply-To: <4F80C10E.1000804@domain.hid>
References: <CAM1yFZ9eQND3KX-1D1zL4TxcUTSFaw7k4Xd_nuN_6ByGRCRKYA@mail.gmail.com>
	<4F80C10E.1000804@domain.hid>
Date: Mon, 9 Apr 2012 16:41:54 +0530
Message-ID: <CAM1yFZ_u0DzFNTe1zM2bOjB3ZwwKKgvRoS8U2=yLmv_3gPOt+A@mail.gmail.com>
From: Anisha Kaul <born.rebel.83@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai-help] Disadvantages of preempt_rt
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
Cc: xenomai@xenomai.org

> I think you are misunderstanding what preempt_rt is, preempt_rt does
> not preempt linux, preempt_rt is simply linux modified, when a linux
> kernel patched with preempt_rt runs, nothing else than linux runs, so
> nothing preempts the whole linux. This is achieved by means which have
> a global overhead on the whole system. The exact means are described on
> the rt wiki FAQ:
> https://rt.wiki.kernel.org/articles/f/r/e/Frequently_Asked_Questions_7407.html
>
> Note the answer to FAQ 3, which explains that improving latencies is a
> trade off, and means degrading the average performances of the system.
> That is the overhead we are talking about.


Thanks much for the hints.

What I have understood now is:
CONFIG_PREEMPT_RT patch is bound to cause a reduction in the overall
throughput of the system
***because there will be several context switches and also the lower
priority tasks won't be getting much a chance to get through***.

The reason I have understood is quoted within  ***.
Is this all correct or I am still missing a point?

-Anisha

