Message-ID: <2ff1a98a0805270537i940e806vd4f25f6cae72936b@domain.hid>
Date: Tue, 27 May 2008 14:37:08 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <483BCD9C.1090205@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <480A4AF3.9010502@domain.hid>
	<18489.35854.502315.832894@domain.hid>
	<4839907C.4000102@domain.hid>
	<18489.37401.679912.195018@domain.hid>
	<483AA731.8050404@domain.hid>
	<18491.4848.804078.354303@domain.hid>
	<483B29A6.2000209@domain.hid>
	<18491.14108.445958.567163@domain.hid>
	<483BCD9C.1090205@domain.hid>
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

On Tue, May 27, 2008 at 11:00 AM, Roland Stigge <stigge@domain.hid> wrote:
> Hi,
>
> Gilles Chanteperdrix wrote:
>> the way Debian maintained a patch to the ssh package is the
>> reason why a bug could remain unnoticed during two years in Debian
>> distributions, including so-called "stable" distributions. So, maybe it
>> is time for a change.
>
> First, it doesn't matter most how you maintain a patch. Most important
> is that sufficient code review is done, which unfortunately didn't
> happen in the libssl case.
>
> Second, the actual libssl patch in .diff.gz was the following:
>
> =======================================================================
> diff -u openssl-0.9.8g/crypto/rand/md_rand.c
> openssl-0.9.8g/crypto/rand/md_rand.c
> --- openssl-0.9.8g/crypto/rand/md_rand.c
> +++ openssl-0.9.8g/crypto/rand/md_rand.c
> @@ -271,7 +271,10 @@
>                else
>                        MD_Update(&m,&(state[st_idx]),j);
>
> +/*
> + * Don't add uninitialised data.
>                MD_Update(&m,buf,j);
> +*/
>                MD_Update(&m,(unsigned char *)&(md_c[0]),sizeof(md_c));
>                MD_Final(&m,local_md);
>                md_c[1]++;
> =======================================================================
>
> I.e. quite clear in my opinion. It wouldn't be if Debian wouldn't ship
> .diff.gz separately. (The above patch was actually reported upstream and
> there was no objection.)
>
> Third, the above case is different from our case: While I consider
> debian/* as Debian specific, the above patch was not Debian specific (it
> was actually introduced to ease valgrind usage). Therefore, I even
> consider the libssl patch style (not the semantics! :-) ) above as good;
> but patching debian/* in Debian's diff.gz as bad.
>
> Fourth, you are proposing the same patching technique as above (which
> you criticize as not appropriate).

What I criticize is patching without submitting patches upstream, or
without consulting upstream package maintainers, or making debian
patches hard to apply upstream.

For instance I saw  there was a bug with generating debian packages
for ARM. Instead of reporting this bug upstream, which, as the
maintainer of Xenomai ARM port, I could have helped to resolve, you
chose to resolve the bug silently, but unfortunately chose a solution
which will not work with the imx21 and more generally for machines
which do not provide tsc emulation in user-space based on a
free-running counter. The proper solution is to add a "generic"
architecture to the --enable-arm-mach option of the configure script,
which sets the architecture to 4, disables the tsc emulation, and
enables the SA1100 quirks. I will try to do this for the 2.4.4
release.

>
>> But of course, if you insist, this probably can be worked around by
>> writing some merging script.
>
> Yeah, maybe this is the way to go. Easy to implement and minimizes the
> work for all participants.

Ok. Will do that.

-- 
 Gilles

