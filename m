From: Andreas Glatz <AndreasGlatz@domain.hid>
Date: Fri, 14 May 2010 06:34:05 -0400
Message-ID: <245373446233674495BCA5CA2FC1EB17378D01593B@RCexchangeSVR1.ruggedcom.local>
References: <2319761F7FA0D1479BA77EC2E0A8E7BCE3D6E7@domain.hid>
In-Reply-To: <2319761F7FA0D1479BA77EC2E0A8E7BCE3D6E7@domain.hid>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Question about getting system time
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Abhijit Majumdar <abhijit.majumdar@domain.hid>, "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,

We had a similar problem. We solved it by compiling the native skin as a mo=
dule and loading it _after_ the kernel has been syncronized with the real-t=
ime clock chip.

Andreas


________________________________________
From: xenomai-help-bounces@domain.hid [xenomai-help-bounces@domain.hid] On Behalf=
 Of Abhijit Majumdar [abhijit.majumdar@domain.hid]
Sent: Thursday, May 13, 2010 6:14 PM
To: xenomai@xenomai.org
Subject: [Xenomai-help] Question about getting system time

Hi folks

I am facing a strange problem in getting system time.

My requirement:

 In a hard real time task I need to get the current system time and store i=
t in a structure. Later at some point of time a java application a windows =
system is supposed to convert it into user-readable date-time format. I am =
using rt_timer_tsc2ns(rt_timer_read()) to get the current time.

Problem:

However the java application prints a date in 1980 (I converted nanosec to =
millisec before using java API). I kind of expected rt_timer_tsc2ns to retu=
rn nanoseconds from 1st Jan 1970 because it is common for programming tools=
 and languages, although I must admit that I did not see that in the xenoma=
i API documentation.

Am I doing something wrong? Should I have to compile the kernel with some s=
pecific parameter?

Any help will be appreciated.

thanks
Abhijit


