From: "Wolz, Troy" <Troy.Wolz@dynetics.com>
Date: Mon, 16 Jul 2012 20:16:17 +0000
Message-ID: <E2AB2206BF591546A1931EA4E7A9FBC859BAFA22@Maui.in.dynetics.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] RT_TASK affinity on more than 8 CPU's
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hello,

I'm working on a project where I'd like to start more than 8 RT_TASKs each =
affined to their own CPU. From looking at the documentation, using the nati=
ve API it appears to be possible to set affinity to a CPU from 0 to RTHAL_N=
R_CPUS-1. On my machine, RTHAL_NR_CPUS is 255, but when setting affinity ab=
ove 7, overflow occurs and only the lower 8 CPU's are used.

Looking into this, the T_CPU macro appears to only use the lower 3 bits of =
the value passed to it, implying that T_CPU only allows up to 8 CPU's to be=
 used. Tracing through the use of this mask, it appears that the mode mask =
passed into rt_task_create uses the top 8 bits of the word as the cpu mask.=
 The bits following the top 8 are used for other flags, so there is no room=
 to expand the cpu mask.

I see 2 solutions to this limitation for using Xenomai and affinity on more=
 than 8 cpus.
1. Expand the 'mode' argument from a 32 bit int to a 64 bit long. With the =
extra bits, the top 32 bits could be used as a CPU mask, allowing for up to=
 32 cpu's to be masked simultaneously. This change would affect several fil=
es, but it should be backwards compatible with applications currently writt=
en using a 32 bit mode.

2. Pass an additional 64 bit long argument to rt_task_create that only cont=
ains the affinity mask. In this case, the mode argument would be used the s=
ame as previously, except the affinity would be ignored. This option has th=
e disadvantage of being incompatible with existing Xenomai applications, bu=
t it is very easy to set affinity for up to 64 cpu's. We could add a prepro=
cessor define that selects whether the existing rt_task_create method is av=
ailable or whether the new method is available.

We are willing to develop a patch that adds this functionality, but I wante=
d to talk it over with the group to determine if this would be accepted as =
a patch or if there's a better way to do it. Thanks.

Troy
