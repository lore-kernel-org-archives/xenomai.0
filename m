Message-ID: <5140EBB6.20205@xenomai.org>
Date: Wed, 13 Mar 2013 22:12:22 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1362541011.90317.YahooMailNeo@web161401.mail.bf1.yahoo.com>	<51406EAA.5000303@xenomai.org>
	<514076BD.3020202@antcom.de> <201303131647.58842.leo@alaxarxa.net>
In-Reply-To: <201303131647.58842.leo@alaxarxa.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] about Xenomai in Debian and Ubuntu
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Leopold Palomo-Avellaneda <leo@alaxarxa.net>
Cc: xenomai@xenomai.org

On 03/13/2013 04:47 PM, Leopold Palomo-Avellaneda wrote:

> Hi, (I think that I always put Hi or Bones (in catalan ..),
>=20
> I would like to put some comments to this thread:
>=20
> <Roland>
> I really understand that you will take care of the debian directory of =
the=20
> upstream code. Probably I misunderstand something reading your posts ..=
=2E I=20
> understand Gilles mail.
>=20
> I propose to have two branches in the upstream tree, one with the neces=
sary=20
> stuff to create a kernel package for the debian stable tree (with their=
=20
> kernel) and another for the sid/testing. This stuff could be the same o=
f the=20
> official ones. Maybe some submodules or another hyper-special character=
istic=20
> of git could help.
>=20
> I don't understand your tone in your last mails. I think that it has be=
en a=20
> misunderstanding problem. Please, _we_ can do it better.
> </Roland>


>=20
> <Gilles/Jan>
> Yes, I understand to St=C3=A9phane. However as I'm in several projects,=
 a lot of=20
> mails and to much things and a few time to do it. I have had the same f=
eeling,=20
> but, well, maybe I begin to be a bit old and ....
>=20
> I send to patch to UPSTREAM not to debian packagers. The script belongs=
 to=20
> upstream. I had a bad feeling because no answer to the patch, no push. =
I had=20
> to insist because the stupid error. But, rereading the mail I think tha=
t I=20
> post it in a wrong and confusing way: mea culpa.
> </Gilles/Jan>


Hi Leopold,

Yes, there was a misunderstanding, but ultimately, I am the one who did
the release, so, I could have tried to fix things. The truth is that I
simply forgot the issue you reported. So, mea culpa.

As for maintaing two debian directories, this is a bad idea, as long as
we can make one which works for all releases, this is simply less work.
So, let us keep it that way.

Regards.

--=20
                                                                Gilles.


