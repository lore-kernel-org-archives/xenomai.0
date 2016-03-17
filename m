Date: Thu, 17 Mar 2016 15:52:05 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20160317145205.GE575@hermes.click-hack.org>
References: <CAPkGiCLc89Or8_636FETmiV59T=SqDBkwPEbES_RTJkFfabnsg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAPkGiCLc89Or8_636FETmiV59T=SqDBkwPEbES_RTJkFfabnsg@mail.gmail.com>
Subject: Re: [Xenomai] Xenomai on Intel Edison
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?iso-8859-1?B?TeR4?= Tanner <maex.tanner@googlemail.com>
Cc: xenomai@xenomai.org

On Thu, Mar 17, 2016 at 03:45:28PM +0100, M=E4x Tanner wrote:
> Hello,
>=20
> I have some troubles installing Xenomai 3.0.1 on the Intel Edison (Yocto
> Linux). I really hope you can help me with the following error:
>=20
> After extracting Xenomai, running ./bootstrap and ./configure without
> errors - I get the following error trying to run ./prepare-kernel.sh: line
> 307: linux_: command not found
> Line 307 consists of:
> eval linux_`grep '^EXTRAVERSION =3D' $linux_tree/Makefile | sed -e 's, ,,=
g'`
> The problem is that grep does not find EXTRAVERSION in the Makefile. Hence
> it returns nothing and of course the OS can not recognize the command
> "linux_". I checked the Makefile and there is no "EXTRAVERSION"
> declaration, neither (following in the next lines of the
> "prepare_kernel.sh") a "PATCHLEVEL", "SUBLEVEL" or "VERSION" declaration.
> As result of that I think that my Makefile is not generated correctly. But
> I don't see the point why?

Normally, the Linux kernel sources makefile contains something like:
VERSION =3D 4
PATCHLEVEL =3D 5
SUBLEVEL =3D 0
EXTRAVERSION =3D

Are you sure you pass the path to some kernel sources to
prepare-kernel.sh --linux parameter ?

--=20
					    Gilles.
https://click-hack.org

