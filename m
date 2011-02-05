From: "Franz Engel" <franz_lambert_engel@domain.hid>
References: <mailman.9723.1296855625.10284.xenomai@xenomai.org>	
	<000001cbc4b0$03297d50$097c77f0$@de>
	<1296858744.2087.44.camel@domain.hid>
In-Reply-To: <1296858744.2087.44.camel@domain.hid>
Date: Sat, 5 Feb 2011 20:28:42 +0100
Message-ID: <000001cbc56a$e6237600$b26a6200$@de>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Language: de
Subject: Re: [Xenomai-help] [    1.954665] Xenomai: native skin init failed,
	code -19
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: 'Philippe Gerum' <rpm@xenomai.org>
Cc: xenomai@xenomai.org

Hello Philippe,

In my BIOS I disabled the "Cool 'n' quite" option (I think this is C1E =
for AMD). I tried the patch again but I get a failure-message. I made =
the following steps:
I save the patch to a file ("xen.patch"):
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -637,8 +637,10 @@ void __cpuinit select_idle_routine(const struct =
cpuinfo_x86 *c)
 {
 #ifdef CONFIG_IPIPE
 #define default_to_mwait force_mwait
+#define maybe_c1e  0
 #else
 #define default_to_mwait 1
+#define maybe_c1e  1
 #endif
 #ifdef CONFIG_SMP
        if (pm_idle =3D=3D poll_idle && smp_num_siblings > 1) {
@@ -655,7 +657,7 @@ void __cpuinit select_idle_routine(const struct =
cpuinfo_x86 *c)
                 */
                printk(KERN_INFO "using mwait in idle threads.\n");
                pm_idle =3D mwait_idle;
-       } else if (check_c1e_idle(c)) {
+       } else if (maybe_c1e && check_c1e_idle(c)) {
                printk(KERN_INFO "using C1E aware idle routine\n");
                pm_idle =3D c1e_idle;
        } else

I downloaded/unpacked Xenomai-2.5.5.2
I downloaded/unpacked Linux-2.6.32.20

./prepare-kernel.sh --linux=3D/usr/src/linux-2.6.32.20 =
--adeos=3D/home/xenomai-head/ksrc/arch/x86/patches/adeos-ipipe-2.6.32.20-=
x86-2.6-02.patch

cd /usr/src/linux2.6.32.20
patch -p1 -b < /home/xen.patch

Then I get the following message:
patching file arch/x86/kernel/process.c
Hunk #1 succeeded at 550 with fuzz 1 (offset -87 lines).
Hunk #2 FAILED at 657.
1 out of 2 hunks FAILED -- saving rejects to file =
arch/x86/kernel/process.c.rej

Did I do something wrong?


-----Urspr=C3=BCngliche Nachricht-----
Von: Philippe Gerum [mailto:rpm@xenomai.org
Gesendet: Freitag, 4. Februar 2011 23:32
An: Franz Engel
Cc: xenomai@xenomai.org
Betreff: Re: [Xenomai-help] [ 1.954665] Xenomai: native skin init =
failed, code -19

On Fri, 2011-02-04 at 22:10 +0100, Franz Engel wrote:
> Here is my full boot log:

[snip]

> [    0.030589] tseg: 0000000000
> [    0.030596] CPU: Physical Processor ID: 0
> [    0.030626] CPU: Processor Core ID: 0
> [    0.030657] mce: CPU supports 6 MCE banks
> [    0.030692] using C1E aware idle routine

This means that you are not running the patched kernel. There is no way
the c1e_idle routine which outputs the above message could run with it
applied.

[snip]

> [    0.030000] CPU: L2 Cache: 512K (64 bytes/line)
> [    0.030000] CPU 1/0x1 -> Node 0
> [    0.030000] CPU: Physical Processor ID: 0
> [    0.030000] CPU: Processor Core ID: 1
> [    0.430096] CPU1: AMD Phenom(tm) II X6 1055T Processor stepping 00
> [    0.430357] checking TSC synchronization [CPU#0 -> CPU#1]: passed.
> [    0.440015] System has AMD C1E enabled

This means you BIOS did not disable C1E properly. The CPU still
advertises this mode.=20

In fact, once C1E is properly disabled by the BIOS, you should not need
the patch at all.

Please check your BIOS setup and kernel install. You don't seem to be
running what you think you do actually.

--=20
Philippe.



