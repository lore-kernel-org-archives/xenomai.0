From: Gustav Johansson <gusjohan@kth.se>
Date: Fri, 27 Apr 2018 10:03:58 +0000
Message-ID: <1524823439034.35578@kth.se>
References: <1524573484592.16072@kth.se>,
 <CALLqZ8TPT8PtyRt4oB2uK9krhaYqSudjZirpzD9eg2R5k=3HeA@mail.gmail.com>
In-Reply-To: <CALLqZ8TPT8PtyRt4oB2uK9krhaYqSudjZirpzD9eg2R5k=3HeA@mail.gmail.com>
Content-Language: en-GB
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Xenomai] RPI, pinctrl-bcm2835 now working
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Xenomai@xenomai.org" <Xenomai@xenomai.org>

Hi!=0A=
=0A=
I have now successfully booted the mainline kernel on RPi3. =0A=
The problem I have now instead is the pinctrl-bcm2835 driver. =0A=
In /dev/rtdm/pinctrl-bcm2835/ are the pins in wrong numbers, =0A=
they start at 400+ and end at 500+. =0A=
=0A=
When I looked inside /drivers/pinctrl/bcm/pinctrl-bcm2835.c =0A=
It is very different from the one in rpi-kernel. Im guessing =0A=
that the driver pinctrl-bcm2835.c in the mainline is for the=0A=
 older RPi's while rpi-kernel got the for the newer models.=0A=
=0A=
Do you have any ideas on how I should continue?=0A=
=0A=
Do you have a working pinctrl-bcm2835 driver on your RPi2?=0A=
=0A=
Regards=0A=
Gustav =0A=
=0A=
 =0A=
________________________________________=0A=
From: Greg Gallagher <greg@embeddedgreg.com>=0A=
Sent: 24 April 2018 15:34=0A=
To: Gustav Johansson=0A=
Cc: Xenomai@xenomai.org=0A=
Subject: Re: [Xenomai] Illegal instruction/bad syscall=0A=
=0A=
Have you considered using mainline?  I'm not sure if anyone has been=0A=
testing the raspberry pi tree against stable xenomai-3.  I've=0A=
validated most of the xenomai-3 stable branch against raspberry pi 2b=0A=
(mainline) so I've looked at most of the bcm code recently and i=0A=
haven't git the syscall issue.  Some of the maintainers are also=0A=
looking to test ARM64 rpi3 so if you want to try getting the 64-bit=0A=
mainline kernel running on your board I can give you some help.=0A=
=0A=
-Greg=0A=
=0A=
On Tue, Apr 24, 2018 at 8:38 AM, Gustav Johansson <gusjohan@kth.se> wrote:=
=0A=
> Hi!=0A=
>=0A=
>=0A=
> I recently managed to run a cobalt core for raspberry pi 3, Im using ipip=
e #9 for arm,  kernel version 4.1.21, Xenomai 3.0.6.=0A=
>=0A=
>=0A=
> I managed to build the xenomai API but when I try every executable file, =
for example latency test bench,  I get "illegal instruction", and in dmesg =
I get "[Xenomai] bad syscall <0xff7000af> ...".=0A=
>=0A=
>=0A=
> The crosscompiler Im using is https://github.com/raspberrypi/tools/tree/m=
aster/arm-bcm2708/gcc-linaro-arm-linux-gnueabihf-raspbian and I have also t=
ried compiling it on the RPI3 itself but Im getting the same error.=0A=
>=0A=
>=0A=
> I have compared my kernel config next to Harco Kuppens  working image (ht=
tp://www.cs.ru.nl/lab/xenomai/) But the only difference is that I have high=
er values in XENO_OPT_SYS_HEAP, XENO_PRIVATE_HEAPS, XENO_OPT_SHARED_HEAPSZ,=
 XENO_OPT_TIMERS.=0A=
>=0A=
>=0A=
> Im uploading a readme with the steps I have taken with the installation a=
nd also my kernel config.=0A=
>=0A=
>=0A=
> Any ideas on why I get "Illegal instruction"?=0A=
>=0A=
>=0A=
> Regards=0A=
>=0A=
> Gustav Johansson=0A=
>=0A=
> -------------- next part --------------=0A=
> A non-text attachment was scrubbed...=0A=
> Name: rpi3_cobalt_4.1.21_config=0A=
> Type: application/octet-stream=0A=
> Size: 126604 bytes=0A=
> Desc: rpi3_cobalt_4.1.21_config=0A=
> URL: <http://xenomai.org/pipermail/xenomai/attachments/20180424/fd49797a/=
attachment.obj>=0A=
> -------------- next part --------------=0A=
> A non-text attachment was scrubbed...=0A=
> Name: readme.md=0A=
> Type: text/markdown=0A=
> Size: 6403 bytes=0A=
> Desc: readme.md=0A=
> URL: <http://xenomai.org/pipermail/xenomai/attachments/20180424/fd49797a/=
attachment.bin>=0A=
> _______________________________________________=0A=
> Xenomai mailing list=0A=
> Xenomai@xenomai.org=0A=
> https://xenomai.org/mailman/listinfo/xenomai=0A=

