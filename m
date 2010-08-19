Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Aug 2010 12:05:26 -0500
Message-ID: <181804936ABC2349BE503168465576460FB0A22E@exchserver.basler.com>
In-Reply-To: <1282197537.1730.411.camel@domain.hid>
References: <181804936ABC2349BE503168465576460F9E6D9C@exchserver.basler.com>	 
	<181804936ABC2349BE503168465576460F9E6DA5@domain.hid>	 
	<4C66939A.1060509@domain.hid> <4C6697F8.1090409@domain.hid>	 
	<181804936ABC2349BE503168465576460FA508FF@exchserver.basler.com>	 
	<181804936ABC2349BE503168465576460FAB4A0C@exchserver.basler.com> 
	<1282197537.1730.411.camel@domain.hid>
From: "Steve Deiters" <SteveDeiters@domain.hid>
Subject: Re: [Xenomai-help] Page fault in real time task causes lockup
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

> Make sure to have CONFIG_IPIPE_TRACE_VMALLOC enabled. You may=20
> also want to check whether disabling CONFIG_IPIPE_TRACE_IRQSOFF helps.
>=20
> --
> Philippe.
>=20
>=20

I got the tracer working.  It was crashing when using insmod to insert=
 a
module.  I recompiled the module and it stopped crashing.  Should I have
to recompile the kernel modules after I enable the tracing?

