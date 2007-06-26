Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 26 Jun 2007 10:53:42 +0200
Message-ID: <0B45E93C5FF65740AEAE690BF3848B7A4AB14C@rennsmail04.eu.thmulti.com>
From: "Fillod Stephane" <stephane.fillod@domain.hid>
Subject: Re: [Xenomai-help] Xenomai and mlockall
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Xenomai-help@domain.hid

Philippe Gerum wrote:
> On Mon, 2007-06-25 at 15:00 +0200, Johan Borkhuis wrote:=20
>> I am trying to run my Xenomai application as non-root. I disabled=20
>> XENO_OPT_SECURITY_ACCESS to allow non-root users to run Xenomai=20
>> applications. However, this causes my application to exit with the
error:
[...]
>> Is there a way to "tweak" the CAP_IPC_LOCK capability of the system
or=20
>> the task so that I can run mlockall call, or is there a way to
disable=20
>> this check on Xenomai?
>
>No way to disable it, since doing so would basically make your system
>dysfunctional by risking page faults while not running over a regular
>Linux context (i.e. Xenomai's primary domain).

I think Johan was not asking to disable the mlockall, but to allow some
non-root user to be able to do it. He found his solution anyway, which
is worth an entry in the FAQ.

Since it is going to be a FAQ for those people in embedded business,
some
tricks to allow non-root operation of mlockall, SCHED_FIFO, etc., would
be=20
useful. For example, you may hack the commoncap in linux/security/,=20
or a better solution would be to rely on realtime-lsm[1][2], thanks to=20
the audio folks.

[1] http://sourceforge.net/projects/realtime-lsm/
[2] http://lwn.net/Articles/110346/


Best Regards,
--=20
Stephane

