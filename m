Message-ID: <2ff1a98a0710030812p6539f24fqc394a4b4eae9ff36@domain.hid>
Date: Wed, 3 Oct 2007 17:12:52 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <200710031504.l93F4ku4020241@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <2ff1a98a0710030642q5ff5cdd7ke2b12bb2ac35016c@domain.hid>
	<200710031504.l93F4ku4020241@domain.hid>
Subject: Re: [Xenomai-help] rt_task crash kernel
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Patrick <kpa_info@domain.hid>
Cc: xenomai@xenomai.org

On 10/3/07, Patrick <kpa_info@domain.hid> wrote:
>
>
>
>
> The timer is ticking but stops after some times
>
> I have enabled all debug options in menuconfig but no message is printed
> before the crash.
>
> I try to patch new kernel with 2.6.20-arm-1.7-02 patch but is the same.

Ok. So the bug is not in the tsc emulation rework.

>
>
>
> For the 2.6.15 kernel I hadn't eabi toolchain and the kernel was not
> compiled with eabi.
>
> For 2.6.20 kernel I have an eabi toolchain and the kernel is compiled with
> eabi.

It would be nice if you could try with the no eabi toolchain.

>
>
>
> In yours PXA270 board 2.6.20 kernel with xenomai 2.3.4 works?

I do not have a PXA270 board, I test the patch on AT91.
I sent a mail around 1.7-05 asking people to test the patch on their
box and report, but did not receive an answer about the PXA board, so
I am afraid you are the first to ever test the new patch on PXA.

-- 
                                               Gilles Chanteperdrix

