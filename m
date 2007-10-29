Message-ID: <2ff1a98a0710290240u3afed235gb51e16d3057c5ad@domain.hid>
Date: Mon, 29 Oct 2007 10:40:47 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <4725928C.7060900@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <47226B5E.2050303@domain.hid> <47227713.9020804@domain.hid>
	<4722F8BD.8010401@domain.hid> <47230D83.1030001@domain.hid>
	<4724CEFD.4010502@domain.hid> <4725928C.7060900@domain.hid>
Subject: Re: [Xenomai-core] I-pipe/i386 for 2.6.24-rc1 - x86/x86_64 merge to
	come
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

On 10/29/07, Jan Kiszka <jan.kiszka@domain.hid> wrote:
> Philippe Gerum wrote:
> > Jan Kiszka wrote:
> >  On the other
> >> hand, there is still the broken blackfin arch...
> >
> > And the x86_64 too - just enable AUDIT_SYSCALL. And we need the ARM
> > upgrade too.
>
> Can't follow you regarding CONFIG_AUDIT_SYSCALL. What else is required
> beyond simply enabling this .config switch? And is this tracing then
> only a x86_64 issue?

You need to install selinux packages. I have the problem with the
following packages installed on a fedora core:

libselinux-1.23.11-1.1
libselinux-1.23.11-1.1
libselinux-devel-1.23.11-1.1
selinux-policy-targeted-1.27.1-2.28

-- 
                                               Gilles Chanteperdrix

