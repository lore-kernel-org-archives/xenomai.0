Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Jan 2009 07:55:53 -0700
Message-ID: <51CAD0CE1504444DBE77CBBE51A0135D533FB6@domain.hid>
In-Reply-To: <4975E491.1040506@domain.hid>
References: <51CAD0CE1504444DBE77CBBE51A0135D533F9A@slcmail.slc.mew.int>
	<49757B25.8020500@domain.hid>
	<51CAD0CE1504444DBE77CBBE51A0135D533FB0@domain.hid>
	<4975E491.1040506@domain.hid>
From: "Steven Seeger" <sseeger@domain.hid>
Subject: Re: [Xenomai-help] fpu issue
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

I do not have fxsr support. I noticed that instruction being used and
didn't find it in my datasheet. I guess my question is you want me to
dump the fpu state before I initialize the volatile doubles. However, I
don't have a saved state at that point. What exactly do I pass in? Or do
you want me to save and then dump?

Thanks,
Steven

> -----Original Message-----
> From: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org]
> Sent: Tuesday, January 20, 2009 7:50 AM
> To: Steven Seeger
> Cc: xenomai@xenomai.org
> Subject: Re: [Xenomai-help] fpu issue
>=20
> Steven Seeger wrote:
> > I can do that. I have to be careful where I use printk, though. I
> > noticed my board freezes if I try to do a printk in
> > __xnpod_fault_init_fpu() so that makes it harder. I am not exactly
> sure
> > what to look for because I've never done any assembler with the 387.
> Any
> > pointers would be helpful!
>=20
> You should not need any assembler at all. The header I have sent you
> implements two functions save_fp to save the fp environment, and
> dump_fp
> to dump a saved fp environment. If your cpu has no fxsr support (which
> you can check in /proc/cpuinfo), you should use old_save_fp and
> dump_old_fp instead.
>=20
> --
>                                                  Gilles.

