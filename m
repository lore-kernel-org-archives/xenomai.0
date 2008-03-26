Message-Id: <47EA61620200000100192F21@domain.hid>
Date: Wed, 26 Mar 2008 14:44:50 -0400
From: "Hubert Talbot" <Hubert.Talbot@domain.hid>
References: <47E391790200000100192E6B@nwque-vm-gwia.criq.qc.ca>
	<2ff1a98a0803210805o4e52cdddkf895c29b8045aba1@domain.hid>
In-Reply-To: <2ff1a98a0803210805o4e52cdddkf895c29b8045aba1@domain.hid>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Subject: Re: [Xenomai-help]
 =?iso-8859-15?q?R=E9p=2E_=3A_Re=3A__trivial-period?=
 =?iso-8859-15?q?ic?=
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

There is no APM item in menuconfig for x86_64.

>>> "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org> 2008-03-21 =
11:05:18 >>>
On Fri, Mar 21, 2008 at 3:44 PM, Hubert Talbot <Hubert.Talbot@domain.hid> =
wrote:
>  >>> "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org> 21/03/08 >  =
Is it possible that something (like the ACPI processor module) is
>  stopping the tsc on your test box ? Can you try and boot with
>  idle=3Dpoll on the kernel command line ?

> Great!
>
>  Booting with idle=3Dpoll fixes the problem.
>
>  If I disabled ACPI completeley, would it fix the problem too?

As far as I know, only the ACPI processor module may stop the tsc.
Maybe you also have APM enabled ?

--=20
 Gilles


