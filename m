From: Umair Ali <ali.umair@tut.fi>
Date: Thu, 10 Dec 2015 17:25:41 +0000
Message-ID: <2396B4D2166B62479FBBE370D4A7C1F30A710FEB@mb2010-1.intra.tut.fi>
References: <2396B4D2166B62479FBBE370D4A7C1F30A70DB46@mb2010-1.intra.tut.fi>
 <20151208201331.GA3667@hermes.click-hack.org>
 <2396B4D2166B62479FBBE370D4A7C1F30A70DC03@mb2010-1.intra.tut.fi>,
 <20151210150110.GA20328@hermes.click-hack.org>
In-Reply-To: <20151210150110.GA20328@hermes.click-hack.org>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai] Loose determinism when reading pcap and sending as
 raw ethernet packets
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hello,=0A=
=0A=
> >=0A=
> >  what you observe is the jitter, you can measure the timer=0A=
> interrupt jitter with the "latency" test, but I bet that maybe the=0A=
> latency may be higher than 5us;=0A=
> - if you really really need to reduce the jitter, then using kernel=0A=
> timers instead of sleeping in a user-space thread is recommended,=0A=
>=0A=
> Yes, you are right that what i have observed is the jitter. I have=0A=
> gone through the links which you have provided me in the last=0A=
> email. I am building my application using POSIX skin. In the=0A=
> links, they have used the rtdm_timer_start(). Now my question is=0A=
> that can i use the rtdm functions in the application compiling=0A=
> with posix skin, if yes then how. Do i have to change the skin for=0A=
> comilation in order to use the rtdm functions. Please refer me=0A=
> some guide for using the Xenomai Kernel timers with posix skin in=0A=
> order to avoid the jitter. Last thing do i need to made a kernel=0A=
> module in order to use the kernel timers. I am confused. Please=0A=
> guide me.=0A=
=0A=
>If you want to use kernel-space, you need to write a driver, running=0A=
in kernel spaces, and drivers use the RTDM API. The POSIX API is for=0A=
the application.=0A=
=0A=
As i need to send raw Ethernet packets therefore i am using  rtnet driver f=
or this purpose. Do you mean that i have to write my own driver for etherne=
t card.  Or should i have to write an rtdm driver that uses rtnet drivers f=
or sending the raw ethernet. Or is there a way i can change the rtnet drive=
rs according to my need. =0A=
=0A=
Thanks & BR=0A=
ali=0A=
________________________________________=0A=
From: Gilles Chanteperdrix [gilles.chanteperdrix@xenomai.org]=0A=
Sent: Thursday, December 10, 2015 5:01 PM=0A=
To: Umair Ali=0A=
Cc: xenomai@xenomai.org=0A=
Subject: Re: [Xenomai] Loose determinism when reading pcap and sending as r=
aw ethernet packets=0A=
=0A=
On Thu, Dec 10, 2015 at 01:20:47PM +0000, Umair Ali wrote:=0A=
> Hi Gilles,=0A=
=0A=
Hi,=0A=
=0A=
>=0A=
> Thanks for understanding my problem.=0A=
>=0A=
> >- for a program to run in primary mode only, pthread_setschedparam=0A=
> should be called with a priority higher than 1 for the SCHED_FIFO=0A=
> (or SCHED_RR) policy;=0A=
>=0A=
> I have been doing the same already but i did not copy that part of code i=
n the email.=0A=
>=0A=
> >- when you call a function which returns a value, like send or=0A=
> nanosleep, you should always check the return value for errors;=0A=
> - if you want to send a message on average every 5us then=0A=
> nanosleep(5us) is not what you should be using, you should be using=0A=
> clock_nanosleep with an absolute date, or the easier but less=0A=
> portable timerfd;=0A=
>=0A=
> I have used the clock_nanosleep with absolute time, but i could=0A=
> not find the absolute date. With clock_nanosleep i have found the=0A=
> same problem as described in the last email.=0A=
=0A=
You compute the next absolute date. But the point is to add 5us to=0A=
the absolute date, instead of using now + 5us, so that the packets=0A=
are really sent every 5us on average. This should not solve the=0A=
problem you have, only ensure that the messages are sent every 5us=0A=
on average.=0A=
=0A=
> I have looked the=0A=
> file timerfd.h. What i have understand is that by using timerfd i=0A=
> will create the dedicated timer with unique ID and then use the ID=0A=
> to get the time by using timerfd_gettime(). The time is added with=0A=
> amount of delay and passed to clock_nanosleep() function to=0A=
> achieve the required sleep time period. Am i doing it right with=0A=
> timerfd?=0A=
=0A=
With timerfd, you would set up the timer with timerfd_settime() to=0A=
tick every 5us, then the read() system call to wait for the timer=0A=
next expiration.=0A=
=0A=
>=0A=
> >  what you observe is the jitter, you can measure the timer=0A=
> interrupt jitter with the "latency" test, but I bet that maybe the=0A=
> latency may be higher than 5us;=0A=
> - if you really really need to reduce the jitter, then using kernel=0A=
> timers instead of sleeping in a user-space thread is recommended,=0A=
>=0A=
> Yes, you are right that what i have observed is the jitter. I have=0A=
> gone through the links which you have provided me in the last=0A=
> email. I am building my application using POSIX skin. In the=0A=
> links, they have used the rtdm_timer_start(). Now my question is=0A=
> that can i use the rtdm functions in the application compiling=0A=
> with posix skin, if yes then how. Do i have to change the skin for=0A=
> comilation in order to use the rtdm functions. Please refer me=0A=
> some guide for using the Xenomai Kernel timers with posix skin in=0A=
> order to avoid the jitter. Last thing do i need to made a kernel=0A=
> module in order to use the kernel timers. I am confused. Please=0A=
> guide me.=0A=
=0A=
If you want to use kernel-space, you need to write a driver, running=0A=
in kernel spaces, and drivers use the RTDM API. The POSIX API is for=0A=
the application.=0A=
=0A=
--=0A=
                                            Gilles.=0A=
https://click-hack.org=0A=

