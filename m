Message-ID: <456060D7.8030905@domain.hid>
Date: Sun, 19 Nov 2006 14:49:11 +0100
From: karre@domain.hid
MIME-Version: 1.0
Subject: Re: [Xenomai-help] System freezes with Xenomai 2.2.5 and kernel 2.6.17
References: <20061117143512.191580@domain.hid> <455DCBAB.4090204@domain.hid>
In-Reply-To: <455DCBAB.4090204@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hi Jan,

thank you for your answer! Unfortunately, I didn't find your mail
earlier as Thunderbird made a mistake.

In the meantime I verified the freezing on another platform. Both are
notebooks that are 3 years or older.

>> Another suspicious fact was numberous "nothing to do"-messages during compilation of Xenomai.
>>     
>
> User-space part, I guess. Likely you already built it, no?
>   
I think so as well. User-space part is the one that is not compiled into
the kernel but with a make/make install directly in the
xenomai-directory, isn't it?

But no, at least on this computer I haven't built it before. I
downloaded a fresh copy of the Vanilla-2.6.17.14-Kernel and of Xenomai
2.2.5, expanded it, patched the kernel, and compiled the kernel and
afterwards Xenomai (user part?).

>> Now the system is bootable and Xenomai reported that hal&x86, real-time nucleus, nataive API, POSIX and RDTM services had started. Unfortunately, the system freezes unrecoverably shortly after login.
>>     
>
> .config, please. I'm running such a setup (SuSE 10.1, 2.6.17.14, latest
> Xenomai) successfully on my notebook.
>   

That's great, also that your run it on a notebook as well!

I appended my .config at the bottom of this email's copy to you. I left
it from the copy to xenomai-help, as it is 64 KB large. If it is no
problem, I could also attach it hier.

I have also saved all outputs (bootmessages and make-messages). All in
all, it's 600 KB. If that isn't too much, I could send it to you, as
well. Perhaps that this would be useful.

> Please make sure, that your build is really consistent. When in doubt,
> try a "make clean; make; make modules_install install" cycle and check
> if it helps. Could you have accidentally mixed up modules from some
> non-Xenomai 2.6.17-build with the Xenomai-enabled version?
>   

As far as I see it, a make clean would only be necessary if one has
built the kernel before. So this probably doesn't make a difference.

I'm thinking about what you wrote about mixing up modules. I have
already built a Kernel on this Computer before, but it was another
version. At least 2.6.17, but I think it even was 2.6.16.xx. As I said,
i had fresh copies of both Xenomai and the kernel in /usr/src/, set the
symbolic links '/usr/src/linux' and '/usr/src/xenomai' correspondingly,
and did a [xenomai] /scripts/prepare-kernel, [linux] make menuconfig,
make, make modules_install install, [xenomai] ./configure, make, make
install - cycle.

By the way, when I compiled the rt-system on this second notebook, I got
the  "Cannot determine dependencies of module ..." not for reiserfs, but
for processor, thermal,  jbd, ext3 (in this order and immediately
afterwards a second time, again in this order). As I have already said,
I could provide you with the messages during build process.

>> Can this be cause of I couldn't include "Interrupt pipeline" into the kernel? There was no way to elect it in menuconfig, there was --- instead of [ ], [*] or [M] beneath this option.
>>     
>
> The "---" means that you cannot disable this essential feature, it will
> be forcibly compiled-in when you enable Xenomai.
>   

Ah, I see. Thank you. This probably is the explanation why during boot
process, "I-pipe 1.5-02: pipeline enabled." and "I-pipe: Domain Xenomai
registered." is reported.

So thank you for your help! I'm looking forward to hearing from you!

Richard


