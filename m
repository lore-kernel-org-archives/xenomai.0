MIME-Version: 1.0
References: <CAAvDm6aDLFL1OzT8A2ufYrCrxwR4ROgS+v6ZUqSkq_K2tb3m_A@mail.gmail.com>
 <093ba9fd-6327-00d7-7b1e-da71dfc1cb4e@siemens.com>
In-Reply-To: <093ba9fd-6327-00d7-7b1e-da71dfc1cb4e@siemens.com>
From: =?UTF-8?B?5a2Z5LiW6b6Z?= <sunshilong369@gmail.com>
Date: Wed, 8 Apr 2020 21:13:49 +0800
Message-ID: <CAAvDm6bP_zCABHDKwUXY6DW7q3=qhh=Fe2MiUfJbsvkyCaaJ7Q@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_Why_X11_influences_the_latency_of_xenomai=EF=BC=9F?=
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
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai <xenomai@xenomai.org>

Hi,
      I could not catch your idea about the GPU usage patterns. How could
I acquire this information?

      My laptop model is Dell Latitude 5501 runing over ubuntu 14.04 system=
.
      GPU model information=EF=BC=9A NVIDIA GeForce MX150.

     Best regards.

Jan Kiszka <jan.kiszka@siemens.com> =E4=BA=8E2020=E5=B9=B44=E6=9C=888=E6=97=
=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=885:05=E5=86=99=E9=81=93=EF=BC=9A

> On 08.04.20 10:39, =E5=AD=99=E4=B8=96=E9=BE=99 via Xenomai wrote:
> > Hi,
> >      Why X11 influences the latency of xenomai=EF=BC=9FI guess it has s=
ome
> relation
> > to GPU.Could you make me more clearly?
> >      I have solved the latency . I am using QT runing on linux
> framebuffer
> > ,disabled X11 at all.I really hope to why  X11 influences the latency o=
f
> > xenomai
>
> It's not X11, it's the side effects of certain GPU usage patterns on
> your particular platform. Can you specify more details about both?
>
> Jan
>
> --
> Siemens AG, Corporate Technology, CT RDA IOT SES-DE
> Corporate Competence Center Embedded Linux
>
