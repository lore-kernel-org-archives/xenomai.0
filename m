Subject: Re: numa stress test - Intel j1900
References: <889a60a9-922b-de10-f5fa-94c23ca38a2e@numalliance.com>
From: Jan Kiszka <jan.kiszka@web.de>
Message-ID: <2ad6493a-0d97-c010-254c-8ab8b1c387f1@web.de>
Date: Tue, 14 May 2019 09:21:39 +0200
MIME-Version: 1.0
In-Reply-To: <889a60a9-922b-de10-f5fa-94c23ca38a2e@numalliance.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?Q?St=c3=a9phane_Ancelot?= <sancelot@numalliance.com>, Xenomai <xenomai@xenomai.org>

On 10.05.19 14:51, St=C3=A9phane Ancelot via Xenomai wrote:
> Hi guys,
>
> I would like to know if some people have already done some of NUMA stres=
s tests
> with multi core and xenomai.
>
> I have a problem with an Intel=C2=A0 j1900 cpu, in which under heavy X11=
 usage , I
> have large latency between tasks breaking realtime.
>
> When launched from a ssh connection this X11 program has no effect on th=
e realtime.
>
> The problem mainly is happening when I hide/show the page and the graphi=
c page
> reconstructs all the graphic widgets.
>
> There is no hyperthreading with this j1900 chip, but 4 real cores .
>
> I am supposing the heavy load on X11 manages to lock the NUMA node to a =
single
> process. This is why I was wondering if there is a way to stress the num=
a node ?
> 0
> I isolated cpus of rttasks and irq and this does not fix any problem.
>
> Unfortunatley there is only ONE numa node allocated to this system for a=
ll CPUS:
>
> numactl -H output :
>
> available: 1 nodes (0)
> node 0 cpus: 0 1 2 3
> node 0 size: 3850 MB
> node 0 free: 2552 MB
> node distances:
> node=C2=A0=C2=A0 0
>  =C2=A0 0:=C2=A0 10
>
>
> I don't know how if there would be a way to add another node ?
>

There is no NUMA on a low-end, Atom-class CPU. Your issue is either relate=
d to
bugs in the I-pipe patch or - more likely - due to hardware side effects o=
f the
GPU usage. You could analyze the latency source via the I-pipe tracer. If =
that
points to software keeping interrupts off for too long, that could be fixe=
d.
However, if it points to the hardware not injecting the interrupt in time,=
 you
will need to play with the X server settings, possibly disabling some
accelerations - or going for simple framebuffer based graphics.

Jan

