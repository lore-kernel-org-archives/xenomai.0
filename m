From: =?utf-8?q?Fran=C3=A7ois_Legal?= <devel@thom.fr.eu.org>
In-Reply-To: <7a487933-dd50-6ee9-cd5f-6d99bc5b3c76@siemens.com>
Content-Type: text/plain; charset="utf-8"
Date: Mon, 24 Aug 2020 11:44:39 +0200
MIME-Version: 1.0
Message-ID: <1174-5f438c00-25-37e14c00@201457175>
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
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai@xenomai.org

Le Vendredi, Ao=C3=BBt 21, 2020 20:04 CEST, Jan Kiszka <jan.kiszka@siem=
ens.com> a =C3=A9crit: 
 
> On 20.08.20 15:46, Fran=C3=A7ois Legal via Xenomai wrote:
> > Using RTNet with multiple interfaces, xenomai 3.1 with linux 4.4
> > Whenever a posix RT thread calls recvmsg (), I get this error.
> > 
> > I could track this down to line 422 in udp.c :     msg =3D rtnet=5F=
get=5Farg(fd, &=5Fmsg, u=5Fmsg, sizeof(=5Fmsg));
> > 
> > If I disassemble the kernel, the failing instruction (at 0x80272444=
) is a nop in arm=5Fcopy=5Ffrom=5Fuser
> > Am I doing anything wrong ?
> 
> Maybe you are passing an invalid pointer to recvmsg, directly or in i=
ts
> message structures. That would cause an exception which is fixed up b=
ut
> also reported. Do you get an error in return?
> 

So, I checked, and the same happens on calls to sendto ().
I doubt the pointer passed is invalid, as I don't get that kind of prob=
lems with 3.0.9.
Upon return from recvmsg or sendto, I get -1 with errno set to 14.
Also, I checked in ipipe=5Fbase.h, exception #0 seem to be an instructi=
on/data access exception, which seems very weird to me for a NOP instru=
ction that does not appear to be on a line/page boundary.

Fran=C3=A7ois

> Jan
> 
> -- 
> Siemens AG, Corporate Technology, CT RDA IOT SES-DE
> Corporate Competence Center Embedded Linux


