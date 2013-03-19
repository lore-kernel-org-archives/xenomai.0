Message-ID: <51485702.6070106@xenomai.org>
Date: Tue, 19 Mar 2013 13:16:02 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1362541011.90317.YahooMailNeo@web161401.mail.bf1.yahoo.com>
	<201303141316.44057.leo@alaxarxa.net>
	<5143605F.1080704@xenomai.org>
	<201303190933.02335.leo@alaxarxa.net>
In-Reply-To: <201303190933.02335.leo@alaxarxa.net>
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

On 03/19/2013 09:33 AM, Leopold Palomo-Avellaneda wrote:

> A Divendres, 15 de mar=C3=A7 de 2013, Gilles Chanteperdrix va escriure:=

>> On 03/14/2013 01:16 PM, Leopold Palomo-Avellaneda wrote:
>>
>>> A Dimecres, 13 de mar=C3=A7 de 2013, Gilles Chanteperdrix va escriure=
:
>>>> On 03/13/2013 04:47 PM, Leopold Palomo-Avellaneda wrote:
>>>>
>>>>> Hi, (I think that I always put Hi or Bones (in catalan ..),
>>>>>
>>>>> I would like to put some comments to this thread:
>>>>>
>>>>> <Roland>
>>>>> I really understand that you will take care of the debian directory=
 of=20
> the=20
>>>>> upstream code. Probably I misunderstand something reading your post=
s ...=20
> I=20
>>>>> understand Gilles mail.
>>>>>
>>>>> I propose to have two branches in the upstream tree, one with the=20
>>> necessary=20
>>>>> stuff to create a kernel package for the debian stable tree (with t=
heir=20
>>>>> kernel) and another for the sid/testing. This stuff could be the sa=
me of=20
>>> the=20
>>>>> official ones. Maybe some submodules or another hyper-special=20
>>> characteristic=20
>>>>> of git could help.
>>>>>
>>>>> I don't understand your tone in your last mails. I think that it ha=
s=20
> been=20
>>> a=20
>>>>> misunderstanding problem. Please, _we_ can do it better.
>>>>> </Roland>
>>>>
>>>>
>>>>>
>>>>> <Gilles/Jan>
>>>>> Yes, I understand to St=C3=A9phane. However as I'm in several proje=
cts, a lot=20
>>> of=20
>>>>> mails and to much things and a few time to do it. I have had the sa=
me=20
>>> feeling,=20
>>>>> but, well, maybe I begin to be a bit old and ....
>>>>>
>>>>> I send to patch to UPSTREAM not to debian packagers. The script bel=
ongs=20
> to=20
>>>>> upstream. I had a bad feeling because no answer to the patch, no pu=
sh. I=20
>>> had=20
>>>>> to insist because the stupid error. But, rereading the mail I think=
 that=20
> I=20
>>>>> post it in a wrong and confusing way: mea culpa.
>>>>> </Gilles/Jan>
>>>>
>>>>
>>>> Hi Leopold,
>>>>
>>>> Yes, there was a misunderstanding, but ultimately, I am the one who =
did
>>>> the release, so, I could have tried to fix things. The truth is that=
 I
>>>> simply forgot the issue you reported. So, mea culpa.
>>>
>>> too many guilty for a little thing ;-)
>>>
>>>> As for maintaing two debian directories, this is a bad idea, as long=
 as
>>>> we can make one which works for all releases, this is simply less wo=
rk.
>>>> So, let us keep it that way.
>>>
>>> Well, I explain myself. Normally _we_ have a stable version, with the=
=20
> needed=20
>>> kernel and sometimes, a more modern kernel, (backported) or in a=20
>>> testing/unstable version the modern kernel.
>>>
>>> It's not easy sometimes to have a modern kernel in a stable version o=
f=20
> debian.=20
>>> So, as now in the transitional time we should need two versions of th=
e=20
>>> package. That's why my propose.=20
>>>
>>> OTOH, if we have _one_ sync with debian to me it's perfect. All of as=
 we=20
> have=20
>>> a lot of things to do, so less work.
>>>
>>> I hope that all could be solved.
>>
>>
>> Hi Leopold,
>>
>> quite frankly I do not understand what you are talking about.=20
>=20
> :-)
>=20
>> What I am
>> talking about is the "debian" directory in xenomai sources.=20
>=20
> yes, I was talking about the same.
>=20
>> It seems
>> simpler to me to have only one directory which works for all Debian
>> branches, in order to allow users to generate packages for the
>> distribution they want. That is all I am saying.
>=20
> if it works, to me it's ok. But I don't know if you can have _one_ dire=
ctory=20
> for all Debian branches. For example in the control file:
>=20
> Build-Depends: debhelper (>=3D 8), findutils (>=3D 4.2.28), autotools-d=
ev,=20
> autoconf, automake, libtool
>=20
> I cannot predict if jezzie will introduce a change in debhelper that br=
eaks=20
> wheezy. Or findutils could have a very different version in wheezy than=
=20
> squeeze. Or simple, we could have different versions (backports, testin=
g,=20
> experimental) for the same sources and the changelog file will be a mes=
h.=20
>=20
> It's just and idea. But, taking in mind how many users uses it and the =
amount=20
> of work that represents it, please do it the most simplest way.


I do not think depending on too old versions really matters. I happen to
regularly compile on squeeze packages not for squeeze, and most of the
time, simply modifying the control file to require lower versions simply
works. So, conversely having a control file requesting too old versions
should not be a problem.

I agree that there may be other reasons why the package could break on
more recent versions, if that happens and someone actually has the
problem, we will get a bug report and react accordingly.

Note that the debian directory is mostly for the stable branch, as
Roland takes care of debian packages for the other branches.

--=20
                                                                Gilles.


