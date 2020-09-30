From: =?utf-8?q?Fran=C3=A7ois_Legal?= <devel@thom.fr.eu.org>
In-Reply-To: <1175-5f742900-ab-25a5a500@198940470>
Content-Type: text/plain; charset="utf-8"
Date: Wed, 30 Sep 2020 10:48:39 +0200
MIME-Version: 1.0
Message-ID: <1174-5f744680-45-37e14c00@201458627>
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
Cc: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@xenomai.org

I might have found what is causing this problem : CONFIG=5FCPU=5FSPECTR=
E

It was the noticeable difference between my last (4.4.189) kernel relea=
se not showing this problem, and the next I tried (4.4.227).
If I modify the Kconfig to disable CPU=5FSPECTRE, the problem does not =
show up anymore.

I'll dig a little deeper into that now.

Fran=C3=A7ois

Le Mercredi, Septembre 30, 2020 08:42 CEST, Fran=C3=A7ois Legal <franco=
is.legal@thom.fr.eu.org> a =C3=A9crit: 
 
> So I decided to dig a little deeper in this problem, and found out th=
at it is not xenomai3.1 specific.
> I tried with xenomai-3.0.9 and linux 4.4.227 -> same problem.
> I thought it might be a matter of ipipe patch not quite fit to 4.4.22=
7, so I decided to try with latest ipipe-4.4.y-cip from git and xenomai=
 3.0.9, but the same problem happens.
> 
> Fran=C3=A7ois
> 
> Le Vendredi, Septembre 25, 2020 18:11 CEST, Fran=C3=A7ois Legal via X=
enomai <xenomai@xenomai.org> a =C3=A9crit: 
>  
> > Sorry to come back so late on that topic.
> > I took some time to write a simple test program, which is attached.=

> > 
> > Config is as follows :
> > xenomai-3.1
> > linux-4.4.227
> > 
> > Fran=C3=A7ois
> > 
> > Le Vendredi, Ao=C3=BBt 21, 2020 20:04 CEST, Jan Kiszka <jan.kiszka@=
siemens.com> a =C3=A9crit: 
> >  
> > > On 20.08.20 15:46, Fran=C3=A7ois Legal via Xenomai wrote:
> > > > Using RTNet with multiple interfaces, xenomai 3.1 with linux 4.=
4
> > > > Whenever a posix RT thread calls recvmsg (), I get this error.
> > > > 
> > > > I could track this down to line 422 in udp.c :     msg =3D rtne=
t=5Fget=5Farg(fd, &=5Fmsg, u=5Fmsg, sizeof(=5Fmsg));
> > > > 
> > > > If I disassemble the kernel, the failing instruction (at 0x8027=
2444) is a nop in arm=5Fcopy=5Ffrom=5Fuser
> > > > Am I doing anything wrong ?
> > > 
> > > Maybe you are passing an invalid pointer to recvmsg, directly or =
in its
> > > message structures. That would cause an exception which is fixed =
up but
> > > also reported. Do you get an error in return?
> > > 
> > > Jan
> > > 
> > > -- 
> > > Siemens AG, Corporate Technology, CT RDA IOT SES-DE
> > > Corporate Competence Center Embedded Linux
> > -------------- next part --------------
> > A non-text attachment was scrubbed...
> > Name: test-net.c
> > Type: application/octet-stream
> > Size: 6141 bytes
> > Desc: not available
> > URL: <http://xenomai.org/pipermail/xenomai/attachments/20200925/f74=
5e32f/attachment.obj>
>


