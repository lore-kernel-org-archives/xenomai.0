Message-ID: <492C112B.50403@domain.hid>
Date: Tue, 25 Nov 2008 15:52:27 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <492C108B.1090909@domain.hid>
In-Reply-To: <492C108B.1090909@domain.hid>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] SMP issues
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: =?ISO-8859-1?Q?C=E9dric_Schaffter?= <cedric.schaffter@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

C=E9dric Schaffter wrote:
> But the problem is that I get same results in both case... I thought=20
> tasks were automatically dispatched between
> cores or cpu. Did I forget something?

Linux does that. With xenomai, tasks never migrate, choosing what task
runs on what processor is part of the design of your application.
Migrations kill determinism.

--=20
                                                 Gilles.

