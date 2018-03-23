Date: Fri, 23 Mar 2018 18:10:46 +0100
From: Henning Schild <henning.schild@siemens.com>
Message-ID: <20180323181046.39831f17@mmd1pvb1c.ad001.siemens.net>
In-Reply-To: <dc7t5a0blp8e8ds7timig1qq.1521822126574@embeddedgreg.com>
References: <CAOuPNLiQnbih972q09Qn-4PJ1p_WdB8i=5_SG3TVnf7hdWsC2A@mail.gmail.com>
 <dc7t5a0blp8e8ds7timig1qq.1521822126574@embeddedgreg.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Upgrading xenomai-3 patches in existing xenomai kernel
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Greg Gallagher <greg@embeddedgreg.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

My conservative approach is to "git clean -dfx" the kernel tree every
single time and "preapre-kernel" again, from the new xenomai repo.

The rebuild will take time, you will have to back-up your config etc.

If you want to safe build-time and still be conservative, i would
"prepare-kernel.sh --outpatch=3D". That guy can be applied and reverted
i.e. with git. So you can unpatch and repatch your kernel without
loosing configs and build results.

I do not know how smart prepare-kernel.sh is, but i can imagine it
might eventually end up in a "merge" situation, where things could go
wrong. So i prefer the tools i know to avoid surprises.

Henning

Am Fri, 23 Mar 2018 12:22:06 -0400
schrieb Greg Gallagher <greg@embeddedgreg.com>:

> When you run the prepare_kernel script add the flag --verbose. If you
> have ipipe patches already applied to your kernel you should see a
> message about ipipe patches have already been applied. It will just
> add the new Xenomai bits.
>=20
> Greg
>=20
> =C2=A0 Original Message =C2=A0
> From: pintu.ping@gmail.com
> Sent: March 23, 2018 11:58 AM
> To: henning.schild@siemens.com
> Cc: xenomai@xenomai.org
> Subject: Re: [Xenomai] Upgrading xenomai-3 patches in existing
> xenomai kernel
>=20
> On Fri, Mar 23, 2018 at 7:14 PM, Henning Schild
> <henning.schild@siemens.com> wrote:
> > Am Fri, 23 Mar 2018 19:06:30 +0530
> > schrieb Pintu Kumar <pintu.ping@gmail.com>:
> > =20
> >> Hi,
> >>
> >> I just came across a situation about Xenomai upgrade, and wanted to
> >> know your opinion.
> >>
> >> Some 4 months back, I applied Xenomai-3 (and ipipe) patches to my
> >> x86 kernel 4.9.51, using the prepare_kernel script, and I am using
> >> it since then. =20
> >
> > You will need an ipipe-enabled kernel anyways. Prepare kernel will
> > just install the xenomai-bits.
> > If you do not want to use an ipipe-kernel from upstream you can
> > rebase/merge the ipipe branch (in your case 4.9.y) onto/into your
> > kernel. All that should be under version control. Prepare-kernel is
> > a build step and should be done on a clean working copy when
> > building.=20
>=20
> Yah, I can apply ipipe changes separately using the git command.
> I guess that should work on top of existing ipipe changes already
> applied.
>=20
> But I don't want to upgrade ipipe patches, since it is already latest.
> My main concerns is about applying/upgrading xenomai driver/cobalt
> changes. Should I use prepare_kernel for that (without ipipe option) ?
> OR, should I download the commits and apply directly to the kernel in
> normal way?
> What is the right option, so that all future upgrades can be done
> easily, just like normal kernel?
> I think we should think about it and find some best way?
> May be something like: scripts/upgrade_xenomai
>=20
>=20
>=20
>=20
> > Henning
> > =20
> >> But, now I wanted to upgrade to latest Xenomai kernel patches from
> >> Xenomai-3 git.
> >> Can I simply cherrypick the patches from Xenomai and apply to my
> >> Kernel ? I guess the folder structures are different, so I guess it
> >> may not work cleanly.
> >>
> >> So, what is the best way to apply the latest Xenomai Kernel
> >> patches, on to existing Xenomai converted kernel repo, without
> >> disturbing the previously applied patches ?
> >>
> >> If there is any standard procedure you follow, please let me know.
> >>
> >>
> >> Thanks,
> >> Pintu
> >>
> >> _______________________________________________
> >> Xenomai mailing list
> >> Xenomai@xenomai.org
> >> https://xenomai.org/mailman/listinfo/xenomai =20
> > =20
>=20
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> https://xenomai.org/mailman/listinfo/xenomai


