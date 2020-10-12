MIME-Version: 1.0
References: <DDED34AC-1834-4932-B053-AD8EEF810205@gmail.com>
 <CAFc1U0uqCWknFJj1FFMk2Ge7XEH1nRUwXek2Ay7nvmBXh03nqg@mail.gmail.com>
 <DD8FF5D6-AF88-4EAB-9E9D-3BA4B9B57CEA@gmail.com>
 <c137965c-cb45-2b9a-2795-3b1343f0e55a@qmul.ac.uk>
 <01d38a9b-da56-6877-5508-9444bff5829d@qmul.ac.uk>
 <B6F97522-9F76-4D2F-83B5-F992853C6236@gmail.com>
 <751ccaf8-b483-0e31-1620-e77447d35380@siemens.com>
 <CAMCM02vu1-WU+yZ+j-y1EqAykOPNOp6=DZRoHewbzMOka4k3oQ@mail.gmail.com>
 <8b1fea38-7c34-2f9f-991e-7a889e086c46@siemens.com>
 <4C9E87FD-F2E3-4AFC-A843-E843EDB82753@gmail.com>
 <378ebb75-e39a-0e38-0795-3322e799b8cc@siemens.com>
In-Reply-To: <378ebb75-e39a-0e38-0795-3322e799b8cc@siemens.com>
From: Deniz Ugur <deniz343@gmail.com>
Date: Mon, 12 Oct 2020 16:05:31 +0300
Message-ID: <CAMCM02sNoYfTqH=qBgOGKRM7M16TAtQhbw2dbqJN91f4psrSXw@mail.gmail.com>
Subject: Re: RTnet on Raspberry Pi 3B+
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
Cc: Giulio Moro <g.moro@qmul.ac.uk>, xenomai <xenomai@xenomai.org>

Yes, I was looking for interactive editing but that's okay. Thanks for the
clarification.

Take care.
Deniz.

On Mon, Oct 12, 2020, 15:57 Jan Kiszka <jan.kiszka@siemens.com> wrote:

> On 12.10.20 12:56, Deniz U=C4=9Fur wrote:
> > Yes that=E2=80=99s correct. I might be not clear enough, I meant how co=
uld I
> > modify the config options similar to =E2=80=9Cmake menuconfig=E2=80=9D
>
> Assuming you are talking about the kernel config used by xenomai-images:
> You can edit the one shipped with the layer (see
> recipes-kernel/linux/files) or add a config snippet (*.cfg file
> containing deviating options). That can be done in-place (patching the
> layer) or by putting a layer on top that overrides the config. There not
> interactive editing support, though, if that is what you are looking for.
>
> Jan
>
> >
> > Thanks.
> > Deniz.
> >
> >> On 12 Oct 2020, at 13:51, Jan Kiszka <jan.kiszka@siemens.com
> >> <mailto:jan.kiszka@siemens.com>> wrote:
> >>
> >> On 12.10.20 12:46, Deniz Ugur wrote:
> >>> Thanks Jan. Without going more off-topic, may I ask you how would one
> >>> configure the config using xenomai-images?
> >>>
> >>
> >> If you look at the readme, it suggest to build like this e.g.:
> >>
> >> kas-docker --isar build kas.yml:board-qemu-amd64.yml
> >>
> >> To build for latest xenomai-next, you would do
> >>
> >> kas-docker --isar build
> kas.yml:board-qemu-amd64.yml:opt-xenomai-next.yml
> >>
> >> Jan
> >>
> >>> Thanks.
> >>>
> >>>
> >>> On Mon, Oct 12, 2020, 13:36 Jan Kiszka <jan.kiszka@siemens.com
> >>> <mailto:jan.kiszka@siemens.com>
> >>> <mailto:jan.kiszka@siemens.com>> wrote:
> >>>
> >>>    On 12.10.20 01:18, Deniz U=C4=9Fur via Xenomai wrote:
> >>>> Hi Giulio,
> >>>>
> >>>> Thanks for your detailed response. I=E2=80=99ve checked all of the l=
inks
> >>>    you sent. They helped me a lot.
> >>>>
> >>>> Do you know if xenomai-images pulls master head?
> >>>> I believe CONFIG_XENO_DRIVERS_SPI_OMAP2_MCSPI_RT is just added on
> >>>    January. So I couldn=E2=80=99t be sure if it builds the kernel con=
taining
> >>>    this commit.
> >>>>
> >>>
> >>>    If you append ":opt-xenomai-next.yml", Xenomai will be built from
> the
> >>>    next branch. By default, the last release is used.
> >>>
> >>>    Jan
> >>>
> >>>> Thank you.
> >>>> Deniz.
> >>>>
> >>>>> On 12 Oct 2020, at 01:03, Giulio Moro <g.moro@qmul.ac.uk
> >>>>> <mailto:g.moro@qmul.ac.uk>
> >>>    <mailto:g.moro@qmul.ac.uk>> wrote:
> >>>>>
> >>>>> I should have mentioned that you can also build an Isar image for
> >>>    the BBB with Xenomai from here
> >>>    https://gitlab.denx.de/Xenomai/xenomai-images
> >>>>>
> >>>>> Giulio Moro wrote:
> >>>>>> You can download a working Debian image with Xenomai that runs
> >>>    on BB here
> https://github.com/BelaPlatform/bela-image-builder/releases
> >>>>>> This contains Linux 4.14.108-ti-xenomai-r135 with Xenomai 3.0.10
> >>>>>> The kernel is built from this branch
> >>>
> https://github.com/RobertCNelson/ti-linux-kernel-dev/tree/ti-linux-xenoma=
i-4.14.y
> >>>>>> I haven't tried RTDM SPI, but there seems to be a driver for it:
> >>>
> https://gitlab.denx.de/Xenomai/xenomai/-/blob/master/kernel/drivers/spi/s=
pi-omap2-mcspi-rt.c
> >>>>>> Deniz U=C4=9Fur via Xenomai wrote:
> >>>>>>> Hi Pierre,
> >>>>>>>
> >>>>>>> I=E2=80=99ve just checked out BeagleBone Black and it seems appli=
cable
> >>>    for me. If you don=E2=80=99t mind I have some follow-up questions.
> >>>>>>>
> >>>>>>> Do you know if RTDM SPI works on BB?
> >>>>>>> Which ipipe, xenomai, and linux version combination is working
> >>>    on the BB right now?
> >>>>>>> Are there any recent guides for Xenomai 3 on BB?
> >>>>>>>
> >>>>>>> Thanks.
> >>>>>>> Deniz.
> >>>>>>>
> >>>>>>>> On 11 Oct 2020, at 20:39, Pierre FICHEUX
> >>>    <pierre.ficheux@smile.fr
> >>> <mailto:pierre.ficheux@smile.fr> <mailto:pierre.ficheux@smile.fr>>
> wrote:
> >>>>>>>>
> >>>>>>>> Hi,
> >>>>>>>>
> >>>>>>>> Pi Ethernet controller is based on USB, not that good for
> >>>    realtime (AMHA)...
> >>>>>>>>
> >>>>>>>> May you could switch to BeagleBone Black ?
> >>>>>>>>
> >>>>>>>> regards
> >>>>>>>>
> >>>>>>>> Le sam. 10 oct. 2020 =C3=A0 10:21, Deniz U=C4=9Fur via Xenomai
> >>>    <xenomai@xenomai.org
> >>> <mailto:xenomai@xenomai.org> <mailto:xenomai@xenomai.org>
> >>>    <mailto:xenomai@xenomai.org <mailto:xenomai@xenomai.org>>> a =C3=
=A9crit
> :
> >>>>>>>> Hello all,
> >>>>>>>>
> >>>>>>>> I=E2=80=99m currently researching for a real-time sensor data
> >>>    acquisition system and I was thinking about using Raspberry Pi 3B+=
.
> >>>    Along with my move to making everything real-time, I also want to
> >>>    experiment with RTnet. Although from what I can understand, RPi=E2=
=80=99s
> >>>    ethernet module is not supported in RTnet.
> >>>>>>>>
> >>>>>>>> Is RPi not supported in RTnet? If not, is there anything I can
> >>>    do to bring this feature?
> >>>>>>>> Do I have any alternative for making TCP socket connection
> >>>    real-time using Xenomai on RPi?
> >>>>>>>> Lastly, If RPi is an impossible target for RTnet, do we have
> >>>    any alternative embedded system that works with RTnet?
> >>>>>>>>
> >>>>>>>> Thanks in advance.
> >>>>>>>> Deniz.
> >>>>>>>>
> >>>>>>>> Some important details:
> >>>>>>>> ARCH: ARM
> >>>>>>>> SoC: BCM2835
> >>>>>>>> Linux: 4.14.36
> >>>>>>>> Xenomai: 3.0.7
> >>>>>>>> I-Pipe: 4.14.36-arm-1
> >>>>>>>>
> >>>>>>>>
> >>>>>>>> --
> >>>>>>>> Pierre FICHEUX -/- CTO Smile ECS, France -\-
> >>>    pierre.ficheux@smile.fr
> >>> <mailto:pierre.ficheux@smile.fr> <mailto:pierre.ficheux@smile.fr>
> >>>    <mailto:pierre.ficheux@smile.fr <mailto:pierre.ficheux@smile.fr>>
> >>>>>>>>                                http://www.smile.fr/
> >>>    <http://www.smile.fr/>
> >>>>>>>>
> >>>     https://smile.eu/fr/offres/embarque-iot
> >>>    <https://smile.eu/fr/offres/embarque-iot>
> >>>>>>>> I would love to change the world, but they won't give me the
> >>>    source code
> >>>>>>>
> >>>>
> >>>
> >>>    --
> >>>    Siemens AG, T RDA IOT
> >>>    Corporate Competence Center Embedded Linux
> >>>
> >>
> >>
> >> --
> >> Siemens AG, T RDA IOT
> >> Corporate Competence Center Embedded Linux
> >
>
