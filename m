From: "Leopold Palomo-Avellaneda" <leo@alaxarxa.net>
Date: Thu, 14 Mar 2013 13:16:43 +0100
References: <1362541011.90317.YahooMailNeo@web161401.mail.bf1.yahoo.com>
	<201303131647.58842.leo@alaxarxa.net> <5140EBB6.20205@xenomai.org>
In-Reply-To: <5140EBB6.20205@xenomai.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201303141316.44057.leo@alaxarxa.net>
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

A Dimecres, 13 de mar=C3=A7 de 2013, Gilles Chanteperdrix va escriure:
> On 03/13/2013 04:47 PM, Leopold Palomo-Avellaneda wrote:
>=20
> > Hi, (I think that I always put Hi or Bones (in catalan ..),
> >=20
> > I would like to put some comments to this thread:
> >=20
> > <Roland>
> > I really understand that you will take care of the debian directory of =
the=20
> > upstream code. Probably I misunderstand something reading your posts ..=
=2E I=20
> > understand Gilles mail.
> >=20
> > I propose to have two branches in the upstream tree, one with the=20
necessary=20
> > stuff to create a kernel package for the debian stable tree (with their=
=20
> > kernel) and another for the sid/testing. This stuff could be the same o=
f=20
the=20
> > official ones. Maybe some submodules or another hyper-special=20
characteristic=20
> > of git could help.
> >=20
> > I don't understand your tone in your last mails. I think that it has be=
en=20
a=20
> > misunderstanding problem. Please, _we_ can do it better.
> > </Roland>
>=20
>=20
> >=20
> > <Gilles/Jan>
> > Yes, I understand to St=C3=A9phane. However as I'm in several projects,=
 a lot=20
of=20
> > mails and to much things and a few time to do it. I have had the same=20
feeling,=20
> > but, well, maybe I begin to be a bit old and ....
> >=20
> > I send to patch to UPSTREAM not to debian packagers. The script belongs=
 to=20
> > upstream. I had a bad feeling because no answer to the patch, no push. =
I=20
had=20
> > to insist because the stupid error. But, rereading the mail I think tha=
t I=20
> > post it in a wrong and confusing way: mea culpa.
> > </Gilles/Jan>
>=20
>=20
> Hi Leopold,
>=20
> Yes, there was a misunderstanding, but ultimately, I am the one who did
> the release, so, I could have tried to fix things. The truth is that I
> simply forgot the issue you reported. So, mea culpa.

too many guilty for a little thing ;-)

> As for maintaing two debian directories, this is a bad idea, as long as
> we can make one which works for all releases, this is simply less work.
> So, let us keep it that way.

Well, I explain myself. Normally _we_ have a stable version, with the neede=
d=20
kernel and sometimes, a more modern kernel, (backported) or in a=20
testing/unstable version the modern kernel.

It's not easy sometimes to have a modern kernel in a stable version of debi=
an.=20
So, as now in the transitional time we should need two versions of the=20
package. That's why my propose.=20

OTOH, if we have _one_ sync with debian to me it's perfect. All of as we ha=
ve=20
a lot of things to do, so less work.

I hope that all could be solved.

Regards,

Leopold


=2D-=20
=2D-
Linux User 152692
Catalonia

