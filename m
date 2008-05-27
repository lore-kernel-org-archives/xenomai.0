Message-ID: <483C0A76.8090406@domain.hid>
Date: Tue, 27 May 2008 15:19:50 +0200
From: Roland Stigge <stigge@domain.hid>
MIME-Version: 1.0
References: <480A4AF3.9010502@domain.hid>	
	<18489.35854.502315.832894@domain.hid>	
	<4839907C.4000102@domain.hid>	
	<18489.37401.679912.195018@domain.hid>	
	<483AA731.8050404@domain.hid>	
	<18491.4848.804078.354303@domain.hid>	
	<483B29A6.2000209@domain.hid>	
	<18491.14108.445958.567163@domain.hid>	
	<483BCD9C.1090205@domain.hid>
	<2ff1a98a0805270537i940e806vd4f25f6cae72936b@domain.hid>
In-Reply-To: <2ff1a98a0805270537i940e806vd4f25f6cae72936b@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Debian package xenomai-2.4.3-4 available
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
> What I criticize is patching without submitting patches upstream, or
> without consulting upstream package maintainers, or making debian
> patches hard to apply upstream.

I both submitted to Xenomai upstream and provided an easy patch (not
even assuming the stripped debian/*), you should be fully satisfied
now... ;-)

For the libssl case, it was basically the same, as I understand it. (I'm
not involved into Debian's openssl packaging, though.)

> For instance I saw  there was a bug with generating debian packages
> for ARM. Instead of reporting this bug upstream, which, as the
> maintainer of Xenomai ARM port, I could have helped to resolve, you
> chose to resolve the bug silently [...]

I just incorporated the patch by Riku Voipio for Debian #477720 which
resolved the problem for Debian's ARM porters. (Further, I sent you the
patch in a convenient way...)

If you have further improvements in 2.4.4, fine. :-)

bye,
  Roland

PS: I hope it doesn't look to the others like we are complaining about
each other's work. So for the rest of xenomai-core developers: This is
just mine and Gilles' way to say "thanks for your work" to each other. ;-)))

