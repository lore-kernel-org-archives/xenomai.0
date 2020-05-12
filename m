MIME-Version: 1.0
References: <CAAvDm6ZbtJJPRfFPDhsxpR-njnJfEHvrJvG0Jrr=ob3=O-08pA@mail.gmail.com>
In-Reply-To: <CAAvDm6ZbtJJPRfFPDhsxpR-njnJfEHvrJvG0Jrr=ob3=O-08pA@mail.gmail.com>
From: =?UTF-8?B?5a2Z5LiW6b6Z?= <sunshilong369@gmail.com>
Date: Tue, 12 May 2020 09:23:55 +0800
Message-ID: <CAAvDm6bJ=YQDWBnNFOM4eY3ZsT_ip1wHLNMduDb9sREMS+-W7g@mail.gmail.com>
Subject: Re: Why xddp-stream demo process could not be terminate by ctrl + C.
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai <xenomai@xenomai.org>

Hi,
      Sorry for disturbing you.
      I found the answer allready. There are apis used to capture the
ctrl+c signal indeed.
=E5=AD=99=E4=B8=96=E9=BE=99 <sunshilong369@gmail.com> =E4=BA=8E2020=E5=B9=
=B45=E6=9C=8811=E6=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=883:51=E5=86=99=
=E9=81=93=EF=BC=9A

> Hi,
>      I could run the xddp-stream demo process normally indeed.
>      But when i intend to terminate the process by ctrl+c, nothing has
> happened.
>      The only way i found useful is to use the shell command(sudo killall
> -9 xddp-stream) to terminate it.
>      I*'m really confused.*
> *     As per the source code of
> xddp-stream(https://gitlab.denx.de/Xenomai/xenomai/-/blob/v3.0.9//demo/po=
six/cobalt/xddp-stream.c
> <https://gitlab.denx.de/Xenomai/xenomai/-/blob/v3.0.9//demo/posix/cobalt/=
xddp-stream.c>),
> there no api used to capture the ctrl+c signal.*
>      Thank you for your attention.
>      Look forward to hearing from you.
>
