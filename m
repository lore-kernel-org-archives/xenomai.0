MIME-Version: 1.0
In-Reply-To: <1524573484592.16072@kth.se>
References: <1524573484592.16072@kth.se>
From: Greg Gallagher <greg@embeddedgreg.com>
Date: Tue, 24 Apr 2018 09:34:13 -0400
Message-ID: <CALLqZ8TPT8PtyRt4oB2uK9krhaYqSudjZirpzD9eg2R5k=3HeA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Xenomai] Illegal instruction/bad syscall
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gustav Johansson <gusjohan@kth.se>
Cc: "Xenomai@xenomai.org" <Xenomai@xenomai.org>

Have you considered using mainline?  I'm not sure if anyone has been
testing the raspberry pi tree against stable xenomai-3.  I've
validated most of the xenomai-3 stable branch against raspberry pi 2b
(mainline) so I've looked at most of the bcm code recently and i
haven't git the syscall issue.  Some of the maintainers are also
looking to test ARM64 rpi3 so if you want to try getting the 64-bit
mainline kernel running on your board I can give you some help.

-Greg

On Tue, Apr 24, 2018 at 8:38 AM, Gustav Johansson <gusjohan@kth.se> wrote:
> Hi!
>
>
> I recently managed to run a cobalt core for raspberry pi 3, Im using ipipe #9 for arm,  kernel version 4.1.21, Xenomai 3.0.6.
>
>
> I managed to build the xenomai API but when I try every executable file, for example latency test bench,  I get "illegal instruction", and in dmesg I get "[Xenomai] bad syscall <0xff7000af> ...".
>
>
> The crosscompiler Im using is https://github.com/raspberrypi/tools/tree/master/arm-bcm2708/gcc-linaro-arm-linux-gnueabihf-raspbian and I have also tried compiling it on the RPI3 itself but Im getting the same error.
>
>
> I have compared my kernel config next to Harco Kuppens  working image (http://www.cs.ru.nl/lab/xenomai/) But the only difference is that I have higher values in XENO_OPT_SYS_HEAP, XENO_PRIVATE_HEAPS, XENO_OPT_SHARED_HEAPSZ, XENO_OPT_TIMERS.
>
>
> Im uploading a readme with the steps I have taken with the installation and also my kernel config.
>
>
> Any ideas on why I get "Illegal instruction"?
>
>
> Regards
>
> Gustav Johansson
>
> -------------- next part --------------
> A non-text attachment was scrubbed...
> Name: rpi3_cobalt_4.1.21_config
> Type: application/octet-stream
> Size: 126604 bytes
> Desc: rpi3_cobalt_4.1.21_config
> URL: <http://xenomai.org/pipermail/xenomai/attachments/20180424/fd49797a/attachment.obj>
> -------------- next part --------------
> A non-text attachment was scrubbed...
> Name: readme.md
> Type: text/markdown
> Size: 6403 bytes
> Desc: readme.md
> URL: <http://xenomai.org/pipermail/xenomai/attachments/20180424/fd49797a/attachment.bin>
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> https://xenomai.org/mailman/listinfo/xenomai

