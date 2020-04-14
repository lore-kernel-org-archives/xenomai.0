Subject: =?utf-8?q?Re=3A_rt=5Ftask=5Funblock=28=29_POSIX_alternative?=
Date: Tue, 14 Apr 2020 10:16:00 +0200
From: =?utf-8?q?Petr_=c4=8cervenka?= <grugh@centrum.cz>
References: <20200407154117.5D7D71C2@centrum.cz>,
 <b9ce43ab-526d-71b8-c761-150dc7c1fd3f@siemens.com>,
 <20200407171816.E0B3979D@centrum.cz>,
 <CAFLxGvx2EhOgUnB1VkW+7TendLUcsZ0XGGcwYhiPw7PcxwFkTw@mail.gmail.com>,
 <20200408114406.6119E0D9@centrum.cz>,
 <CAFLxGvx9-awne2He+ULqOzwf0cGae1s_k+-b8tdiM+uT67+cYg@mail.gmail.com>,
 <20200409170009.5B0DAA77@centrum.cz>,
 <CAFLxGvy8SP+4mr3PYYRHuxww=22w28RjaDPUgDSVFVHx-_cQ_g@mail.gmail.com>,
 <20200409201057.74CB5ED0@centrum.cz>
 <CAFLxGvxuZw57FvaAQEAxseamoPhHdKX7wfZoaZxKskgeXa4V9g@mail.gmail.com>
In-Reply-To: <CAFLxGvxuZw57FvaAQEAxseamoPhHdKX7wfZoaZxKskgeXa4V9g@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <20200414101600.F9AA555D@centrum.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?utf-8?q?Richard_Weinberger?= <richard.weinberger@gmail.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Xenomai <xenomai@xenomai.org>

Hello Richard.
Sorry for late answer because of the Easter.

 > I gave your program a try.
> With this changes it works (at least how I understand your test case).
 >=20
> Task started
> Set period: 5s
> Task livind: 9.9e-05s
> Waiting for join
> Signal handler: 41
> Signal handler end
> Task livind: 0.999s
> Task ended
 >
> ...
=C2=A0
There has to be something with my version of Xenomai, IPIPE or configuratio=
n. Not even your example is working for me. Morover in your example output =
is clearly visible, that the first waiting is interrupted 9.9e-05s after fi=
rst attempt to wait by some unknown signal. Such thing has never happened t=
o me in POSIX, only in Alchemy.
=C2=A0
My output:
Task started
Set period: 5s
Waiting for join
Task livind: 5s
Task livind: 5s
Task livind: 5s
...
=C2=A0
Also here is perhaps a small fix to your changes: sa.sa_flags =3D SA_SIGINF=
O;
=C2=A0
user@user-desktop:~$ uname -a
Linux user-desktop 4.19.109-xenomai #1 SMP Fri Apr 3 13:51:40 CEST 2020 x86=
_64 x86_64 x86_64 GNU/Linux
=C2=A0
user@user-desktop:~$ /usr/xenomai/bin/xeno-config --verbose
xeno-config --verbose
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 --core=3Dcobalt
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 --version=3D"3.1"
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 --cc=3D"gcc"
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 --ccld=3D"/usr/xenomai/bin/wrap-=
link.sh gcc"
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 --arch=3D"x86"
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 --prefix=3D"/usr/xenomai"
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 --library-dir=3D"/usr/xenomai/li=
b"
=C2=A0
IPIPE patch: ipipe-core-4.19.109-cip22-x86-11.patch
=C2=A0
Petr

