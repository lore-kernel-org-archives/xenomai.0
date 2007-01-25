From: Jeff Weber <jweber@domain.hid>
Subject: Re: [Xenomai-help] isolating unwanted mode switch
Date: Thu, 25 Jan 2007 11:04:50 -0600
References: <200701231448.35285.jweber@domain.hid>
	<200701241152.21747.jweber@domain.hid>
	<1169722218.5028.21.camel@domain.hid>
In-Reply-To: <1169722218.5028.21.camel@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <200701251104.50567.jweber@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rpm@xenomai.org
Cc: Xenomai help <xenomai@xenomai.org>

A correction to my previous post on this problem: the memory in question wa=
s=20
previously allocated heap, that was apparently not yet paged in.  The point=
er=20
to the memory was in bss, so, at the time, I assumed the page fault memory=
=20
was in bss as well.  I have a "solution" which is working for now, to write=
=20
(zero out)  dynamically allocated memory before first use.  (The dynamic=20
allocation is after the mlockall() ).

My application is a legacy C++ program, which has an initialization phase:=
=20
where all RT tasks are created and all memory is allocated; and a run phase=
:=20
where the task T_WARNSW mode is enabled, to report unwanted modes switches.=
 =20
I am in the process of porting this application from Linux-2.4.27+rtai-3.1.=
0=20
to Linux-2.6.17.14+Xenomai-2.2.4.  (As a side note, it has now become=20
interesting to consider how and if page faults were affectinging the=20
Linux-2.4+RTAI version of this application.)

=46rom the discussions in this thread, there will always be a non-zero=20
probability that my application will still encounter future page faults. So=
=20
I've decided to enable T_WARNSW for the applicaion while under development,=
=20
but T_WARNSW will not be enabled for deployed applications.  Instead, I may=
=20
periodically parse /proc/xenomai/faults, and /proc/xenomai/stat .

	Jeff

On Thursday 25 January 2007 04:50, Philippe Gerum wrote:

> Gilles is working on a patch that solves a number of on-demand mapping
> issues initially observed on ARM and ppc, but generic enough to affect
> other archs; I'll merge it into the I-pipe 1.7 series for x86 in a near
> future.

