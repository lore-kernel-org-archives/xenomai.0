From: =?utf-8?q?Fran=C3=A7ois_Legal?= <devel@thom.fr.eu.org>
In-Reply-To: <1174-5f744680-45-37e14c00@201458627>
Content-Type: text/plain; charset="utf-8"
Date: Wed, 30 Sep 2020 17:14:06 +0200
MIME-Version: 1.0
Message-ID: <1174-5f74a080-4b-37e14c00@201458726>
Subject: =?utf-8?q?Re=3A?= Strange switching =?utf-8?q?=5Bthreadname=5D?= to 
 secondary mode after exception #0 in kernel-space at 0x80272444
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

So the problem here lies in the calls to rtnet=5Fget=5Farg(fd, &=5Fmsg,=
 msg, sizeof(*msg)); in af=5Fpacket.c sendmasg/recvmsg

The only explanation I could find was that, for my architecture (32bit =
ARMv7), syscall use the COBALT=5FSYSCALL32emu variants for sendmsg/recv=
msg calls, which in turn allocate a struct user=5Fmsghdr on the SVC sta=
ck, then calls rt=5Fpacket=5Fsendmsg/rt=5Fpacket=5Frecvmsg with the add=
ress of that struct.

Then, rtnet=5Fget=5Farg would invoke arm=5Fcopy=5Ffrom=5Fuser, which, w=
ith SPECTRE mitigation turned on (you normally can't disable this by co=
nfiguration), would check that the source pointer is in the userland me=
mory area, and hence fail in my case.

Going from there, except disabling SPECTRE mitigation, I'm not sure how=
 I can fix this.

Fran=C3=A7ois

Le Mercredi, Septembre 30, 2020 10:48 CEST, Fran=C3=A7ois Legal via Xen=
omai <xenomai@xenomai.org> a =C3=A9crit: 
 
> I might have found what is causing this problem : CONFIG=5FCPU=5FSPEC=
TRE
> 
> It was the noticeable difference between my last (4.4.189) kernel rel=
ease not showing this problem, and the next I tried (4.4.227).
> If I modify the Kconfig to disable CPU=5FSPECTRE, the problem does no=
t show up anymore.
> 
> I'll dig a little deeper into that now.
> 
> Fran=C3=A7ois
> 
> Le Mercredi, Septembre 30, 2020 08:42 CEST, Fran=C3=A7ois Legal <fran=
cois.legal@thom.fr.eu.org> a =C3=A9crit: 
>  
> > So I decided to dig a little deeper in this problem, and found out =
that it is not xenomai3.1 specific.
> > I tried with xenomai-3.0.9 and linux 4.4.227 -> same problem.
> > I thought it might be a matter of ipipe patch not quite fit to 4.4.=
227, so I decided to try with latest ipipe-4.4.y-cip from git and xenom=
ai 3.0.9, but the same problem happens.
> > 
> > Fran=C3=A7ois
> > 
> > Le Vendredi, Septembre 25, 2020 18:11 CEST, Fran=C3=A7ois Legal via=
 Xenomai <xenomai@xenomai.org> a =C3=A9crit: 
> >  
> > > Sorry to come back so late on that topic.
> > > I took some time to write a simple test program, which is attache=
d.> > 
> > > Config is as follows :
> > > xenomai-3.1
> > > linux-4.4.227
> > > 
> > > Fran=C3=A7ois
> > > 
> > > Le Vendredi, Ao=C3=BBt 21, 2020 20:04 CEST, Jan Kiszka <jan.kiszk=
a@siemens.com> a =C3=A9crit: 
> > >  
> > > > On 20.08.20 15:46, Fran=C3=A7ois Legal via Xenomai wrote:
> > > > > Using RTNet with multiple interfaces, xenomai 3.1 with linux =
4.4
> > > > > Whenever a posix RT thread calls recvmsg (), I get this error=
.
> > > > > 
> > > > > I could track this down to line 422 in udp.c :     msg =3D rt=
net=5Fget=5Farg(fd, &=5Fmsg, u=5Fmsg, sizeof(=5Fmsg));
> > > > > 
> > > > > If I disassemble the kernel, the failing instruction (at 0x80=
272444) is a nop in arm=5Fcopy=5Ffrom=5Fuser
> > > > > Am I doing anything wrong ?
> > > > 
> > > > Maybe you are passing an invalid pointer to recvmsg, directly o=
r in its
> > > > message structures. That would cause an exception which is fixe=
d up but
> > > > also reported. Do you get an error in return?
> > > > 
> > > > Jan
> > > > 
> > > > -- 
> > > > Siemens AG, Corporate Technology, CT RDA IOT SES-DE
> > > > Corporate Competence Center Embedded Linux
> > > -------------- next part --------------
> > > A non-text attachment was scrubbed...
> > > Name: test-net.c
> > > Type: application/octet-stream
> > > Size: 6141 bytes
> > > Desc: not available
> > > URL: <http://xenomai.org/pipermail/xenomai/attachments/20200925/f=
745e32f/attachment.obj>
> >
> 
>


