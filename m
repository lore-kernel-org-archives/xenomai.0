From: =?UTF-8?Q?St=c3=a9phane_Ancelot?= <sancelot@numalliance.com>
Subject: numa stress test - Intel j1900
Message-ID: <889a60a9-922b-de10-f5fa-94c23ca38a2e@numalliance.com>
Date: Fri, 10 May 2019 14:51:40 +0200
MIME-Version: 1.0
Content-Language: fr
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

Hi guys,

I would like to know if some people have already done some of NUMA=20
stress tests with multi core and xenomai.

I have a problem with an Intel=C2=A0 j1900 cpu, in which under heavy X11=20
usage , I have large latency between tasks breaking realtime.

When launched from a ssh connection this X11 program has no effect on=20
the realtime.

The problem mainly is happening when I hide/show the page and the=20
graphic page reconstructs all the graphic widgets.

There is no hyperthreading with this j1900 chip, but 4 real cores .

I am supposing the heavy load on X11 manages to lock the NUMA node to a=20
single process. This is why I was wondering if there is a way to stress=20
the numa node ?

I isolated cpus of rttasks and irq and this does not fix any problem.

Unfortunatley there is only ONE numa node allocated to this system for=20
all CPUS:

numactl -H output :

available: 1 nodes (0)
node 0 cpus: 0 1 2 3
node 0 size: 3850 MB
node 0 free: 2552 MB
node distances:
node=C2=A0=C2=A0 0
 =C2=A0 0:=C2=A0 10


I don't know how if there would be a way to add another node ?

Regards,

S.Ancelot





