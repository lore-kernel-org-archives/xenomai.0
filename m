Message-ID: <4F15E2B3.1080502@domain.hid>
Date: Tue, 17 Jan 2012 22:05:55 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAP1XtZzB34=+B+fwWpswhqfFVMd3YmU4etoYOSxXFOMbEH7myg@domain.hid>	<4F1493B5.1000501@domain.hid>
	<CAP1XtZyPdegxcce3Xv4mKCbrjspQPQKCL4jeqrVRzubadqX_vg@domain.hid>
In-Reply-To: <CAP1XtZyPdegxcce3Xv4mKCbrjspQPQKCL4jeqrVRzubadqX_vg@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Processor type for installation
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Santiago Focke <focke.85@domain.hid>
Cc: xenomai@xenomai.org

On 01/17/2012 09:19 PM, Santiago Focke wrote:
> Thanks Gilles for the replay
> 
> 2012/1/16 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
>>
>> On 01/16/2012 09:03 PM, Santiago Focke wrote:
>>> Dear all
>>>
>>> I've been trying to install Xenomai but I haven't been able to do it
>>> right.  After being able of building and installin the kernel and
> Xenomai,
>>> I tried to run the example program trivial-periodic, I got the following
>>> error
>>
>> We do not know which kernel version, which xenomai version, which adeos
>> I-pipe version.
>>
> 
> Sorry I didn't write the kernel + xenomai specifications. I'm using
> linux-2.6.38.8 and xenomai 2.6. About Adeos and I-pipe, should I do any
> kind of installation of the before installing Xenomai??
> 
>>>
>>> /usr/src/xenomai-2.6/examples/native$ ./trivial-periodic
>>> Xenomai: incompatible feature set
>>> (userland requires "tsc fastsynch", kernel provides "sep fastsynch smp",
>>> missing="tsc").
>>>
>>> I read that the reason for this is that I didn't configure correctly the
>>> processor family (with xconfig). Is that the reason? Also, I've been
> trying
>>> to know which option should I choose (I chose CONFIG_M586 at the
>>> beggining), but I don't know were to get that information. The CPU info
>>> goes as follows:
>>>
>>> /proc/cpuinfo
>>>
>>> processor    : 0
>>> vendor_id    : GenuineIntel
>>> cpu family    : 6
>>> model        : 37
>>> model name    : Intel(R) Core(TM) i7 CPU       M 620  @ 2.67GHz
>>
>> So, you have a core i7, anything newer than "pentium pro" (an older than
>> ten years old architecture) should do, but better select the processor
>> you actually have or the nearest substitute: so, assuming you are
>> compiling a 2.6.38 kernel, "core 2/newer xeon" should do. Also note that
>> a core i7 is able to run in 64 bits mode, so running it in 32 bits mode
>> is a bit a pity.
>>
> Regarding the processor family, i selected 'core 2/newer xeon', and tried
> to build a 64-bits kernel. But when I tried to boot the new patched kernel,
> I got the following error and get stacked in the booting:
> 
> [     0.051013] ..MP_BIOS bug: 8254 timer not conncted to IO-APIC
> [     2.338200] EXT3-fs (sda1) error: couldn't mount because of unsupported
> optional features (240)
> [     2.362370] EXT3-fs (sda1) error: couldn't mount because of unsupported
> optional features (240)
> [     2.400400] request_module: runaway loop modprobebinfmt-464c
> [     2.400449] request_module: runaway loop modprobebinfmt-464c
> [     2.400570] request_module: runaway loop modprobebinfmt-464c
> [     2.400612] request_module: runaway loop modprobebinfmt-464c
> [     2.400755] request_module: runaway loop modprobebinfmt-464c
> 
> I don't know if I did something wrong in the installation process. These
> were my steps:

Your kernel is probably not configured correctly. Something is missing
in the filesystems configuration such as ext4 support.

Also note that you need to have a 64 bits root filesystem if you want to
run xenomai on a 64 bits kernel.
-- 
                                                                Gilles.

