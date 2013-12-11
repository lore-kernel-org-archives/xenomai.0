From: Kurijn Buys <Kurijn.Buys@open.ac.uk>
MIME-Version: 1.0 (Apple Message framework v1283)
Date: Wed, 11 Dec 2013 16:44:58 +0000
In-Reply-To: <52A5E155.2040303@xenomai.org>
References: <40A5BE95-8E78-4CD6-81D2-C97AA7A58FBB@open.ac.uk>
 <529DCF2F.1070702@xenomai.org>
 <1507DF58-4A8D-42E0-92B8-4A9EAB4289E3@open.ac.uk>
 <529DDB58.3090709@xenomai.org>
 <5B55252A-19D2-4A0D-82BE-FC77BFA6AEE1@open.ac.uk>
 <529DFEC3.1050106@xenomai.org>
 <90F2A7A6-5B5E-4A25-8D9D-3D50D0EC0826@open.ac.uk>
 <529E2801.5060505@xenomai.org> <529EEB7C.4090308@xenomai.org>
 <529EED06.4010108@xenomai.org> <529EF58A.8030003@xenomai.org>
 <529EF680.1040108@xenomai.org> <529EF89E.6000302@xenomai.org>
 <529EFB3D.6090900@xenomai.org> <529F03FC.8040409@xenomai.org>
 <529F04DD.2070201@xenomai.org> <529F0C48.20705@xenomai.org>
 <529F0DBC.9080905@xenomai.org> <529F13A1.5070403@xenomai.org>
 <529F1913.4030604@xenomai.org> <529F1974.60900@xenomai.org>
 <529F2BED.2030403@xenomai.org> <529F5254.8060501@xenomai.org>
 <529F69AD.6060003@xenomai.org>
 <CE87D5F4-FE47-4310-A74F-7F8E4CCEC92B@open.ac.uk>
 <52A05ED2.9050003@xenomai.org>
 <E8F821A2-2BD0-440D-BDA1-3751BD443662@open.ac.uk>
 <52A5E155.2040303@xenomai.org>
Message-ID: <3F3EA914-853F-49FD-95E2-5148A5CD7440@open.ac.uk>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] Analogy NI 6052E
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai@xenomai.org

Hi,

Now that I got rid if my latency issue, I'm dealing with an Analogy problem=
. (I repeated my system specs below)

After running analogy_config, The NI card (6052E) seems to attach to the an=
alogy devices:
[  128.594303] Analogy: analogy_ni_pcimio: pcimio_attach: found pci-6052e b=
oard
[  128.594358] Analogy: analogy_ni_pcimio: pcimio_attach: found irq 21
and
--  Analogy devices --
| idx | status | driver
|  00 | Linked | analogy_ni_pcimio

But when I try to observe the subdevices with cat /proc/analogy/00-analogy_=
ni_pcimio
it says "Killed" and the x-server crashes.
Then the kernel log states:
[  138.273837] BUG: unable to handle kernel NULL pointer dereference at 000=
00001
[  138.273910] IP: [<f85f7a72>] a4l_rdproc_transfer+0x32/0x160 [xeno_analog=
y]
[  138.273972] *pde =3D 00000000
[  138.274002] Oops: 0000 [#1] PREEMPT SMP
[  138.274050] Modules linked in: binfmt_misc snd_hda_codec_idt snd_hda_int=
el snd_hda_codec snd_hwdep snd_pcm_oss snd_mixer_oss snd_pcm snd_seq_dummy =
i915 snd_seq_oss fbcon analogy_ni_pcimio tileblit snd_seq_midi font bitblit=
 snd_rawmidi analogy_ni_mio analogy_ni_tio analogy_8255 analogy_ni_mite sof=
tcursor snd_seq_midi_event xeno_analogy drm_kms_helper snd_seq drm snd_time=
r microcode ppdev psmouse snd_seq_device parport_pc serio_raw snd intel_agp=
 i2c_algo_bit video lp intel_gtt agpgart lpc_ich soundcore parport snd_page=
_alloc e1000e ptp pps_core
[  138.274601] CPU: 0 PID: 1273 Comm: cat Not tainted 3.10.0-xenomai-2.6.3+=
 #1
[  138.274649] Hardware name: Viglen D945GTP/D945GTP, BIOS NT94510J.86A.330=
9.2006.0109.1312 01/09/2006
[  138.274707] task: e0e5c060 ti: e0efc000 task.ti: e0efc000
[  138.274746] EIP: 0060:[<f85f7a72>] EFLAGS: 00010246 CPU: 0
[  138.274789] EIP is at a4l_rdproc_transfer+0x32/0x160 [xeno_analogy]
[  138.274831] EAX: 00000000 EBX: e13ffe40 ECX: e0efdeec EDX: f85f896a
[  138.274874] ESI: e13ffe40 EDI: 00000001 EBP: e0efdf00 ESP: e0efdee4
[  138.274916]  DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068
[  138.274954] CR0: 8005003b CR2: 00000001 CR3: 20d85000 CR4: 000007d0
[  138.274997] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
[  138.275039] DR6: ffff0ff0 DR7: 00000400
[  138.275067] I-pipe domain Linux
[  138.275091] Stack:
[  138.275110]  e13ffe40 f85f896a 000000d0 e0e87000 00000000 e13ffe40 00000=
001 e0efdf40
[  138.276018]  c02cc825 00020000 e0efdf30 09b0b000 e13ffe68 00008000 00000=
000 e0c6c200
[  138.276018]  e0c6c200 00008000 00000000 00000000 e0c6c200 e0d94600 c02cc=
730 e0efdf64
[  138.276018] Call Trace:
[  138.276018]  [<c02cc825>] seq_read+0xf5/0x390
[  138.276018]  [<c02cc730>] ? seq_lseek+0x170/0x170
[  138.276018]  [<c02fdc83>] proc_reg_read+0x53/0x90
[  138.276018]  [<c02fdc30>] ? proc_reg_write+0x90/0x90
[  138.276018]  [<c02ae3d7>] vfs_read+0x97/0x110
[  138.276018]  [<c02aed46>] SyS_read+0x56/0x90
[  138.276018]  [<c06d0f4f>] sysenter_do_call+0x12/0x16
[  138.276018] Code: ec 10 e8 12 9a 0d c8 89 d7 89 c3 c7 44 24 04 56 89 5f =
f8 89 04 24 e8 fe 46 cd c7 c7 44 24 04 6a 89 5f f8 89 1c 24 e8 ee 46 cd c7 =
<8b> 07 85 c0 0f 84 0c 01 00 00 31 c0 31 f6 eb 5b 8d b6 00 00 00
[  138.276018] EIP: [<f85f7a72>] a4l_rdproc_transfer+0x32/0x160 [xeno_analo=
gy] SS:ESP 0068:e0efdee4
[  138.276018] CR2: 0000000000000001
[  138.320577] ---[ end trace a8594ddaa188276f ]---


It seems to me that this issue is related to this thread: http://www.mail-a=
rchive.com/xenomai-help@gna.org/msg10134.html
However, in my case the attach itself seems to work. And I suppose the solu=
tion for this thread was an update of the kernel patch, so maybe I'm dealin=
g with a new issue for my specific card..?

I enabled Analogy drivers (as explained here http://www.lara.unb.br/wiki/in=
dex.php/Data_Acquisition_Xenomai_Analogy),
and disabled Comedi drivers (Data acquisition support (comedi) ).

I checked the specs of the card with its description in "ni_pcimio.c" and t=
hat looks all right for what I understand. (I don't know for these: caldac =
ai_speed).
I tried booting with pci=3Drouteirq
I tried another PCI connection, even another PC.

My system:
Hardware: Pentium IV (lspci: 3,2GHz, i686, 32,64bit, 2 cpu's), 2Gb RAM
Software: Ubuntu 10.04, kernel&patch 3.10 (but also tried with 2.6.38.8 and=
 3.8), Xenomai 2.6.3


Thanks!
]{urijn

Op 9-dec.-2013, om 15:27 heeft Gilles Chanteperdrix het volgende geschreven=
:

On 12/09/2013 04:19 PM, Kurijn Buys wrote:
Op 5-dec.-2013, om 11:09 heeft Gilles Chanteperdrix het volgende geschreven=
:

On 12/05/2013 01:44 AM, Kurijn Buys wrote:

Op 4-dec.-2013, om 17:43 heeft Philippe Gerum het volgende geschreven:

On 12/04/2013 05:03 PM, Gilles Chanteperdrix wrote:
On 12/04/2013 02:19 PM, Philippe Gerum wrote:
On 12/04/2013 01:00 PM, Gilles Chanteperdrix wrote:
Ok, could you push the branch somewhere so that I can try it?


testing/ipipe-3.8-i915-fix

I could test it, I no longer get high latencies while moving a large
opengl window. So, it looks good.

I've it running as well (with the priority coupling option disabled this ti=
me).

The options I asked you to change were meant to eliminate any possible
source for high latencies in case of bug. You can return to a normal
configuration now: re-enable SMP or APIC if you prefer to remain in
single processor mode, disable the I-pipe tracer if you want to avoid
the overhead, and re-enable priority coupling if you prefer to use it.

Re-enabling SMP is fine, but doesn't necessarily seem to improve the latenc=
y.
While I'm still having some small pikes, they keep below 60us, so that is f=
ine to me.

If your processor has hyper-threading, you may have much better results
indeed in single processor mode, but enabling APIC and IO/APIC to avoid
the spikes you got when using the legacy PIC.

Experiences on atom processor:
http://www.xenomai.org/~gch/core-3.4-latencies/atom.png

show that disabling hyper-threading divides latency by 2.

--
   Gilles.

-- The Open University is incorporated by Royal Charter (RC 000391), an exe=
mpt charity in England & Wales and a charity registered in Scotland (SC 038=
302).
