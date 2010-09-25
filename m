MIME-Version: 1.0
In-Reply-To: <4C9DB383.1050606@domain.hid>
References: <AANLkTimFXFr48DgXSj=53pNjAQB7w+mjOwwuEYQXc3KV@mail.gmail.com>
	<4C9D0A94.9030501@domain.hid>
	<AANLkTikQi1+5F5e5x1om=4HMqmwc9twJ+ZtK-kWN8gnD@mail.gmail.com>
	<4C9DB383.1050606@domain.hid>
Date: Sat, 25 Sep 2010 23:20:49 +0200
Message-ID: <AANLkTikR8pc1w27pi11wA7rS-K6C3wzSQXkE33iKHfcX@mail.gmail.com>
From: Gajamohan Mohanarajah <gajamohan.m@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] switchtest/xeon-test fails: Help needed
 (Ubuntu/Core i7)
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Hi Gilles,

On 25 September 2010 10:32, Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org> wrote:
> Gajamohan Mohanarajah wrote:
>>> You can also configure your kernel to only keep what is needed for you
>>> real-time system. In any case, please make sure to take a look at:
>>> http://www.xenomai.org/index.php/Configuring_x86_kernels
>> I will double check once I solve the switchtest error.
>
> Please check this first.
I went through the x86 config page and FAQ.  There was one change
regarding the CPU family I had to do.
Since mine is an i7 (/proc/cpuinfo: cpu family 6) i changed the
processor family to Core 2 / newer xeon (The help text said this is
for cpu families 6 and 15). But native skin init fails with this
option. Please note that this didn't happen when generic-X86_64 was
selected.
Also note that enabling SMI workaround did not help.

With Core 2 / newer xeon option:
---------------------------
Sep 25 22:55:00 totoro kernel: [    1.159579] I-pipe: Domain Xenomai regist=
ered.
Sep 25 22:55:00 totoro kernel: [    1.159627] Xenomai: hal/x86_64 started.
Sep 25 22:55:00 totoro kernel: [    1.159640] Xenomai: scheduling
class idle registered.
Sep 25 22:55:00 totoro kernel: [    1.159641] Xenomai: scheduling
class rt registered.
Sep 25 22:55:00 totoro kernel: [    1.160208] Xenomai: real-time
nucleus v2.5.4 (Sleep Walk) loaded.
Sep 25 22:55:00 totoro kernel: [    1.161567] ------------[ cut here
]------------
Sep 25 22:55:00 totoro kernel: [    1.161571] WARNING: at
mm/page_alloc.c:1806 __alloc_pages_nodemask+0x607/0x6d0()
Sep 25 22:55:00 totoro kernel: [    1.161573] Hardware name: Precision T150=
0
Sep 25 22:55:00 totoro kernel: [    1.161575] Modules linked in:
Sep 25 22:55:00 totoro kernel: [    1.161577] Pid: 1, comm: swapper
Not tainted 2.6.32.15+drm33.5+xenomai-v0.41 #7
Sep 25 22:55:00 totoro kernel: [    1.161579] Call Trace:
Sep 25 22:55:00 totoro kernel: [    1.161584]  [<ffffffff810587bb>]
warn_slowpath_common+0x7b/0xc0
Sep 25 22:55:00 totoro kernel: [    1.161587]  [<ffffffff81058814>]
warn_slowpath_null+0x14/0x20
Sep 25 22:55:00 totoro kernel: [    1.161590]  [<ffffffff81142e27>]
__alloc_pages_nodemask+0x607/0x6d0
Sep 25 22:55:00 totoro kernel: [    1.161594]  [<ffffffff8130daae>] ?
vsnprintf+0x2ae/0x5e0
Sep 25 22:55:00 totoro kernel: [    1.161598]  [<ffffffff81172fe9>]
alloc_page_interleave+0x39/0x90
Sep 25 22:55:00 totoro kernel: [    1.161601]  [<ffffffff81175a54>]
alloc_pages_current+0xc4/0xd0
Sep 25 22:55:00 totoro kernel: [    1.161604]  [<ffffffff8113fdbe>]
__get_free_pages+0xe/0x50
Sep 25 22:55:00 totoro kernel: [    1.161607]  [<ffffffff810f466b>]
xnpod_init+0x27b/0x3c0
Sep 25 22:55:00 totoro kernel: [    1.161610]  [<ffffffff81106660>] ?
__native_skin_init+0x0/0x4f0
Sep 25 22:55:00 totoro kernel: [    1.161612]  [<ffffffff811067db>]
__native_skin_init+0x17b/0x4f0
Sep 25 22:55:00 totoro kernel: [    1.161615]  [<ffffffff81106660>] ?
__native_skin_init+0x0/0x4f0
Sep 25 22:55:00 totoro kernel: [    1.161619]  [<ffffffff8100904c>]
do_one_initcall+0x3c/0x1c0
Sep 25 22:55:00 totoro kernel: [    1.161623]  [<ffffffff8182a700>]
kernel_init+0x14c/0x1ae
Sep 25 22:55:00 totoro kernel: [    1.161626]  [<ffffffff8100d6da>]
child_rip+0xa/0x20
Sep 25 22:55:00 totoro kernel: [    1.161629]  [<ffffffff8182a5b4>] ?
kernel_init+0x0/0x1ae
Sep 25 22:55:00 totoro kernel: [    1.161631]  [<ffffffff8100d6d0>] ?
child_rip+0x0/0x20
Sep 25 22:55:00 totoro kernel: [    1.161637] ---[ end trace
e93713a9d40cd06c ]---
Sep 25 22:55:00 totoro kernel: [    1.161982] Xenomai: native skin
init failed, code -12.
Sep 25 22:55:00 totoro kernel: [    1.161984] Xenomai: starting POSIX servi=
ces.
Sep 25 22:55:00 totoro kernel: [    1.162008] Xenomai: starting RTDM servic=
es.


With generic-X86_64 option:
---------------------------
Sep 24 16:39:24 totoro kernel: [    1.053575] I-pipe: Domain Xenomai regist=
ered.
Sep 24 16:39:24 totoro kernel: [    1.053622] Xenomai: hal/x86_64 started.
Sep 24 16:39:24 totoro kernel: [    1.053635] Xenomai: scheduling
class idle registered.
Sep 24 16:39:24 totoro kernel: [    1.053636] Xenomai: scheduling
class rt registered.
Sep 24 16:39:24 totoro kernel: [    1.054149] Xenomai: real-time
nucleus v2.5.4 (Sleep Walk) loaded.
Sep 24 16:39:24 totoro kernel: [    1.054261] Xenomai: starting native
API services.
Sep 24 16:39:24 totoro kernel: [    1.054262] Xenomai: starting POSIX servi=
ces.
Sep 24 16:39:24 totoro kernel: [    1.054283] Xenomai: starting RTDM servic=
es.

Please be good enough to comment on this.
> --
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Gilles.
>
Gajan

