MIME-Version: 1.0
In-Reply-To: <534C4608.9090200@xenomai.org>
References: <CAPRPZsAmXEyH4wcMeGcWPB3B-3=04DoS=K2k-QbQ+DidPcptAg@mail.gmail.com>
 <534BD82E.6080205@xenomai.org>
 <CAPRPZsCkGj=n4LJeduM5MJM0UbAcjwg+5uZkNnAn9dSGwaKeoQ@mail.gmail.com>
 <534C4608.9090200@xenomai.org>
Date: Mon, 14 Apr 2014 23:14:30 +0200
Message-ID: <CAPRPZsDkrH5FOiCqwo8570x0zcg+dcAZ0CncF_02EwkuexR=aQ@mail.gmail.com>
From: Jeroen Van den Keybus <jeroen.vandenkeybus@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] Slow execution of RT task
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

> Maybe the clocksource is no longer the tsc? What does:
>
> cat /sys/devices/system/clocksource/clocksource0/current_clocksource
>
> say?

tsc

But I just discovered the reason of the increased execution times:
while looking for delays caused by the CPU accidentally entering C3
state, I turned on the I-pipe tracer and simply forgot to turn it back
off. I just learnt that the tracer causes an appreciable bit of
delay...

Kernel build time is now 2m27s and the times of the test program are now:

1397509817942908822:    -2317      134 T=   -2183 (0)
1397509818942908822:    -2307      129 T=   -2178 (0)
1397509819942908822:    -2306      129 T=   -2177 (0)

Sorry to have bothered you with this and thanks for your help.

Still, I do get these warnings in kernel/rcutree.c and, with the
tracer still on, the system at least locked up hard once while
modprobing xeno_native.

Thanks again,


Jeroen

