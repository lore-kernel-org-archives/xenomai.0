MIME-Version: 1.0
Message-ID: <trinity-53dc1e63-7636-4227-a713-1b0df1055f18-1449576720185@3capp-webde-bap21>
From: "Jochen Behnke" <JK.Behnke@web.de>
Content-Type: text/plain; charset=UTF-8
Date: Tue, 8 Dec 2015 13:12:00 +0100
In-Reply-To: <20151208110546.GA22104@hermes.click-hack.org>
References: <trinity-3a616500-d86a-4f71-bb11-16fa1d6cf8a2-1448533977790@3capp-webde-bs12>
 <20151128064325.GC10399@hermes.click-hack.org>
 <trinity-4550a539-a311-4cb6-853e-f6f5fb983201-1448975385774@3capp-webde-bap47>
 <20151201181155.GC30041@hermes.click-hack.org>
 <trinity-8e5e4a49-df3c-4391-b1ce-b1bc4d77ffcc-1449061119000@3capp-webde-bs35>
 <trinity-edf656b8-4eef-4967-92eb-85856ad3f8bd-1449246268211@3capp-webde-bs27>
 <20151204163315.GD29398@hermes.click-hack.org> <5661E4D5.5010804@web.de>
 <20151204204107.GE29398@hermes.click-hack.org>
 <trinity-db1a9f17-84fe-4cd6-a77d-b6fe73d680a6-1449571352953@3capp-webde-bap21>,
 <20151208110546.GA22104@hermes.click-hack.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] "RT throttling" issue
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

> Gesendet: Dienstag, 08=2E Dezember 2015 um 12:05 Uhr
> Von: "Gilles Chanteperdrix" <gilles=2Echanteperdrix@xenomai=2Eorg>
> An: "Jochen Behnke" <JK=2EBehnke@web=2Ede>
> Cc: xenomai@xenomai=2Eorg
> Betreff: Re: [Xenomai] "RT throttling" issue
> On Tue, Dec 08, 2015 at 11:42:32AM +0100, Jochen Behnke wrote:
> > "ipipe_root_only" also occasionally has long delay times=2E
> > Is ipipe_root_only run when Linux is executing?
> > Is this critical?
> > See extract below=2E
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D start: extract =
from frozen file
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > : +func -420045+ 1=2E443 ipipe_root_only+0x4
> > (copy_to_user+0x31)
> > : +func -420044 0=2E260 __ipipe_syscall_root+0x5
> > (sysenter_past_esp+0x5b)
> > : +func -420043 0=2E200 sys_time+0x5
> > (sysenter_do_call+0x12)
> > : +func -420043 0=2E210 get_seconds+0x3
> > (sys_time+0xf)
> > : +func -420043! 3910=2E393 ipipe_root_only+0x4
> > (sys_time+0x1c)
> > :| +func -416132 0=2E651 __ipipe_handle_irq+0x5
> > (common_interrupt+0x2c)
>
> Hi,
>
> What you have here is a system call to the "time" function from a
> task scheduled by Linux scheduler=2E When the system call is finished,
> the system returns to user-space=2E ipipe_root_only happens to be the
> last function called before the return to user-space and before the
> next interrupt=2E ipipe_root_only gets then charged for the time spent
> in user-space=2E
>
> What version of the I-pipe patch are you using on which
> architecture? On some architectures we try to create trace points
> when entering and leaving the kernel to avoid this issue (with the
> added benefit that the user-space value of the PC gets printed, this
> may be useful if you have an infinite loop)=2E
Xenomai:      2=2E6=2E4 githead
Architecture: x86
Platform:     Atom E640/E660
I-pipe patch: ipipe-core-3=2E8=2E13-x86-4=2Epatch


Regards
Jochen
=C2=A0
=C2=A0

