References: <CAMES2hcz4K0DXAcktWZ0-DCqA1ds9b=oCfwNET8YaCq9sa+NGw@mail.gmail.com>
 <877d6sv1xg.fsf@xenomai.org> <87tu9wtlkk.fsf@xenomai.org>
 <CAMES2hdMDXzs7K6fG10wgfO99w16QKq_vcwdAu=Hi6rg5grfYg@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: Building example code with EVL
Date: Mon, 16 May 2022 15:59:53 +0200
In-reply-to: <CAMES2hdMDXzs7K6fG10wgfO99w16QKq_vcwdAu=Hi6rg5grfYg@mail.gmail.com>
Message-ID: <8735h9indw.fsf@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Roberto Ferri <ironsnetwork@gmail.com>
Cc: xenomai@xenomai.org, engineervalide@gmail.com


Roberto Ferri <ironsnetwork@gmail.com> writes:

> Thanks for your fast response!
>
> I compiled with meson but I got this error message:
> ~/git/libevl/tests/observable-unicast.c:168:44: error: =E2=80=98EVL_CLONE=
_UNICAST=E2=80=99 undeclared (first use in this function); did you mean =E2=
=80=98EVL_CLONE_INPUT=E2=80=99?
>
> Getting the same error in [1], but not in [2].=20
> More info at [3].
>
> [1] Files =C2=B7 c6e08a9b029a4c9eaeeb761f8978f9e374834909 =C2=B7 xenomai =
/ xenomai4 / libevl =C2=B7 GitLab (denx.de)
> [2] Files =C2=B7 bfa2c4b55cc7d237c685bff722b59d816e63cd8f =C2=B7 xenomai =
/ xenomai4 / libevl =C2=B7 GitLab (denx.de)
> [3] https://source.denx.de/Xenomai/xenomai4/libevl/-/issues/1#note_168405
>

You need to resync with the latest kernel uapi section, the libevl -next
branch builds on the latest EVL kernel code, see [1][2][3].

[1]
https://source.denx.de/Xenomai/xenomai4/linux-evl/-/commits/v5.15.y-evl-reb=
ase/
[2]
https://source.denx.de/Xenomai/xenomai4/linux-evl/-/commits/v5.18-evl-rebase
[3] https://source.denx.de/Xenomai/xenomai4/linux-evl/-/commits/v5.10.y-evl=
-rebase

--=20
Philippe.

