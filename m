Subject: Re: autotune inside qemu: early shot and segfault
References: <42504023-fcfb-7f38-e806-0c41793adb9d@siemens.com>
 <fee7159e-85d5-bffc-fd89-79050166d080@siemens.com>
 <6c8843f98aea5786d95f57d46cbaf0f2ec267951.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <da4bf683-2a3d-5e32-e4aa-bd9ecef0a605@siemens.com>
Date: Fri, 27 Aug 2021 12:23:38 +0200
MIME-Version: 1.0
In-Reply-To: <6c8843f98aea5786d95f57d46cbaf0f2ec267951.camel@siemens.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Bezdeka, Florian (T RDA IOT SES-DE)" <florian.bezdeka@siemens.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 27.08.21 12:22, Bezdeka, Florian (T RDA IOT SES-DE) wrote:
> On Fri, 2021-08-27 at 12:03 +0200, Jan Kiszka wrote:
>> On 27.08.21 11:57, Florian Bezdeka wrote:
>>> Hi all,
>>>
>>> first issue:
>>>
>>> maybe someone can explain what's going on here. I'm running autotune
>>> inside qemu (ARM) on an x86_64 host and get the error below. The
>>> kernel in use is 4.19 (ipipe) build with current "next" branch.
>>>
>>> root@demo:~# autotune2
>>> == auto-tuning started, period=1000000 ns (may take a while)
>>> irq gravity... 0 ns
>>> kernel gravity... autotune: tuning failed (kernel): Resource temporarily unavailable
>>>
>>> dmesg tells me
>>>
>>> [   92.800781] [Xenomai] autotune(irqhand) started
>>> [  102.499494] [Xenomai] autotune(kthread) started
>>> [  108.623898] [Xenomai] autotune(kthread) failed with early shot (827251 ns)
>>> [  108.646795] [Xenomai] autotune finished [0i/5000k/5000u]
>>>
>>>
>>> Any idea why / how this early shot can happen? I'm unable to
>>> reproduce it on a real hardware like the beagle bone black.
>>> I wonder why it seems to work in the CI setup...
>>>
>>>
>>>
>>> Second issue: From time to time autotune produces a segfault:
>>>
>>> root@demo:~# autotune
>>> == auto-tuning started, period=1000000 ns (may take a while)
>>> irq gravity... 1984 ns
>>> kernel gravity... 10912ns
>>> user gravity... Segmentation fault
>>>
>>> I haven't seen the segfault with a dovetail enabled kernel yet.
>>> So it might be ipipe related...
>>>
>>> I was able to reproduce once with gdb attached. We seem to crash
>>> in rtmd.c line 170 (do_ioctl, XENOMAI_SYSCALL3()). GDB was
>>> unable to present a backtrace. ("previous frame identical to this
>>> frame (corrupt stack?")
>>>
>>
>> Does corectl provide some hints? Is the kernel reporting a userspace or
>> a kernel space fault?
> 
> dmesg doesn't list a segfault at all... Wrong routed signal? I'm going
> to play with corectl, but there was nothing interesting so far.
> 

I meant coredumpctl btw., just to be clear.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

