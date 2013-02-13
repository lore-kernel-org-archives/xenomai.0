From: "Giataganas, Petros" <petros.giataganas11@imperial.ac.uk>
Date: Wed, 13 Feb 2013 12:44:22 +0000
Message-ID: <CC872764D2E12B469BE82C0BF22F24DF2716B6E4@icexch-m2.ic.ac.uk>
References: <CC872764D2E12B469BE82C0BF22F24DF2716AB5A@icexch-m2.ic.ac.uk>
	<511B8A11.1060204@xenomai.org>
In-Reply-To: <511B8A11.1060204@xenomai.org>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <18D990F808DDF64A8EF3EB68A56E69BD@imperial.ac.uk>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai] Xenomai linux kernel compile
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Dear mr. Gilles,

Thank you very much for your answer!!=20

I will have a look on these and I will let you know.=20
Thank you again!!=20

Best,
Petros

On 13 Feb 2013, at 12:41, Gilles Chanteperdrix <gilles.chanteperdrix@xenoma=
i.org>
 wrote:

> On 02/12/2013 08:20 PM, Giataganas, Petros wrote:
>=20
>> Hi all,
>>=20
>> Thank you for your amazing work on xenomai and the documentation that su=
pports it.
>>=20
>> I have to say that I am newbie but I have not found any solution on mr. =
Google!
>>=20
>> I am running ubuntu 12.04 and I want to run xenomai 2.6.2.1
>>=20
>> My problem is presented when I am doing the full kernel compile based on=
 the guide :
>>=20
>> http://www.stanley.gatech.edu/skelly/uncategorized/installing-xenomai-on=
-ubuntu-12-04/
>=20
>=20
> The instructions for installing Xenomai on a Debian distribution are here=
:
> http://xenomai.org/index.php/Building_Debian_packages
>=20
> They are a bit outdated as they mention a
> "/usr/src/kernel-patches/i386/apply/xenomai" script which no longer
> exists. Instead, see what patch you need in the
> /usr/src/kernel-patches/diffs/xenomai
>=20
> and apply it to the kernel sources with the patch command.
>=20
> You may also find pre-compiled packages for Ubuntu starting on this page:
> http://wiki.linuxcnc.org/cgi-bin/wiki.pl?XenomaiKernelPackages
>=20
> --=20
>                                                                Gilles.


