Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Jan 2009 12:43:15 -0700
Message-ID: <51CAD0CE1504444DBE77CBBE51A0135D5908A4@domain.hid>
In-Reply-To: <497A1963.8030902@domain.hid>
References: <51CAD0CE1504444DBE77CBBE51A0135D5908A3@domain.hid>
	<497A1963.8030902@domain.hid>
From: "Steven Seeger" <sseeger@domain.hid>
Subject: Re: [Xenomai-help] shadow task and rt_task_self()
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Gilles, the problem is very simple. The initial task has self->opaque
set to XN_NO_HANDLE. After you shadow that task, rt_task_self() still
returns NULL.

This is either an oversight or you aren't supposed to shadow the initial
task?

Thanks,
Steven


> -----Original Message-----
> From: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org]
> Sent: Friday, January 23, 2009 12:24 PM
> To: Steven Seeger
> Cc: xenomai@xenomai.org
> Subject: Re: [Xenomai-help] shadow task and rt_task_self()
>=20
> Steven Seeger wrote:
> > Using the latest xenomai we seem to always get back NULL from a
> shadow
> > task using rt_task_self(). We used to get something valid with
r3415.
> > Any idea?
>=20
> Please send us a little test program that we can run to observe the
> issue. And tell us which branch has the problem trunk or v2.4.x?
>=20
> --
> 					    Gilles.

