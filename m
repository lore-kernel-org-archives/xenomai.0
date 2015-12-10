From: Umair Ali <ali.umair@tut.fi>
Date: Thu, 10 Dec 2015 13:20:47 +0000
Message-ID: <2396B4D2166B62479FBBE370D4A7C1F30A70DC03@mb2010-1.intra.tut.fi>
References: <2396B4D2166B62479FBBE370D4A7C1F30A70DB46@mb2010-1.intra.tut.fi>,
 <20151208201331.GA3667@hermes.click-hack.org>
In-Reply-To: <20151208201331.GA3667@hermes.click-hack.org>
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

Hi Gilles,=0A=
=0A=
Thanks for understanding my problem.=0A=
=0A=
>- for a program to run in primary mode only, pthread_setschedparam=0A=
should be called with a priority higher than 1 for the SCHED_FIFO=0A=
(or SCHED_RR) policy;=0A=
=0A=
I have been doing the same already but i did not copy that part of code in =
the email.=0A=
=0A=
>- when you call a function which returns a value, like send or=0A=
nanosleep, you should always check the return value for errors;=0A=
- if you want to send a message on average every 5us then=0A=
nanosleep(5us) is not what you should be using, you should be using=0A=
clock_nanosleep with an absolute date, or the easier but less=0A=
portable timerfd;=0A=
=0A=
I have used the clock_nanosleep with absolute time, but i could not find th=
e absolute date. With clock_nanosleep i have found the same problem as desc=
ribed in the last email.  I have looked the file timerfd.h. What i have und=
erstand is that by using timerfd i will create the dedicated timer with uni=
que ID and then use the ID to get the time by using timerfd_gettime(). The =
time is added with amount of delay and passed to clock_nanosleep() function=
 to achieve the required sleep time period. Am i doing it right with timerf=
d?=0A=
=0A=
>  what you observe is the jitter, you can measure the timer=0A=
interrupt jitter with the "latency" test, but I bet that maybe the=0A=
latency may be higher than 5us;=0A=
- if you really really need to reduce the jitter, then using kernel=0A=
timers instead of sleeping in a user-space thread is recommended,=0A=
=0A=
Yes, you are right that what i have observed is the jitter. I have gone thr=
ough the links which you have provided me in the last email.  I am building=
 my application using POSIX skin. In the links, they have used the rtdm_tim=
er_start(). Now my question is that can i use the rtdm functions in the app=
lication compiling with posix skin, if yes then how. Do i have to change th=
e skin for comilation in order to use the rtdm functions. Please refer me s=
ome guide for using the Xenomai Kernel  timers with posix skin in order to =
avoid the jitter. Last thing do i need to made a kernel module in order to =
use the kernel timers. I am confused. Please guide me.=0A=
=0A=
Thanks & BR=0A=
Ali=0A=
________________________________________=0A=
From: Gilles Chanteperdrix [gilles.chanteperdrix@xenomai.org]=0A=
Sent: Tuesday, December 08, 2015 10:13 PM=0A=
To: Umair Ali=0A=
Cc: xenomai@xenomai.org=0A=
Subject: Re: [Xenomai] Loose determinism when reading pcap and sending as r=
aw ethernet packets=0A=
=0A=
On Tue, Dec 08, 2015 at 05:25:21PM +0000, Umair Ali wrote:=0A=
> Hi there,=0A=
>=0A=
> I am reading the pcap file using the following technique:=0A=
> "=0A=
> mlockall(MCL_CURRENT|MCL_FUTURE);=0A=
> fd =3D open (file.pcap, O_RDONLY);=0A=
> status =3D fstat (fd, & s);=0A=
> size =3D s.st_size;=0A=
>  /* Memory-map the file. */=0A=
>  mapped =3D mmap (0, size, PROT_READ, MAP_PRIVATE, fd, 0);"=0A=
>=0A=
>=0A=
> Then i have the pcap file in mapped variable in the form of chracters (he=
x numbers). I read packet by packet and send them as raw packet over the ne=
twork with following code:=0A=
> "struct timespec ts;=0A=
> ts.tv_sec =3D 0;=0A=
> ts.tv_nsec =3D 5000;=0A=
> j=3D24;=0A=
>=0A=
>  while (j < size){=0A=
>          i =3D (unsigned char) mapped[j + 8];=0A=
>          sendto(sock, &mapped[j+16], i, 0,(struct sockaddr *)&peer, sizeo=
f(peer));=0A=
>          nanosleep(&ts, NULL);=0A=
>           j =3D j+i+16;=0A=
> }=0A=
> "=0A=
>=0A=
> When i run the program and receive the packets on the receiver=0A=
> then i have observed that behaviour of sending raw packets is not=0A=
> constant. Sometimes nanosleep finish little late or quickly.=0A=
=0A=
There are several problems with this program:=0A=
- for a program to run in primary mode only, pthread_setschedparam=0A=
should be called with a priority higher than 1 for the SCHED_FIFO=0A=
(or SCHED_RR) policy;=0A=
- when you call a function which returns a value, like send or=0A=
nanosleep, you should always check the return value for errors;=0A=
- if you want to send a message on average every 5us then=0A=
nanosleep(5us) is not what you should be using, you should be using=0A=
clock_nanosleep with an absolute date, or the easier but less=0A=
portable timerfd;=0A=
- what you observe is the jitter, you can measure the timer=0A=
interrupt jitter with the "latency" test, but I bet that maybe the=0A=
latency may be higher than 5us;=0A=
- if you really really need to reduce the jitter, then using kernel=0A=
timers instead of sleeping in a user-space thread is recommended,=0A=
see:=0A=
http://letsmakerobots.com/node/28812=0A=
http://letsmakerobots.com/node/32347=0A=
=0A=
--=0A=
                                            Gilles.=0A=
https://click-hack.org=0A=

