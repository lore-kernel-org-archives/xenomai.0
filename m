Message-Id: <47E391790200000100192E6B@nwque-vm-gwia.criq.qc.ca>
Date: Fri, 21 Mar 2008 10:44:09 -0400
From: "Hubert Talbot" <Hubert.Talbot@domain.hid>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Subject: [Xenomai-help] =?utf-8?q?R=C3=A9p=2E_=3A_Re=3A__trivial-periodic?=
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: gilles.chanteperdrix@xenomai.org
Cc: xenomai@xenomai.org

Great!=20

Booting with idle=3Dpoll fixes the problem.

If I disabled ACPI completeley, would it fix the problem too?

Thanks=20

Hubert


>>> "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org> 21/03/08 6:04 =
>>>
On Thu, Mar 20, 2008 at 6:06 PM, Hubert Talbot <Hubert.Talbot@domain.hid> =
wrote:
> Hi,
>
>  $xenomai_root/examples/native/trivial-periodic output is something like =
this:
>
>  Time since last turn: 1004.067456 ms
>  Time since last turn: 995.913359 ms
>  Time since last turn: 999.998131 ms
>  Time since last turn: 1000.002309 ms
>  Time since last turn: 1000.040204 ms
>  Time since last turn: 999.999632 ms
>  Time since last turn: 1000.040546 ms
>  Time since last turn: 999.939968 ms
>  Time since last turn: 1000.039897 ms
>  Time since last turn: 1000.021035 ms
>  Time since last turn: 999.958009 ms
>  Time since last turn: 999.920890 ms
>  Time since last turn: 999.716995 ms
>  Time since last turn: 1002.324537 ms
>  Time since last turn: 997.977492 ms
>  Time since last turn: 1000.019093 ms
>
>  When I move the mouse, results go away from 1000.
>
>  Strangely, when I run a stress test with dd if=3D/dev/zero of=3D/dev/nul=
l,
>  results stay near to 1000 even if I move the mouse:
>
>  Time since last turn: 1000.000142 ms
>  Time since last turn: 1000.000696 ms
>  Time since last turn: 999.997329 ms
>  Time since last turn: 1000.001777 ms
>  Time since last turn: 1000.000580 ms
>  Time since last turn: 999.999695 ms
>  Time since last turn: 1000.000101 ms
>  Time since last turn: 1000.000017 ms
>  Time since last turn: 999.999489 ms
>  Time since last turn: 1000.000937 ms
>  Time since last turn: 1000.000010 ms
>  Time since last turn: 999.999418 ms
>  Time since last turn: 999.999737 ms
>  Time since last turn: 1000.000531 ms
>  Time since last turn: 999.999039 ms
>  Time since last turn: 1000.001454 ms
>  Time since last turn: 999.999553 ms
>  Time since last turn: 999.999125 ms
>  Time since last turn: 1000.001908 ms
>  Time since last turn: 999.998908 ms
>  Time since last turn: 1000.000700 ms
>  Time since last turn: 999.998672 ms
>
>
>  Also, when I run testsuite/latency/run, I got
>
>  RTT|  00:00:01  (periodic user-mode task, 100 us period, priority 99)
>  RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat =
worst
>  RTD|      -4.940|      -0.964|      17.237|       0|      -4.940|      =
17.237
>  RTD|      -4.963|      -1.023|      17.144|       0|      -4.963|      =
17.237
>  RTD|      -5.131|      -1.040|      17.283|       0|      -5.131|      =
17.283
>  RTD|      -5.146|      -1.029|      17.399|       0|      -5.146|      =
17.399
>  RTD|      -5.086|      -1.034|      16.782|       0|      -5.146|      =
17.399
>  RTD|      -5.126|      -1.041|      16.996|       0|      -5.146|      =
17.399
>  RTD|      -5.095|      -1.039|      17.028|       0|      -5.146|      =
17.399
>  RTD|      -5.132|      -3.274|      16.240|       0|      -5.146|      =
17.399
>  RTD|      -4.969|      -4.890|      -1.550|       0|      -5.146|      =
17.399
>  RTD|      -5.020|      -4.880|      -0.282|       0|      -5.146|      =
17.399
>  RTD|      -4.966|      -4.881|      -1.046|       0|      -5.146|      =
17.399
>  RTD|      -5.039|      -4.895|      -0.833|       0|      -5.146|      =
17.399
>  RTD|      -5.032|      -4.882|      -0.151|       0|      -5.146|      =
17.399
>  RTD|      -5.037|      -4.886|      -1.561|       0|      -5.146|      =
17.399
>  RTD|      -4.966|      -3.665|      19.858|       0|      -5.146|      =
19.858
>  RTD|      -5.145|      -1.029|      17.900|       0|      -5.146|      =
19.858
>  RTD|      -5.128|      -1.018|      16.966|       0|      -5.146|      =
19.858
>
>
>  Negative "lat max" values are the ones when dd if=3D/dev/zero of=3D/dev/=
null is running.
>
>
>
>  Is it normal?
>
>
>  Setup:
>         adeos-ipipe-2.6.23-x86_64-1.4-03.patch
>         linux-2.6.23
>         xenomai-2.4.2

Is it possible that something (like the ACPI processor module) is
stopping the tsc on your test box ? Can you try and boot with
idle=3Dpoll on the kernel command line ?

--=20
 Gilles


