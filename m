MIME-Version: 1.0
Sender: had2006@gmail.com
In-Reply-To: <54F60911.6040402@xenomai.org>
References: <CANWkrRPBG=3+k4GkcrMEO4fBb=tmvn+XKRR6t8S+p+r_ffm6vg@mail.gmail.com>
 <54EB4E8E.8040804@xenomai.org>
 <CAB+DZ3=s-pHrt=U_YN5qYo7Vtic9f-WfQQBwK3znBTdN_iVOmw@mail.gmail.com>
 <54EC8CBD.6000500@xenomai.org>
 <CAB+DZ3=cB3URuV57Pa5g3fHkvuPyeKza_-8UYJkqvP8Ruj45hQ@mail.gmail.com>
 <54F47A0B.7090900@xenomai.org> <54F5D34A.90005@xenomai.org>
 <54F5D75D.9090009@xenomai.org> <54F60911.6040402@xenomai.org>
Date: Tue, 3 Mar 2015 19:29:19 +0000
Message-ID: <CAKk99t3vGjuXdBTmRVxTzAZ0=cEg1S9h7ZBQ+Ed7JH4=1JMZcQ@mail.gmail.com>
From: Helder Daniel <hdaniel@ualg.pt>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Failed testsuite/latency
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Michael Smith <2michael.smith@gmail.com>, "Xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,

I Tried to access the patch as I have the same problem when running latency
on cobalt:

http://download.gna.org/adeos/patches/v3.x/x86/ipipe-core-3.16-x86-3.patch

but is not accessible:

You don't have permission to access
/adeos/patches/v3.x/x86/ipipe-core-3.16-x86-3.patch on this server.


On 3 March 2015 at 19:18, Philippe Gerum <rpm@xenomai.org> wrote:

> On 03/03/2015 04:46 PM, Philippe Gerum wrote:
> > On 03/03/2015 04:29 PM, Philippe Gerum wrote:
> >> On 03/02/2015 03:56 PM, Philippe Gerum wrote:
> >>> On 02/25/2015 09:33 AM, Bart Vissers wrote:
> >>>> Hi Philippe,
> >>>>
> >>>> Before making any changes, I ran xeno-config --info:
> >>>> Xenomai version: Xenomai/cobalt v3.0-rc3 --
> >>>> Linux rtpc 3.16.7-xenomai-3.0-rc3 #1 SMP Mon Feb 23 12:30:46 CET 201=
5
> >>>> i686 GNU/Linux
> >>>> Kernel parameters: BOOT_IMAGE=3D/boot/vmlinuz-3.16.7-xenomai-3.0-rc3
> >>>> root=3DUUID=3D0925426e-e058-4093-963c-8b7de072e229 ro quiet
> >>>> I-pipe release #2 detected
> >>>> Cobalt core 3.0-rc3 detected
> >>>> Build args: --prefix=3D/usr --includedir=3D/usr/include/xenomai
> >>>> --mandir=3D/usr/share/man --with-testdir=3D/usr/lib/xenomai/testsuit=
e
> >>>> --build i486-linux-gnu build_alias=3Di486-linux-gnu
> >>>>
> >>>> namelist did not work, as latency does not contain any symbols. How
> >>>> can I include these when building debian packages?
> >>>>
> >>>> Unfortunately, I got compilation errors after applying the patch to
> >>>> xenomai-3.0-rc3: error: =E2=80=98XENO_WARNING=E2=80=99 undeclared (f=
irst use in this
> >>>> function)
> >>>> So I decided to repeat my steps with the git next branch, 52fb91e...
> >>>> So, same linux kernel, i-pipe patch and kernel config. Also included
> >>>> the printk patch. Output:
> >>>>
> >>>> =3D=3D Sampling period: 100 us
> >>>> =3D=3D Test mode: periodic user-mode task
> >>>> =3D=3D All results in microseconds
> >>>> warming up...
> >>>> latency: failed to set periodic, code 9
> >>>>
> ^C---|-----------|-----------|-----------|--------|------|---------------=
----------
> >>>> RTS|  10000.000|      0.000| -10000.000|       0|     0|
> 00:03:26/00:03:26
> >>>>
> >>>> Notice the ^C. I killed it because it was running indefinitely. This
> >>>> was also the case in my previous attempts.
> >>>>
> >>>>
> >>>
> >>> Can any of you send me the generated debian package privately? I woul=
d
> >>> also need to know the gcc version used.
> >>>
> >>
> >> Never mind, I could reproduce this bug eventually. This issue is due t=
o
> >> some register trashing at work in the pipeline code, not to the Xenoma=
i
> >> core. More later.
> >>
> >
> > This patch will fix this issue.
> >
> > diff --git a/arch/x86/kernel/entry_32.S b/arch/x86/kernel/entry_32.S
> > index 6e6b88a..e834437 100644
> > --- a/arch/x86/kernel/entry_32.S
> > +++ b/arch/x86/kernel/entry_32.S
> > @@ -517,6 +517,7 @@ sysenter_exit_fast:
> >       jmp sysenter_exit
> >  sysenter_exit_root:
> >       call __ipipe_root_sync
> > +     movl PT_EAX(%esp),%eax
> >       jmp sysenter_exit_check
> >  #endif
> >
>
> Now available from the download area:
> http://download.gna.org/adeos/patches/v3.x/x86/ipipe-core-3.16-x86-3.patc=
h
>
> and from the Xenomai GIT tree:
>
> http://git.xenomai.org/xenomai-3.git/commit/?h=3Dnext&id=3D51680b1d9b3b19=
93011da1ddf56b54c12e59d49d
>
> This patch is a drop in replacement for ipipe-core-3.16-x86-2 which is
> broken in 32bit mode.
>
> --
> Philippe.
>
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> http://www.xenomai.org/mailman/listinfo/xenomai
>



--=20
Helder Daniel
UALG - FCT
DEEI

http://w3.ualg.pt/~hdaniel
