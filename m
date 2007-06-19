Message-ID: <46778964.3070608@domain.hid>
Date: Tue, 19 Jun 2007 09:44:36 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <OF815057E3.6D5C9810-ONC12572FF.00287AFE-C12572FF.0028A289@domain.hid>
In-Reply-To: <OF815057E3.6D5C9810-ONC12572FF.00287AFE-C12572FF.0028A289@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig9C0325279BC4E908B38CA7D5"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] xeno-2.3.1 shared interrups BUG?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: apittaluga@domain.hid
Cc: xenomai-help <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig9C0325279BC4E908B38CA7D5
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

apittaluga@domain.hid wrote:
> Hi,
> running a simple test application which spawns a periodic task writing =
on a
> serial interface
> the system hangs performing the rt_dev_close.
> The test program ran fine with xeno 2.2.6 with "Shared Interrupts" enab=
led,
> so as with
> xeno 2.3.1 with "Shared Interrupts" disabled. It fails with xeno 2.3.1 =
with
> "Shared Interrupts" enabled, so the problem seems to be in the shared
> interrupts handling area.
> kernel is 2.6.20 adeos patched
>=20
> Any suggestion?

Argh, not good. Sounds like our IRQ detachment code is still racy.

>=20
> Many Thanks
>=20
> here follows the kernel dumps:
>=20
> BUG: unable to handle kernel NULL pointer dereference at virtual addres=
s
> 00000008
> printing eip:
> *pde =3D 00000000
> Oops: 0000 [#1]
> SMP
> Modules linked in: xeno_16550A ipv6 nfs lockd sunrpc ide_scsi i2c_i801
> i2c_core sg shpchp rng_core evdev ehci_hcd uhci_hcd intel
> _agp agpgart e1000 serio_raw pcspkr
> CPU: 0
> EIP: 0060: Not tainted VLI
> EFLAGS: 00010046 (2.6.20.1-xeno-2.3.1 #16)
> EIP is at xnintr_edge_shirq_handler+0xda/0x2f0

Do you know how to resolve this address into source code?
CONFIG_DEBUG_INFO needs to be on, "gdb vmlinux" and then "disassemble
xnintr_edge_shirq_handler" would give you that context. Please post the
full disassembly of that function. That may help us by pointing at the
variable that is causing the oops here.

> eax: 00000000 ebx: 00000000 ecx: f2d58074 edx: c0529080
> esi: c05290c0 edi: 69bfb728 ebp: 000000c9 esp: c04b9f08
> ds: 007b es: 007b ss: 0068
> I-pipe domain Xenomai
> Process modprobe (pid: 1876, ti=3Df7a44000 task=3Df7d7d030 task.ti=3Df7=
a44000)
> Stack: c047d100 c0487400 00000001 00000001 00000001 f2d58050 c0527a10
> c05293f8
> 00000004 c04fbc38 c051d100 00000004 00000000 c0143fa8 00000000 c047d100=

> c051d100 c04fbc38 00000000 00000004 c0527400 c0112de2 c03bc88a 00000000=

> Call Trace:
> __ipipe_dispatch_wired+0xdB/0x120
> __ipipe_handle_irq+0x72/0x2b0
> schedule+0x41a/0x880
> common_interrupt+0x21/0x38
> mwait_idle_with_hints+0x3f/0x50
> mwait_idle+0x0/0x10
> cpu_idle+0x6f/0x90
> start_kernel+0x1d0/0x240
> unknown_bootoption+0x0/0x190
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Code: 03 00 00 89 f0 89 96 b4 03 00 00 8b 15 80 87 52 c0 29 d0 83 e8 40=
 c1
> f8 04 69 c0 ab aa aa aa 8d 44 18 24 87 86 b8 03 00 00
> 89 d9 <ff> 53 08 09 44 24 10 0f b6 d0 83 fa 02 0f 84 04 01 00 00 4a 0f
> EIP: xnintr_edge_shirq_handler+0xda/0x2f0 SS:ESP 0068:c04b9f08
> Kernel panic - not syncing: Attempted to kill the idle task!
>=20
> hardware:
> Intel Core DUO Processor Single Board Computer
>=20
> here follows the test application:
>=20
> #include <sys/types.h>
> #include <sys/stat.h>
> #include <fcntl.h>
> #include <stdio.h>
> #include <string.h>
> #include <unistd.h>
> #include <stdlib.h>
>=20
> #include <signal.h>
> #include <sys/mman.h>
>=20
> #include <native/task.h>
> #include <native/timer.h>
> #include <rtdm/rtserial.h>
>=20
> #define FALSE 0
> #define TRUE 1
> #define BAUDRATE B115200
>=20
> #define WRITE_FILE "rtser0"
>=20
> RT_TASK rt_writer_tid;
> int fd;
>=20
> static const struct rtser_config write_config =3D {
> 0xFFDF, /* config_mask */
> 115200, /* baud_rate */
> RTSER_DEF_PARITY, /* parity */
> RTSER_DEF_BITS, /* data_bits */
> RTSER_DEF_STOPB, /* stop_bits */
> RTSER_DEF_HAND, /* handshake */
> RTSER_DEF_FIFO_DEPTH, /* fifo_depth*/
> RTSER_DEF_TIMEOUT, /* rx_timeout */
> RTSER_DEF_TIMEOUT, /* tx_timeout */
> RTSER_DEF_TIMEOUT, /* event_timeout */
> RTSER_DEF_TIMESTAMP_HISTORY /* timestamp_history */
> };
>=20
> void rt_writer (void *cookie)
> {
> int error;
> int res;
> char* msg =3D "abrac";
> error =3D rt_task_set_periodic(NULL,
> TM_NOW,
> rt_timer_ns2ticks(32000000));
>=20
> for (;;) {
> error =3D rt_task_wait_period(NULL);
> res =3D rt_dev_write(fd, msg, strlen(msg));
>=20
> }
> }
>=20
>=20
> void cleanup_upon_sig(int sig __attribute__((unused)))
> {
>=20
>=20
> rt_dev_close(fd);
>=20
> exit(0);
> }
>=20
> int main(int argc, char** argv)
> {
> int error;
>=20
>=20
> mlockall(MCL_CURRENT|MCL_FUTURE);
>=20
> signal(SIGINT, cleanup_upon_sig);
> signal(SIGTERM, cleanup_upon_sig);
> signal(SIGHUP, cleanup_upon_sig);
> signal(SIGALRM, cleanup_upon_sig);
>=20
> fd =3D rt_dev_open(WRITE_FILE, 0);
> if (fd < 0) {
> perror(WRITE_FILE);
> cleanup_upon_sig(0);
> }
> error =3D rt_dev_ioctl(fd, RTSER_RTIOC_SET_CONFIG, &write_config);
> if (error) {
> printf("error while RTSER_RTIOC_SET_CONFIG, code %d\n",error);
> cleanup_upon_sig(0);
> }
>=20
> error =3D rt_task_spawn(&rt_writer_tid,"rt_writer",0,99,T_FPU,
> rt_writer, NULL);
> if (error) {
> printf("rt_task_spawn: code %d\n",error);
> return 2;
> }
> pause();
> exit(0);
>=20
> }
>=20
>=20
> Alessandro Pittaluga
>=20
> Alenia Aeronautica
> Avionic System Qualification
> Test Systems
> Corso Marche, 41
> 10146 Torino (Italy)
> Phone +39-011-756.2915
> +39-011-996.0714
> Fax +39-011-756.2517
>=20
>=20

Jan


--------------enig9C0325279BC4E908B38CA7D5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGd4lkniDOoMHTA+kRAmj/AJ0dMbV0wX1DYd6JEO6CPw8x+K1bBgCgghiL
EJlOtBdQU+yRCp+3+XiGmdw=
=URl2
-----END PGP SIGNATURE-----

--------------enig9C0325279BC4E908B38CA7D5--

