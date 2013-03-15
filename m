Message-ID: <5143605F.1080704@xenomai.org>
Date: Fri, 15 Mar 2013 18:54:39 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1362541011.90317.YahooMailNeo@web161401.mail.bf1.yahoo.com>
	<201303131647.58842.leo@alaxarxa.net> <5140EBB6.20205@xenomai.org>
	<201303141316.44057.leo@alaxarxa.net>
In-Reply-To: <201303141316.44057.leo@alaxarxa.net>
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

On 03/14/2013 01:16 PM, Leopold Palomo-Avellaneda wrote:

> A Dimecres, 13 de mar=C3=A7 de 2013, Gilles Chanteperdrix va escriure:
>> On 03/13/2013 04:47 PM, Leopold Palomo-Avellaneda wrote:
>>
>>> Hi, (I think that I always put Hi or Bones (in catalan ..),
>>>
>>> I would like to put some comments to this thread:
>>>
>>> <Roland>
>>> I really understand that you will take care of the debian directory o=
f the=20
>>> upstream code. Probably I misunderstand something reading your posts =
=2E.. I=20
>>> understand Gilles mail.
>>>
>>> I propose to have two branches in the upstream tree, one with the=20
> necessary=20
>>> stuff to create a kernel package for the debian stable tree (with the=
ir=20
>>> kernel) and another for the sid/testing. This stuff could be the same=
 of=20
> the=20
>>> official ones. Maybe some submodules or another hyper-special=20
> characteristic=20
>>> of git could help.
>>>
>>> I don't understand your tone in your last mails. I think that it has =
been=20
> a=20
>>> misunderstanding problem. Please, _we_ can do it better.
>>> </Roland>
>>
>>
>>>
>>> <Gilles/Jan>
>>> Yes, I understand to St=C3=A9phane. However as I'm in several project=
s, a lot=20
> of=20
>>> mails and to much things and a few time to do it. I have had the same=
=20
> feeling,=20
>>> but, well, maybe I begin to be a bit old and ....
>>>
>>> I send to patch to UPSTREAM not to debian packagers. The script belon=
gs to=20
>>> upstream. I had a bad feeling because no answer to the patch, no push=
=2E I=20
> had=20
>>> to insist because the stupid error. But, rereading the mail I think t=
hat I=20
>>> post it in a wrong and confusing way: mea culpa.
>>> </Gilles/Jan>
>>
>>
>> Hi Leopold,
>>
>> Yes, there was a misunderstanding, but ultimately, I am the one who di=
d
>> the release, so, I could have tried to fix things. The truth is that I=

>> simply forgot the issue you reported. So, mea culpa.
>=20
> too many guilty for a little thing ;-)
>=20
>> As for maintaing two debian directories, this is a bad idea, as long a=
s
>> we can make one which works for all releases, this is simply less work=
=2E
>> So, let us keep it that way.
>=20
> Well, I explain myself. Normally _we_ have a stable version, with the n=
eeded=20
> kernel and sometimes, a more modern kernel, (backported) or in a=20
> testing/unstable version the modern kernel.
>=20
> It's not easy sometimes to have a modern kernel in a stable version of =
debian.=20
> So, as now in the transitional time we should need two versions of the =

> package. That's why my propose.=20
>=20
> OTOH, if we have _one_ sync with debian to me it's perfect. All of as w=
e have=20
> a lot of things to do, so less work.
>=20
> I hope that all could be solved.


Hi Leopold,

quite frankly I do not understand what you are talking about. What I am
talking about is the "debian" directory in xenomai sources. It seems
simpler to me to have only one directory which works for all Debian
branches, in order to allow users to generate packages for the
distribution they want. That is all I am saying.

Regards.

--=20
                                                                Gilles.


