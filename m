Subject: Re: [xenomai-images][PATCH 1/2] linux-xenomai: Fix arm/arm64 latest
 branches, add 5.4 option
References: <ca6c935b-a10c-589c-502d-0b9e439c7089@siemens.com>
 <CALLqZ8RGYh5qevRX3NJ88MRrPcJyDfX0H2bd=d4TLiRBNCZ9hg@mail.gmail.com>
 <4c9069df-2a3f-0a63-9553-f2da4679c8fa@qmul.ac.uk>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <a181852d-d194-5b87-6559-5358a1accc5a@siemens.com>
Date: Tue, 9 Feb 2021 12:42:29 +0100
MIME-Version: 1.0
In-Reply-To: <4c9069df-2a3f-0a63-9553-f2da4679c8fa@qmul.ac.uk>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Giulio Moro <g.moro@qmul.ac.uk>, Greg Gallagher <greg@embeddedgreg.com>
Cc: Xenomai <xenomai@xenomai.org>

On 09.02.21 12:35, Giulio Moro wrote:
> Hi there,
> I tried building this with:
>    kas-container build
> kas.yml:board-beagle-bone-black.yml:opt-linux-latest-5.4.yml
> (not sure if that's the right syntax to get 5.4 ... I had to second
> guess it)

Yeah, all these knobs are not well documented, primarily as they are
currently being added more for testing than for users. Should be improved.

> 
> but it errors. I think the relevant error is:
> 
>   AR      kernel/printk/built-in.a
>   CC      kernel/trace/ring_buffer.o
>   DTC     arch/arm/boot/dts/logicpd-som-lv-37xx-devkit.dtb
>   CC      arch/arm/mach-omap2/prm2xxx_3xxx.o
>   DTC     arch/arm/boot/dts/omap3430-sdp.dtb
>   DTC     arch/arm/boot/dts/omap3-beagle.dtb
>   CC      arch/arm/mach-omap2/prm3xxx.o
>   CC      kernel/trace/trace.o
>   CC      kernel/irq/generic-chip.o
>   DTC     arch/arm/boot/dts/omap3-beagle-xm.dtb
>   AR      arch/arm/mach-imx/built-in.a
>   DTC     arch/arm/boot/dts/omap3-beagle-xm-ab.dtb
>   CC      arch/arm/mach-omap2/cm3xxx.o
> ../kernel/xenomai/posix/clock.c:21:10: fatal error:
> cobalt/kernel/vdso.h: No such file or directory
>  #include <cobalt/kernel/vdso.h>
>           ^~~~~~~~~~~~~~~~~~~~~~
> compilation terminated.
>   CC      kernel/time/timekeeping.o
> make[6]: *** [../scripts/Makefile.build:262:
> kernel/xenomai/posix/clock.o] Error 1
> make[5]: *** [../scripts/Makefile.build:496: kernel/xenomai/posix] Error 2
> make[4]: *** [../scripts/Makefile.build:496: kernel/xenomai] Error 2
> make[4]: *** Waiting for unfinished jobs....
> 
> Full log is available here
> https://gist.github.com/giuliomoro/c1996a5b4c915ea385f2bde3900f8bb2
> (pastebin rejects the log because of "potentially offensive or
> questionable content").
> 
> Any advice will be greatly appreciated.
> 

What you are missing is also :opt-xenomai-next.yml because 5.4 requires
some changes that are not in the last release (which is the default
otherwise). Then you will get [1] - where the resulting options are
unfortunately not printed.

Jan

[1] https://gitlab.denx.de/Xenomai/xenomai-images/-/jobs/220139

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

