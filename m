MIME-Version: 1.0
References: <CAAvDm6aDLFL1OzT8A2ufYrCrxwR4ROgS+v6ZUqSkq_K2tb3m_A@mail.gmail.com>
 <093ba9fd-6327-00d7-7b1e-da71dfc1cb4e@siemens.com>
 <CAAvDm6bP_zCABHDKwUXY6DW7q3=qhh=Fe2MiUfJbsvkyCaaJ7Q@mail.gmail.com>
 <80c4b4df-216d-8ba4-e787-de62b92de608@siemens.com>
In-Reply-To: <80c4b4df-216d-8ba4-e787-de62b92de608@siemens.com>
From: =?UTF-8?B?5a2Z5LiW6b6Z?= <sunshilong369@gmail.com>
Date: Sat, 11 Apr 2020 12:08:32 +0800
Message-ID: <CAAvDm6ZnTznX2w8tJpufOM3egrLzW-3ZkaqMtMzTO18P6mHZSQ@mail.gmail.com>
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
To: Jan Kiszka <jan.kiszka@siemens.com>, fino.meng@intel.com
Cc: xenomai <xenomai@xenomai.org>

Hi,
    I am using nouveau.The related log is listed below.
    GPU model is NVIDIA GeForce GT 650M which was manufactured 9 years
ago.I also do the same test on NVIDIA GK107M which was mentioned in last
letter.
    Sombody claims that they have killed the latency by using nouveau.
    While I using X11 on my laptop, the latency is still a problem.I have
modified the config file for X11 following the guideline on the xenomai
wifi.

Best regards.

sun@sun-Lenovo-IdeaPad-Y480:~$ lspci -nnk | grep -iA2 vga
00:02.0 VGA compatible controller [0300]: Intel Corporation 3rd Gen Core
processor Graphics Controller [8086:0166] (rev 09)
Subsystem: Lenovo 3rd Gen Core processor Graphics Controller [17aa:3977]
Kernel driver in use: i915
--
01:00.0 VGA compatible controller [0300]: NVIDIA Corporation GK107M
[GeForce GT 650M] [10de:0fd1] (rev a1)
Subsystem: Lenovo GK107M [GeForce GT 650M] [17aa:3977]
Kernel driver in use: nouveau
sun@sun-Lenovo-IdeaPad-Y480:~$


joy@joy-Lenovo-IdeaPad-Y480:~$ lspci -nnk | grep -iA2 vga
00:02.0 VGA compatible controller [0300]: Intel Corporation 3rd Gen Core
processor Graphics Controller [8086:0166] (rev 09)
Subsystem: Lenovo 3rd Gen Core processor Graphics Controller [17aa:3977]
Kernel driver in use: i915
--
01:00.0 VGA compatible controller [0300]: NVIDIA Corporation GK107M
[GeForce GT 650M] [10de:0fd1] (rev a1)
Subsystem: Lenovo GK107M [GeForce GT 650M] [17aa:3977]
Kernel driver in use: nouveau
joy@joy-Lenovo-IdeaPad-Y480:~$

Jan Kiszka <jan.kiszka@siemens.com> =E4=BA=8E2020=E5=B9=B44=E6=9C=889=E6=97=
=A5=E5=91=A8=E5=9B=9B =E4=B8=8A=E5=8D=8812:41=E5=86=99=E9=81=93=EF=BC=9A

> On 08.04.20 15:13, =E5=AD=99=E4=B8=96=E9=BE=99 wrote:
> > Hi,
> >        I could not catch your idea about the GPU usage patterns. How
> > could I acquire this information?
> >        My laptop model is Dell Latitude 5501 runing over ubuntu 14.04
> > system.
> >        GPU model information=EF=BC=9A NVIDIA GeForce MX150.
> >
>
> NVIDIA... using their close-source driver or nouveau?
>
> It's been a long time I ran that on a Xenomai box, I only vaguely
> remember that there used to be issues with lengthy cache flushes when
> data is pushed to RAM in order to make it visible to the GPU.
>
> Jan
>
> >       Best regards.
> >
> > Jan Kiszka <jan.kiszka@siemens.com <mailto:jan.kiszka@siemens.com>> =E4=
=BA=8E
> > 2020=E5=B9=B44=E6=9C=888=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=885=
:05=E5=86=99=E9=81=93=EF=BC=9A
> >
> >     On 08.04.20 10:39, =E5=AD=99=E4=B8=96=E9=BE=99 via Xenomai wrote:
> >      > Hi,
> >      >      Why X11 influences the latency of xenomai=EF=BC=9FI guess i=
t has
> >     some relation
> >      > to GPU.Could you make me more clearly?
> >      >      I have solved the latency . I am using QT runing on linux
> >     framebuffer
> >      > ,disabled X11 at all.I really hope to why  X11 influences the
> >     latency of
> >      > xenomai
> >
> >     It's not X11, it's the side effects of certain GPU usage patterns o=
n
> >     your particular platform. Can you specify more details about both?
> >
> >     Jan
> >
> >     --
> >     Siemens AG, Corporate Technology, CT RDA IOT SES-DE
> >     Corporate Competence Center Embedded Linux
> >
>
>
> --
> Siemens AG, Corporate Technology, CT RDA IOT SES-DE
> Corporate Competence Center Embedded Linux
>
