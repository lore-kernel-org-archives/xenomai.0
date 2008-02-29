Message-ID: <47C832E7.50706@domain.hid>
Date: Fri, 29 Feb 2008 17:29:27 +0100
From: Roland Stigge <stigge@domain.hid>
MIME-Version: 1.0
References: <47C71CF6.1040701@domain.hid>	
	<2ff1a98a0802290127t33b4bfe6x29fc6f3391841ad5@domain.hid>	
	<47C80D5C.2020409@domain.hid>
	<2ff1a98a0802290706s5af5aba9l2e6a451503bdd8cd@domain.hid>
In-Reply-To: <2ff1a98a0802290706s5af5aba9l2e6a451503bdd8cd@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Hi,

Gilles Chanteperdrix wrote:
> I see that xenomai packages depends on glibc version >= 2.7.1. Is this
> dependency really needed ? Without this dependency it would be
> possible to compile the Xenomai package for older versions of Debian.

This is an automatically generated dependency at package built time
_only_ for Debian sid (to be released later), and only for the binary
package.

If you build the package for yourself, or in another Debian environment
(an already released version, e.g. for backporting?), the dependency
would look different. Theoretically, it could even be sth. else than
glibc. ;-O

The versioned dependency is for safety reasons, not always really
necessary, but provided be default; taken from the actual build
environment...

bye,
  Roland

