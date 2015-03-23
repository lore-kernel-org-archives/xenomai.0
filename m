Message-ID: <550FD6CA.7080407@web.de>
Date: Mon, 23 Mar 2015 10:03:06 +0100
From: Jan Kiszka <jan.kiszka@web.de>
MIME-Version: 1.0
References: <CAKC9m6dkbD2iwi62YP_O2wRiOUHNp17eoMLYP6okg=PQ0OgjxQ@mail.gmail.com>
 <20150320181308.GA27775@hermes.click-hack.org>
 <CAKC9m6eFoRrFj_QteNeJmcbi+eir0SGzwoCTd2TVzPVuqDsiCQ@mail.gmail.com>
 <20150321131111.GA20203@hermes.click-hack.org>
 <20150321132130.GC20203@hermes.click-hack.org>
 <CAKC9m6ceEi593XX04-dLfQaVYHmQHmwe75oC+d4Qu-t9q1G9_A@mail.gmail.com>
In-Reply-To: <CAKC9m6ceEi593XX04-dLfQaVYHmQHmwe75oC+d4Qu-t9q1G9_A@mail.gmail.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] ARMv8 (ARM64) port of Xenomai
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Hongfei Cheng <hongfei@mperpetuo.com>, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On 2015-03-23 07:01, Hongfei Cheng wrote:
> Thank you for the terrific info and timely advice. I'll proceed as you
> suggested and report back progress regularly.

Another tip: it can we useful to do early bring-up on QEMU basis. It is
already in a pretty decent state regarding aarch64, Linaro is hacking on
it, and vendors like Xilinx do their virtual prototyping on that basis
as well (in the latter case for the upcoming MPSoC). Probably - I didn't
try it out myself yet, only planning to do these days - the gdb
interface also works fine, thus will give you source level debugging.

Jan

> =

> Hongfei
> =

> On Sat, Mar 21, 2015 at 6:21 AM, Gilles Chanteperdrix
> <gilles.chanteperdrix@xenomai.org> wrote:
>> On Sat, Mar 21, 2015 at 02:11:11PM +0100, Gilles Chanteperdrix wrote:
>>> On Fri, Mar 20, 2015 at 05:06:36PM -0700, Hongfei Cheng wrote:
>>>> Gilles - Thank you for sharing the link and updating us with your sche=
dule.
>>>>
>>>> I just started to port the I-pipe and Xenomai-3 code for supporting
>>>> the ARMv8 architecture. Based on my limited understanding of Xenomai,
>>>> it appears that the following changes are required in order to get
>>>> Xenomai-3 running on the ARMv8 SoC we plan to use (Qualcomm msm8994):
>>>>
>>>> 1). In vendor kernel tree, add I-pipe support to arm64 generic arch
>>>> code: arch/arm64/boot, arch/arm64/kernel, etc.
>>>> 2). In vendor kernel tree, add I-pipe support to arm64 MMU: arch/arm64=
/mm
>>>> 3). In vendor kernel tree, add I-pipe support to platform-specific
>>>> device tree: arm(64)/boot/dts/qcom
>>>> 4). In vendor kernel tree, add I-pipe support to SoC and platform
>>>> dependent drivers for arm64: drivers/gpio, drivers/irqchip(?),
>>>> drivers/clocksource(?)
>>>> 5). In xenomai-3 tree, support arm64 in Cobalt kernel: kernel/cobalt/a=
rch/arm64
>>>>
>>>> Do you (and anyone else who's working on ARMv8) see any critical
>>>> modules missing from my list?
>>>
>>> No, but the contrary, there is no reason to touch boot, kernel, mm.
>>
>> Also, I would do things step by step. First get irq interception
>> working, then timer interception, at that point I would test with
>> rtdm kernel tasks only (without CONFIG_SMP). Then add CONFIG_SMP and
>> get SMP specific stuff working, like IPI interception working, test
>> with rtdm tasks again, testing on the various cores. Then finally
>> add fault/syscall interception, and test with default latency test.
>>
>> I would use xenomai 3.x for testing, it will avoid quite a few
>> complicated things (kernel-space tasks without task_struct, hybrid
>> context switch), and we could leave it at that and decide that
>> xenomai 2.6 will never support armv8.
>>
>> --
>>                                             Gilles.


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: OpenPGP digital signature
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20150323/48c7ea9=
c/attachment.sig>
