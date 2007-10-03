Message-ID: <2ff1a98a0710030642q5ff5cdd7ke2b12bb2ac35016c@domain.hid>
Date: Wed, 3 Oct 2007 15:42:44 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <200710031318.l93DI2g6007476@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200710031318.l93DI2g6007476@domain.hid>
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
> Ok, some messages occur on the console with latency.

Continuously, or does it stop ? If the timer is still ticking, it is
surprising that latency does not print anything. If the timer stops,
then we have a problem. You may also want to enable all Xenomai/I-pipe
debugging options in order to see if it prints something before
locking up.

>
> For information I have successfully installed and used Xenomai 2.3.1 with
> 2.6.15 kernel on the same board.

But for the 2.6.15, you had no EABI, have you tried compiling the
v2.3.4 without EABI ? Another thing that you could try is to compile
v2.3.4 with the patch
http://download.gna.org/adeos/patches/v2.6/arm/older/adeos-ipipe-2.6.20-arm-1.7-02.patch.

This patch was the last patch before reworking the tsc emulation,
knowing whether it works could help find what part of the patch is
causing the issue you observe.

-- 
                                               Gilles Chanteperdrix

