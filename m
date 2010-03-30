From: Wolfgang Denk <wd@domain.hid>
MIME-Version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: <horvm4$cil$1@domain.hid>
References: <horvm4$cil$1@domain.hid>
Date: Tue, 30 Mar 2010 22:05:29 +0200
Message-Id: <20100330200529.BEBFEE73028@domain.hid>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] find bits and pieces for Denx PPC/ipipe/xenomai?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Robert Berger <gmane@domain.hid>
Cc: xenomai@xenomai.org

Dear Robert,

In message <horvm4$cil$1@domain.hid> you wrote:
>=20
> Does this mean, that the patches are not anymore against the DENX git
> repository, but against mainline?

This is not a contradiction - our linux-2.6-denx repository is based
on the kernel.org tree and fully includes it.

The "kernel.org" branch in our "linux-2.6-denx" repository is
directly tracking the mainline kernel tree.

> What I would do up to now is to find in the denx git repository the
> corresponding commit or similar;)

Just refer to the git commit ID, and you will find it happens to be
there.

> There seems to be an 2.6.33 ipipe patch:
>=20
> http://git.xenomai.org/?p=3Dxenomai-head.git;a=3Dblob;f=3Dksrc/arch/pow=
erpc/patches/adeos-ipipe-2.6.33-powerpc-2.9-00.patch;h=3D7b84ba91606e7873=
227ef70d99aa077362248f4a;hb=3Dmaster
>=20
> So I would apply this on:
> http://git.denx.de/?p=3Dlinux-2.6-denx.git;a=3Dshortlog;h=3Drefs/heads/=
DENX-v2.6.33-stable

Of course not. You do not use the web interface to actually work with
git.  And "v2.6.33" in mainline is something different than our
DENX-v2.6.33-stable branch (which BTW is a branch, i. e. not a
specific commit).

> Or something completely different?

If you want to get "v2.6.33", you check out this version: You would
initially run "git clone" to clone either the kernel.org mainline
repository, or, if you like, our "linux-2.6-denx" repository. Then
you would run the command

	git checkout v2.6.33

to get the exact state of sources these patches were created against.

> I'm confused what's the recommended way to get the latest and greatest
> ipipe/kernel/xenomai combination based on a DENX ppc kernel tree.

See above: "git clone" followed by "git checkout" - as usual.

Best regards,

Wolfgang Denk

--=20
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@domain.hid
I'm frequently appalled by the low regard you Earthmen have for life.
	-- Spock, "The Galileo Seven", stardate 2822.3

