Message-ID: <4BB23959.6000009@domain.hid>
Date: Tue, 30 Mar 2010 19:48:09 +0200
From: Patrice Kadionik <kadionik@domain.hid>
MIME-Version: 1.0
References: <507168.65506.qm@domain.hid>,
	<4BAF58F7.7070707@domain.hid>
	<B66DE711C138E84F96E6A2EDD078830B5F2A4D39D0@domain.hid>,
	<4BB1B839.9060002@domain.hid>
	<B66DE711C138E84F96E6A2EDD078830B5F2A4D39D1@domain.hid>
In-Reply-To: <B66DE711C138E84F96E6A2EDD078830B5F2A4D39D1@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Problem to cross-compile Xenomai
	user-space	support
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Huan Fang <huanf@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Le 30/03/2010 19:37, Huan Fang a =E9crit :
> Hi Patrice,
>
> I probably know why it fails the first time.
>
> before modification, my nios2.h has
>
> /* system timer input clock frequency */
> #define nasys_clock_freq                                       10000000=
0
> #define nasys_clock_freq_1000                                     10000=
0
>
> /* Redefining hrtimer ->  timer0 */
> #undef na_hrtimer
> #undef na_hrtimer_irq
>
> #define na_timer0                                  ((void *) 0x09609080=
)
> #define na_timer0_irq                                                  =
1
>
>
> The script  altera_avalon_timer.pm will redefine the first timer (by th=
e order of address?) to timer_0.
> In your case, sys_clk_timer is your first timer, that's why it's correc=
tly redefined to timer_0 used in time.c
>   =20
OK. You have the same thing with MicroBlaze and .DTS file with dtb=20
parsing during kernel booting! Thank you for this info.
> This is tricky, either we should improve the script or manually check(h=
ack) the timer settings.
>
> By the way, I haven't successfully compiled user space xenomai stuff, I=
 will let you know when it's done.
>   =20
OK, read the other messages of this thread. Gilles proposes 2 patchs for=20
Xenomai 2.5.2 for correcting error compilation (sem_heap.c, vdso-check.c=20
and cond-torture.c)

Cheers;

Patrice

> Best Regards,
> Huan
> ________________________________________
> From: Patrice Kadionik [kadionik@domain.hid]
> Sent: 30 March 2010 10:37
> To: Huan Fang
> Cc: xenomai@xenomai.org
> Subject: Re: [Xenomai-help] Problem to cross-compile Xenomai user-space=
 support
>
> Le 30/03/2010 00:20, Huan Fang a =E9crit :
>   =20
>> Hi Patrice,
>>
>>     =20
> Hi Huan,
>
> Have you really used  uClinux with NIOS2 without MMU in your Quartus II
> design? Have you synchronized the =B5Clinux kernel file version with th=
e
> NIOS2 ipipe version?
>
>   =20
>> Many thanks for the tutorial, Now I am able to run xenomai patched ucl=
inux on my DE2-70 board.
>> But the kernel doesn't boot unless I modified one file :linux-2.6/arch=
/nios2/kernel/time.c
>>
>> na_timer0 ->   na_sys_clock_timer which I guess is the clock timer use=
d by Linux. Did you manually patch this file?
>> The adeos patch doesn't seem to change this part.
>>
>>     =20
> Not at all.
>
> If you have done this:
> $ make vendor_hwselect SYSPTF=3Dmy_design.ptf
> it generates a nios2.h under uClinux-dist/linux-2.6.x/include/asm-nios2
> in which you have na_sys_clk_timer redefined as na_timer0.
> For example, in my nios2.h generated file, I have:
> /* Executing ...scripts/nios2.h/altera_avalon_timer.pm */
>
> /* system timer input clock frequency */
> #define nasys_clock_freq                                        5000000=
0
> #define nasys_clock_freq_1000                                      5000=
0
>
> /* Redefining sys_clk_timer ->  timer0 */
> #undef na_sys_clk_timer
> #undef na_sys_clk_timer_irq
>
> #define na_timer0                                  ((void *) 0x00810800=
)
>
> Please send me in a private email your nios2.h file.
>
> Patrice
>
>
>
>   =20


--=20
Patrice Kadionik. F6KQH / F4CUQ
-----------

+----------------------------------------------------------------------+
+"Tout doit etre aussi simple que possible, pas seulement plus simple" +
+----------------------------------------------------------------------+
+ Patrice Kadionik             http://www.enseirb-matmeca.fr/~kadionik +
+ IMS Laboratory               http://www.ims-bordeaux.fr/             +
+ ENSEIRB-MATMECA              http://www.enseirb-matmeca.fr           +
+ PO BOX 99                    fax   : +33 5.56.37.20.23               +
+ 33402 TALENCE Cedex          voice : +33 5.56.84.23.47               +
+ FRANCE                       mailto:patrice.kadionik@domain.hid +
+----------------------------------------------------------------------+


