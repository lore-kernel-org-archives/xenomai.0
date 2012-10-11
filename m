From: Michael Pustylnik <MichaelPustylnik@ruggedcom.com>
Date: Thu, 11 Oct 2012 10:52:50 -0400
Message-ID: <990B36E792F1A4488D3E2B1C46FD62D6943CBA5BF8@corpmail2>
References: <990B36E792F1A4488D3E2B1C46FD62D6943CBA5BD8@corpmail2>
	<5075CEBD.7060709@xenomai.org>
In-Reply-To: <5075CEBD.7060709@xenomai.org>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai] Xenomai does not recognize changed system time
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

I am trying to follow your instructions and I am confused with the followin=
g.

- So far I have only used native skin, never POSIX skin

- clock_settime() and clock_gettime() reside in POSIX skin and there are Li=
nux equivalents in Linux libraries

- How should I link my application to make sure I invoke the Xenmomai's clo=
ck_settime() and clock_gettime() rather than the Linux native ones?


Michael Pustylnik, P.Eng.
Senior Software Engineer
RuggedCom Inc.
www.ruggedcom.com
300 Applewood Crescent
Concord, Ontario, L4K 5C7
Tel:  (905)482-4523
Fax: (905)856-1995

=20


-----Original Message-----
From: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org]=20
Sent: Wednesday, October 10, 2012 3:39 PM
To: Michael Pustylnik
Cc: xenomai@xenomai.org
Subject: Re: [Xenomai] Xenomai does not recognize changed system time

On 10/10/2012 09:36 PM, Michael Pustylnik wrote:

> I get system time from Xenomai by calling rt_timer_inquire() and examinin=
g the 'date' field of RT_TIMER_INFO.
> After system bootup, Xenomai reports the same system time as Linux (which=
 is expected). However, if I change Linux system time with the 'date' comma=
nd, Linux starts reporting the new time, while Xenomai keeps reporting the =
old time, as if the system time was not changed.
>=20
> Am I doing something wrong?


No.

> Is this the expected behavior?


Yes.

> How to get updated system time from Xenomai?


You have to update system time with the posix skin service clock_settime.
Or you can use CLOCK_HOST_REALTIME, but you can not use
CLOCK_HOST_REALTIME for anything else than simply getting linux time. It
can not be used as absolute dates for clock_nanosleep, or for creating
timers with timer_create.


--=20
                                                                Gilles.

No virus found in this incoming message.
Checked by AVG - www.avg.com=20
Version: 8.5.455 / Virus Database: 271.1.1/5290 - Release Date: 10/09/12 19=
:11:00

