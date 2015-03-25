Message-ID: <5512FAC7.1030308@web.de>
Date: Wed, 25 Mar 2015 19:13:27 +0100
From: Jan Kiszka <jan.kiszka@web.de>
MIME-Version: 1.0
References: <CAOgYGPq2882YFEd+r97TTO41u-KD1GTfVzUtoH3jjVz9NUM42Q@mail.gmail.com>
 <55117766.4090003@web.de> <5512D662.2030504@gmail.com>
In-Reply-To: <5512D662.2030504@gmail.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] xenomia on virtual box
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Roland <rolandtollenaar@gmail.com>, xenomai@xenomai.org

On 2015-03-25 16:38, Roland wrote:
> Thanks Jan.
> =

> Will try KVM on top of PREEMPT-RT.
> =

> Is there a distribution particulalry suited to patch with PREEMPT-RT?

Any is fine, just replace the kernel.

Regarding tuning of the guest, you should try to study some basics in my
original paper [1]. Details have changed, specifically QEMU has evolved
a lot, but the core problem remains: prio inversion due to device emulation.

Therefore, you won't see improvements in worst case latencies just by
using QEMU/KVM on a PREEMPT-RT kernel. You will also have to isolate
anything that triggers problematic emulations (UART, VGA, disk, ... -
just virtio-net is less problematic) from RT applications in your guest
via SMP, possibly also isolcpus and xenomai.supported_cpus.

Given that, the question is which benefits you will get from such a
setup and if the effort pays off.

Jan

[1] http://lwn.net/images/conf/rtlws11/papers/proc/p18.pdf


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: OpenPGP digital signature
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20150325/e79ab91=
2/attachment.sig>
