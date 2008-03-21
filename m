Message-ID: <2ff1a98a0803210805o4e52cdddkf895c29b8045aba1@domain.hid>
Date: Fri, 21 Mar 2008 16:05:18 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <47E391790200000100192E6B@nwque-vm-gwia.criq.qc.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <47E391790200000100192E6B@nwque-vm-gwia.criq.qc.ca>
Subject: Re: [Xenomai-help]
	=?iso-8859-1?q?R=E9p=2E_=3A_Re=3A__trivial-periodi?=
	=?iso-8859-1?q?c?=
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Hubert Talbot <Hubert.Talbot@domain.hid>
Cc: xenomai@xenomai.org

On Fri, Mar 21, 2008 at 3:44 PM, Hubert Talbot <Hubert.Talbot@domain.hid> wrote:
>  >>> "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org> 21/03/08 >  Is it possible that something (like the ACPI processor module) is
>  stopping the tsc on your test box ? Can you try and boot with
>  idle=poll on the kernel command line ?

> Great!
>
>  Booting with idle=poll fixes the problem.
>
>  If I disabled ACPI completeley, would it fix the problem too?

As far as I know, only the ACPI processor module may stop the tsc.
Maybe you also have APM enabled ?

-- 
 Gilles

