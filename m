Message-ID: <4E8239E4.9010904@domain.hid>
Date: Tue, 27 Sep 2011 23:02:28 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAMwkeZy-9Qw0LALq8rrJQKET_Bu7UHgu8YYoFw1z6jdS687fBg@domain.hid>
In-Reply-To: <CAMwkeZy-9Qw0LALq8rrJQKET_Bu7UHgu8YYoFw1z6jdS687fBg@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Command code working with comedi not working
 with analogy
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: =?UTF-8?B?RmVybmFuZG8gSGVycmVybyBDYXJyw7Nu?= <elferdo@domain.hid>
Cc: xenomai@xenomai.org

On 09/27/2011 08:55 PM, Fernando Herrero Carr=C3=B3n wrote:
> Hi all,
>=20
> This is my first post to the list. I have been playing around with
> RTAI+Comedi for a while and wanted to give Xenomai+Analogy a chance. I =
am
> running a linux 2.6.32.20 kernel on an AMD Phenom(tm) II X4 965, with
> Xenomai 2.5.5.2. Xenomai appears to be running fine, analogy recognizes=
 my
> NI 6143 and NI 6713 cards, and "analogy-config" sets things properly up=
=2E
>=20
> Now I cannot succeed at running any of the "command" functions. The exa=
mple
> programs "insn_read" and "insn_write" work fine, but "cmd_read" and
> "cmd_write" don't. They fail at "a4l_snd_command".
>=20
> I ported an application that is already working with comedi to analogy.=
 My
> question is now whether the same values for the command structures that=
 are
> working on Comedi should work directly with Analogy, because the
> corresponding "a4l_snd_command" is failing with those values, returning=
 a
> value of -22.
>=20
> Thank you very much for your help,
> Fernando

Hi,

could you try Xenomai 2.6.0-rc3?

Regards.

--=20
                                                                Gilles.


