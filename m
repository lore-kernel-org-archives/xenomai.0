MIME-Version: 1.0
References: <CAF_6Maz771xdyW4j3Cs7uOpo61SJ_pqq6YvOOgaYnE+Hrc+Jbg@mail.gmail.com>
 <af70dd6489c242c3858b7d089a25707d@intel.com>
 <CAF_6Max5yA+mh1ejwVu_Bg5dKr1tnaY2TYUTQQYEnCgpqLUYNw@mail.gmail.com>
 <12b763460ec5434aa92ba46320489bd2@intel.com>
In-Reply-To: <12b763460ec5434aa92ba46320489bd2@intel.com>
From: gopi ratnakaram <gopi.ratnakaram@svayarobotics.com>
Date: Fri, 24 Apr 2020 13:13:45 +0530
Message-ID: <CAF_6MayeRyBLzPtr-WN6crY+Uf-iBALjmt8gHdsosQymCG+=eQ@mail.gmail.com>
Subject: Re: Regarding Xenomai patch installation on Live USB
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
To: "Meng, Fino" <fino.meng@intel.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>, "Pu,
 Yanfeng" <yanfeng.pu@intel.com>

Dear Fino,

After doing all of the steps mentioned in the following link,

https://github.com/intel/linux-stable-xenomai/wiki/Guide-

the following error I am getting during testing on my C246P chipset based
industrial motherboard loaded with Ubuntu18.04.

$ sudo /opt/xenomai-3.1/bin/latency
   0"000.000| BUG in low_init(): [main] Cobalt core not enabled in kernel

Is there any installation related issue and how can I resolve this issue?

I tried the same in my laptop loaded  with Ubuntu 16.04, I didn't face any
issue and everything works fine. I am also checking with a laptop loaded
with Ubuntu 18.04.

I am totally confused that this issue is  with the motherboard or Ubuntu
version?


--best regards,
R Gopi Krishna,


On Mon, Apr 20, 2020 at 4:17 PM Meng, Fino <fino.meng@intel.com> wrote:

>
> >
> >Thank you for your email response Fino.
> >
> >Maybe due to 4.9.* is too far away from Ubuntu 1804's original kernel;
> What will be the issue in this case? Due to any hardware
> >driver dependency causing this issue?
> >
> >We make this repo for convenience, Kernel version is 4.19.59 with some
> Intel BSP patches.
> >working good on Ubuntu 1804; but didn't make it on Live USB yet,
> https://github.com/intel/linux-stable-xenomai/wiki/Guide-
> >of-Xenomai-Build-and-Installation-on-Top-of-Ubuntu
> >
> >
> >Is there any restriction to use the Xenomai on live USB or can I proceed
> and install using the steps provided by you?
> >
>
> We didn't study it yet, we internally build out live USB image from
> yocto/bitbake based codebase; u can try,
>
> >
> >One more thing is I am trying to install this on a specific motherboard
> of industrial grade which is based on a c246p chipset and
> >core i7 6 core processor (i7 8700). Will my hardware cause any issue.
> Because I have installed Xenomai on different PCs and
> >Laptops multiple times and never faced any issue.
>
> We have seen 4.9.* working on newest WHL-U and other platform; the thing
> is if it fail to boot any certain machine,
> It take time to debug, u may need a serial port to printout boot log to
> speed up the debug process.
>
> >
> >--thanks & regards,
> >R Gopi Krishna
> >
> >
> >
> >On Mon, Apr 20, 2020 at 10:57 AM Meng, Fino <fino.meng@intel.com <mailto=
:
> fino.meng@intel.com> > wrote:
> >
> >
> >
> >       >
> >       >Dear team members,
> >       >
> >       >I tried installing the Xenomai patch on live USB loaded with
> Ubuntu 18.04.
> >       >I have patched kernel version 4.9.38 and tried to boot the
> Xenomai patched one. When I try to boot my motherboard
> >it is
> >       >unable to boot. Can I install the Xenomai patch on Live USB? Wha=
t
> is causing this problem?
> >       >
> >       >--best regards,
> >       >R Gopi Krishna,
> >
> >
> >       Maybe due to 4.9.* is too far away from Ubuntu 1804's original
> kernel;
> >       We make this repo for convenience, Kernel version is 4.19.59 with
> some Intel BSP patches.
> >       working good on Ubuntu 1804; but didn't make it on Live USB yet,
> >
> https://github.com/intel/linux-stable-xenomai/wiki/Guide-of-Xenomai-Build=
-and-Installation-on-Top-of-Ubuntu
> >
> >       BR / Fino (=E5=AD=9F=E7=A5=A5=E5=A4=AB)
> >       Intel =E2=80=93 IOTG Developer Enabling
> >
>
>
> BR / Fino (=E5=AD=9F=E7=A5=A5=E5=A4=AB)
> Intel =E2=80=93 IOTG Developer Enabling
>
>
