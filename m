Message-ID: <2ff1a98a0802290706s5af5aba9l2e6a451503bdd8cd@domain.hid>
Date: Fri, 29 Feb 2008 16:06:52 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <47C80D5C.2020409@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <47C71CF6.1040701@domain.hid>
	<2ff1a98a0802290127t33b4bfe6x29fc6f3391841ad5@domain.hid>
	<47C80D5C.2020409@domain.hid>
Subject: Re: [Xenomai-core] Script marking
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Roland Stigge <stigge@domain.hid>
Cc: xenomai@xenomai.org

On Fri, Feb 29, 2008 at 2:49 PM, Roland Stigge <stigge@domain.hid> wrote:
> Gilles Chanteperdrix wrote:
>  >>  Further, I updated the package in Debian with the suggested changes.
>  >
>  > We trust you, please send patches.
>
>  The attached patch (and the latest version of it) can also always be
>  found at the Debian developer's package page for Xenomai at
>  http://packages.qa.debian.org/x/xenomai.html .
>
>  It applies to the latest Xenomai release (currently 2.4.2), and assumes
>  that there is _no_ debian/ directory in the original source tree (as
>  discussed beforehand - Debian maintains the complete debian/* hierarchy
>  completely - for further questions just ask).

I see that xenomai packages depends on glibc version >= 2.7.1. Is this
dependency really needed ? Without this dependency it would be
possible to compile the Xenomai package for older versions of Debian.

-- 
                                               Gilles Chanteperdrix

