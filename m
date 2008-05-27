Message-ID: <2ff1a98a0805270636g51c0cdadt6fbd0cc0e324e4a0@domain.hid>
Date: Tue, 27 May 2008 15:36:13 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <483C0A76.8090406@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <480A4AF3.9010502@domain.hid> <4839907C.4000102@domain.hid>
	<18489.37401.679912.195018@domain.hid>
	<483AA731.8050404@domain.hid>
	<18491.4848.804078.354303@domain.hid>
	<483B29A6.2000209@domain.hid>
	<18491.14108.445958.567163@domain.hid>
	<483BCD9C.1090205@domain.hid>
	<2ff1a98a0805270537i940e806vd4f25f6cae72936b@domain.hid>
	<483C0A76.8090406@domain.hid>
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
To: Roland Stigge <stigge@domain.hid>
Cc: xenomai@xenomai.org

On Tue, May 27, 2008 at 3:19 PM, Roland Stigge <stigge@domain.hid> wrote:
> Hi,
>
> Gilles Chanteperdrix wrote:
>> What I criticize is patching without submitting patches upstream, or
>> without consulting upstream package maintainers, or making debian
>> patches hard to apply upstream.
>
> I both submitted to Xenomai upstream and provided an easy patch (not
> even assuming the stripped debian/*), you should be fully satisfied
> now... ;-)
>
> For the libssl case, it was basically the same, as I understand it. (I'm
> not involved into Debian's openssl packaging, though.)
>
>> For instance I saw  there was a bug with generating debian packages
>> for ARM. Instead of reporting this bug upstream, which, as the
>> maintainer of Xenomai ARM port, I could have helped to resolve, you
>> chose to resolve the bug silently [...]
>
> I just incorporated the patch by Riku Voipio for Debian #477720 which
> resolved the problem for Debian's ARM porters. (Further, I sent you the
> patch in a convenient way...)
>
> If you have further improvements in 2.4.4, fine. :-)

Ok. I have no excuse, it was even in the changelog if I did not want
to read the whole patch. But technically you did not announce the
2.4.3-7 patch on Xenomai mailing list :-)

> PS: I hope it doesn't look to the others like we are complaining about
> each other's work. So for the rest of xenomai-core developers: This is
> just mine and Gilles' way to say "thanks for your work" to each other. ;-)))

Yes, I should stress that I consider it as a great advance for the
Xenomai project to have a Debian package, and thank you for the
packaging hard work.

-- 
 Gilles

