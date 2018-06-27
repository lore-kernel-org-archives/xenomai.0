MIME-Version: 1.0
References: <CAOuPNLg60S+am654fq55vTMoFV1=PfMp3as5MZtt5BHUacFRBQ@mail.gmail.com>
 <2ee8fa04-7ad4-58d5-603b-1d41ad2533ec@siemens.com>
 <CAOuPNLiE-Fy3LJrozgsLE9ga0ibC+GOSHO6ciJppU_bnZtbx0g@mail.gmail.com>
 <73a5c9f6-5014-5113-1ddd-2fcf974273bb@siemens.com>
 <CAOuPNLjuB53ovnEBijNSqrgsKYcSGjLM-L=J4mfbRogwo_5kVA@mail.gmail.com>
 <CAOuPNLh2C8b1KC5D6+Lws_1UA0o0Sp_BaPb3mUTyebUPq_EduA@mail.gmail.com>
 <CAOuPNLiCfmUrDMWyX=N37hVJTBDEqwOtoOr1srf-55ks1qms+w@mail.gmail.com>
 <513744ad-f8fe-d54e-0618-fad492ed5bff@siemens.com>
 <5f46f00c-f09b-7439-93cf-4ff2a0343974@siemens.com>
 <6da8a3e2-7a76-afb2-c46c-7c173a8e444c@siemens.com>
 <CAOuPNLhYPGrP5s0y6e9HFUVrg2aDochOxF_fMkbjTmYnEvPOQQ@mail.gmail.com>
 <CAOuPNLjXN531P13WddSAQ-ZmnNOF_EQ4R+3eZ09VtG5zNvUH0g@mail.gmail.com>
 <aaa3a49e-ae7f-1696-199b-4ade86bd503f@siemens.com>
 <CAOuPNLi-p3A9LvkbpAVDapjN-dKgD8hJ3RJwJV+P=FvK2Pa7SA@mail.gmail.com>
 <8e8bd751-89b5-7006-a791-ae464838f5ed@siemens.com>
 <CAOuPNLh6ShYRG3E1Q+uad4phS3+QEtogzzu6RQpLz=N4qVQX1Q@mail.gmail.com>
 <b15f32c2-9bbc-c2f6-e65d-7331c0bc790a@siemens.com>
 <CAOuPNLiD8-WgbQYcZwzJPgp8XJXJFmzAxygEP9+ZsyCBQv--pA@mail.gmail.com>
 <CALLqZ8RxwJgP3ekWfJt-hGtxPY040p5rXW9DTGYDZfo=o8=3SA@mail.gmail.com>
In-Reply-To: <CALLqZ8RxwJgP3ekWfJt-hGtxPY040p5rXW9DTGYDZfo=o8=3SA@mail.gmail.com>
From: Pintu Kumar <pintu.ping@gmail.com>
Date: Wed, 27 Jun 2018 22:59:19 +0530
Message-ID: <CAOuPNLhFtzOGFX-pJ63Y520c+TnQ7qRGtvg05e6F4JybdwFoaQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Xenomai] Kernel oops during rtnet loopback usage on x86_64
	(e1000e)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Greg Gallagher <greg@embeddedgreg.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, "Xenomai@xenomai.org" <xenomai@xenomai.org>

On Wed, Jun 27, 2018 at 10:47 PM Greg Gallagher <greg@embeddedgreg.com> wrote:
>
> I don't think Beaglebone is supported currently in RTNet.
>

But I am just checking loopback interface with 127.0.0.1
I hope that should work on all boards and arch, even without
installing the net driver.

> On Wed, Jun 27, 2018 at 1:13 PM, Pintu Kumar <pintu.ping@gmail.com> wrote:
> > On Wed, Jun 27, 2018 at 9:47 PM Jan Kiszka <jan.kiszka@siemens.com> wrote:
> >>
> >> On 2018-06-27 16:12, Pintu Kumar wrote:
> >> >> With nosmap, that particular issue should no longer occur (at least as
> >> >> long as we can ask the kernel for this relaxation), so I suspect the
> >> >> other effect you see now is something else.
> >> >
> >> > Just for the information, that issue occurred even on Beagle bone, and
> >> > there is no smap on arm.
> >> > However, it works on virtual box. how ?
> >>
> >> Does it work when you go back to Xenomai 3.0.6? Then it would be a
> >> regression of the copy-to/from-userspace improvements done after that
> >> release, you could start bisecting which commit introduced it.
> >>
> >
> > Nope, I never had success with rtnet on arm architecture (mainly
> > beagle bone), even with the old 3.0.6.
> > At least earlier, on x86_64 (SkyLake), I saw the loopback part working
> > with 3.0.6 and my old xenomai kernel 4.9.51 (without those rtnet
> > fixes) and with "nosmap" in commandline.
> >
> > But now it looks like the situation becomes more worse.
> > I will have to freshly look into it, but since I use prepare_kernel to
> > apply as single patch, it might be painful to bisect it.
> > Will try to find the root cause though....
> >
> > Hoping for the best...
> >
> >> But I'm not sure right now if there isn't something similar to smap
> >> (then just without a knob to turn it off) in the ARM architecture as well...
> >>
> >> Jan
> >>
> >> --
> >> Siemens AG, Corporate Technology, CT RDA IOT SES-DE
> >> Corporate Competence Center Embedded Linux
> >
> > _______________________________________________
> > Xenomai mailing list
> > Xenomai@xenomai.org
> > https://xenomai.org/mailman/listinfo/xenomai

