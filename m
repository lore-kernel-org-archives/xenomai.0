Message-ID: <521F409D.4070507@siemens.com>
Date: Thu, 29 Aug 2013 14:37:49 +0200
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <CAMZj-5M0tr1Mqc7w10gTnfBwkHnY7xq87NOxNtc4TiPuX2_cvA@mail.gmail.com>
In-Reply-To: <CAMZj-5M0tr1Mqc7w10gTnfBwkHnY7xq87NOxNtc4TiPuX2_cvA@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Virtualization with Xenomai
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Asier Tamayo Arbide <atamayoarbide@gmail.com>
Cc: xenomai@xenomai.org

On 2013-08-29 13:06, Asier Tamayo Arbide wrote:
> Hello all,
>=20
> My embedded system has two boards running Linux: one runs the user
> interface and the other one the critical real-time tasks. Both boards a=
re
> running Xenomai on an Atom N270 chipset.
>=20
> Now, I am planning to compact my system in just one board and have two
> options. The first one is to execute everything using Xenomai and the
> second one is to port my user interface to Windows and to run both Wind=
ows
> and Xenomai on top of a hypervisor. My e-mail regards this second optio=
n.
>=20

Third option may be even more interesting (provided you really want to
use Windows for the UI): Run Xenomai on the host and combine it with KVM
to host another OS. This works fine with latest ipipe for 3.8 when RT
tasks and the QEMU process (that uses KVM) are on separate CPUs, I just
heard of issues (couldn't reproduce yet) when they share a CPU.

> I would like to know if anyone has any experience with this. Is the
> real-time response affected in any way when using a hypervisor? My curr=
ent
> kernel has been compiled using the ELinOS Embedded Linux distribution. =
Do I
> have to patch it?
>=20

Virtualizing your RT workload won't make things faster, naturally.
Depending on the hypervisor architecture and hardware capabilities, it
may not be measurable. But I would refrain from such stacking unless
there is a real need (which I do not see for your setup).

> I am studying Xen, VmWare, KVM and Enea. Do you recommend any of them? =
The
> board I=92ll use in the new (compact) system will support virtualizatio=
n
> extensions (Intel VT).

See above.

Jan

--=20
Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux

