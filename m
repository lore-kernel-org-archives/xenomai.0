Message-ID: <4C1D0A5A.5020102@domain.hid>
Date: Sat, 19 Jun 2010 20:20:10 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTinRyxZ-BB_VwB2XPYwIPik8to_eynd-c-nNulQ1@domain.hid>
	<4C19EDA4.2030601@domain.hid> <4C1A040F.4030209@domain.hid>
	<AANLkTikMtR9kMd424sXIUdULJlaRxKIlJ19ElJ4Pt4o1@domain.hid>
	<C159A093-EA69-4903-8114-145C4355A0C0@domain.hid>
	<AANLkTim91ABqsvWb_GqMhOwnDlIQNfz1qoE-ABWc3KGE@mail.gmail.com>
	<4C1C9159.1000408@domain.hid>
	<2DD1EFE4-AE92-4F78-9BAF-7441D7D0DB3E@gmail.com>
	<4C1CA3BD.5030403@domain.hid>
	<A06A3D41-9246-4973-92E4-97BB33A92468@domain.hid>
In-Reply-To: <A06A3D41-9246-4973-92E4-97BB33A92468@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] application make file
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Piquesel <piquesel@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Piquesel wrote:
> Le 19 juin 2010 =C3=A0 13:02, Gilles Chanteperdrix a =C3=A9crit :
>=20
>> Bruno Rouchouse wrote:
>>> Hi Gilles,
>>>=20
>>> I do understand your point an mostly agrees with it. What you say
>>> is really common sense.
>>>=20
>>> However, I would object 2 points: first it's everyone's freedom
>>> to help someone or not even if it is a dummy question. In fact,
>>> due to my knowledge, I can help only on those ;)
>>>=20
>>> Second, it's not so easy when you start using a technology to
>>> find all the right pointers and have all the answers. For
>>> instance, I'm still struggling with lot's of git features and
>>> workflow although everything is documented. Reading all man pages
>>> does not really help me for every use case.
>> Well maybe for git, a simple approach is to set-up some git
>> repository locally, then try git commands, without any risk to
>> break anything. You can also set-up a bare repository to play with
>> push and fetch.
>>=20
> Yes that's what I did in fact. I guess I can post this use case here
> because it may be of some interest to some other xenomai users.
>=20
> My workflow is quite standard I think and I did find a way to handle
> it. Not sure it is the best one though.
>=20
> I clone locally from xenomai git repository. I create also my own
> branch on my local repository but I also need a git repository on
> github in order to access to my tree from different machines.
>=20
> In terms of git commands, here's what I did:
>=20
> * Cloned Xenomai repository on my local machine git clone
> git://xenomai.org/xenomai-head.git and created from there my own
> branch : git branch benchlib
>=20
> * Pushed once this local copy to github in order to populate my
> remote repository (git push)
>=20
> The thing I'm not sure about is now how to handle update process of
> my local and github repositories when xenomai-head evolves. I need to
> keep both in sync with Xenomai development tree. Makes sense?
>=20
> What I do (on my local rep) currently is: (on my local repository)=20
> git checkout master git pull (on my local rep) to update my tree with
> the latest xenomai commits git checkout benchlib git rebase master
> (in order to have my branch in sync with the latest release)
>=20
> Here comes a first pain: I get plenty of conflicts due to Makefile.in
> changes. So what I did is just launching the bootstrap script to
> update them in my tree and then do a: git rebase --continue

You probably have conflicts because you made change locally, the answer
is simple: if you want to make changes locally, use the same version of
autotools as me, that is:
autoconf 2.65
automake 1.10.1

>=20
> Finally, when my tree is up to date, I still need to update my githup
> repository and I'm not so clear on how to do that.
>=20
> When I use git push git@domain.hid, I
> get some non-fast forward errors. I found some explanations on
> different forums. I'm not sure I really understand what I'm doing
> here but I get around this problem like this:
>=20
> git fetch origin
>=20
> and then I can push via git push -f
> git@domain.hid
>=20
> Well, I don't know if I'm very clear :-) I'll draw a diagram if
> needed.

No, I do not get it here. As soon as you rebase, you modify your branch'
history and have to use push -f. There is nothing wrong with that.

--=20
					    Gilles.


