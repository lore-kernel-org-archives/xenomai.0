From: "Leopold Palomo-Avellaneda" <leo@alaxarxa.net>
Date: Tue, 19 Mar 2013 09:33:02 +0100
References: <1362541011.90317.YahooMailNeo@web161401.mail.bf1.yahoo.com>
	<201303141316.44057.leo@alaxarxa.net>
	<5143605F.1080704@xenomai.org>
In-Reply-To: <5143605F.1080704@xenomai.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201303190933.02335.leo@alaxarxa.net>
Subject: Re: [Xenomai] about Xenomai in Debian and Ubuntu
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

A Divendres, 15 de mar=C3=A7 de 2013, Gilles Chanteperdrix va escriure:
> On 03/14/2013 01:16 PM, Leopold Palomo-Avellaneda wrote:
>=20
> > A Dimecres, 13 de mar=C3=A7 de 2013, Gilles Chanteperdrix va escriure:
> >> On 03/13/2013 04:47 PM, Leopold Palomo-Avellaneda wrote:
> >>
> >>> Hi, (I think that I always put Hi or Bones (in catalan ..),
> >>>
> >>> I would like to put some comments to this thread:
> >>>
> >>> <Roland>
> >>> I really understand that you will take care of the debian directory o=
f=20
the=20
> >>> upstream code. Probably I misunderstand something reading your posts =
=2E..=20
I=20
> >>> understand Gilles mail.
> >>>
> >>> I propose to have two branches in the upstream tree, one with the=20
> > necessary=20
> >>> stuff to create a kernel package for the debian stable tree (with the=
ir=20
> >>> kernel) and another for the sid/testing. This stuff could be the same=
 of=20
> > the=20
> >>> official ones. Maybe some submodules or another hyper-special=20
> > characteristic=20
> >>> of git could help.
> >>>
> >>> I don't understand your tone in your last mails. I think that it has=
=20
been=20
> > a=20
> >>> misunderstanding problem. Please, _we_ can do it better.
> >>> </Roland>
> >>
> >>
> >>>
> >>> <Gilles/Jan>
> >>> Yes, I understand to St=C3=A9phane. However as I'm in several project=
s, a lot=20
> > of=20
> >>> mails and to much things and a few time to do it. I have had the same=
=20
> > feeling,=20
> >>> but, well, maybe I begin to be a bit old and ....
> >>>
> >>> I send to patch to UPSTREAM not to debian packagers. The script belon=
gs=20
to=20
> >>> upstream. I had a bad feeling because no answer to the patch, no push=
=2E I=20
> > had=20
> >>> to insist because the stupid error. But, rereading the mail I think t=
hat=20
I=20
> >>> post it in a wrong and confusing way: mea culpa.
> >>> </Gilles/Jan>
> >>
> >>
> >> Hi Leopold,
> >>
> >> Yes, there was a misunderstanding, but ultimately, I am the one who did
> >> the release, so, I could have tried to fix things. The truth is that I
> >> simply forgot the issue you reported. So, mea culpa.
> >=20
> > too many guilty for a little thing ;-)
> >=20
> >> As for maintaing two debian directories, this is a bad idea, as long as
> >> we can make one which works for all releases, this is simply less work.
> >> So, let us keep it that way.
> >=20
> > Well, I explain myself. Normally _we_ have a stable version, with the=20
needed=20
> > kernel and sometimes, a more modern kernel, (backported) or in a=20
> > testing/unstable version the modern kernel.
> >=20
> > It's not easy sometimes to have a modern kernel in a stable version of=
=20
debian.=20
> > So, as now in the transitional time we should need two versions of the=
=20
> > package. That's why my propose.=20
> >=20
> > OTOH, if we have _one_ sync with debian to me it's perfect. All of as w=
e=20
have=20
> > a lot of things to do, so less work.
> >=20
> > I hope that all could be solved.
>=20
>=20
> Hi Leopold,
>=20
> quite frankly I do not understand what you are talking about.=20

:-)

> What I am
> talking about is the "debian" directory in xenomai sources.=20

yes, I was talking about the same.

> It seems
> simpler to me to have only one directory which works for all Debian
> branches, in order to allow users to generate packages for the
> distribution they want. That is all I am saying.

if it works, to me it's ok. But I don't know if you can have _one_ director=
y=20
for all Debian branches. For example in the control file:

Build-Depends: debhelper (>=3D 8), findutils (>=3D 4.2.28), autotools-dev,=
=20
autoconf, automake, libtool

I cannot predict if jezzie will introduce a change in debhelper that breaks=
=20
wheezy. Or findutils could have a very different version in wheezy than=20
squeeze. Or simple, we could have different versions (backports, testing,=20
experimental) for the same sources and the changelog file will be a mesh.=20

It's just and idea. But, taking in mind how many users uses it and the amou=
nt=20
of work that represents it, please do it the most simplest way.

Thanks for all.

Regards.


Leopold=20


>=20
> --=20
>                                                                 Gilles.
>=20
>=20


=2D-=20
=2D-
Linux User 152692
Catalonia

