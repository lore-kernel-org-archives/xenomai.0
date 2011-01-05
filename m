From: "Gianni Perugini" <gperugini@domain.hid>
References: <003001cbacde$f43fa500$dcbeef00$@com>
	<4D2476A5.5080908@domain.hid>
In-Reply-To: <4D2476A5.5080908@domain.hid>
Date: Wed, 5 Jan 2011 15:03:37 +0100
Message-ID: <003601cbace1$5a56fb20$0f04f160$@com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0037_01CBACE9.BC1B6320"
Content-Language: it
Subject: [Xenomai-help] R:  XDDP socket problem
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: 'Gilles Chanteperdrix' <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

This is a multi-part message in MIME format.

------=_NextPart_000_0037_01CBACE9.BC1B6320
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Gilles,

Attached is the log with the result of the command you asked for.

Thank you

Gianni Perugini
Ilapak Italia S.p.A.
Via L.Lama 11/13
52045 - Foiano della Chiana (AR)
Phone: +39 0575 649751
Fax: +39 0575 649753
Mobile: +39 349 2377467
Email: gperugini@domain.hid
Web: www.ilapak.com

-----Messaggio originale-----
Da: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org
Inviato: mercoled=C3=AC 5 gennaio 2011 14.48
A: Gianni Perugini
Cc: xenomai@xenomai.org
Oggetto: Re: [Xenomai-help] XDDP socket problem

Gianni Perugini wrote:
> Hi,
>=20
> =20
>=20
> I would like to use XDDP-based RT/NRT threads communication on my
> application, but I'm having some problems. I can build successfully =
the file
> "XDDP-ECHO.C" found in the "EXAMPLES" folder, but when I start it, it =
fails
> with the following error: "socket: Address family not supported by
> protocol".
>=20
> =20
>=20
> Please find attached config file, dmesg log and lsmod log.
>=20
> I'm using kernel 2.6.35.7 and xenomai 2.5.5.2 with
> adeos-ipipe-2.6.35.7-x86-2.8-01.patch.

Then you probably do not compile it correctly. Please show us the result
of the command:

nm -s xddp-echo

--=20
					    Gilles.

------=_NextPart_000_0037_01CBACE9.BC1B6320
Content-Type: application/octet-stream;
	name="nm.log"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="nm.log"

0804a4b4 d _DYNAMIC=0A=
0804a5a8 d _GLOBAL_OFFSET_TABLE_=0A=
080492ec R _IO_stdin_used=0A=
         w _Jv_RegisterClasses=0A=
0804a4a4 d __CTOR_END__=0A=
0804a4a0 d __CTOR_LIST__=0A=
0804a4ac D __DTOR_END__=0A=
0804a4a8 d __DTOR_LIST__=0A=
0804949c r __FRAME_END__=0A=
0804948c r __FUNCTION__.5179=0A=
0804a4b0 d __JCR_END__=0A=
0804a4b0 d __JCR_LIST__=0A=
0804a6a0 A __bss_start=0A=
0804a640 D __data_start=0A=
080492a0 t __do_global_ctors_aux=0A=
08048bd0 t __do_global_dtors_aux=0A=
0804a644 D __dso_handle=0A=
         U __errno_location@domain.hid=
         w __gmon_start__=0A=
08049295 T __i686.get_pc_thunk.bx=0A=
0804a4a0 d __init_array_end=0A=
0804a4a0 d __init_array_start=0A=
08049290 T __libc_csu_fini=0A=
08049220 T __libc_csu_init=0A=
         U __libc_start_main@domain.hid=
0804a6a0 A _edata=0A=
0804a6b0 A _end=0A=
080492cc T _fini=0A=
080492e8 R _fp_hw=0A=
08048944 T _init=0A=
08048ba0 T _start=0A=
         U asprintf@domain.hid=
         U bind@domain.hid=
08048f6b T cleanup_upon_sig=0A=
         U clock_nanosleep@domain.hid=
0804a6a0 b completed.5522=0A=
0804a640 W data_start=0A=
0804a6a4 b dtor_idx.5524=0A=
         U exit@domain.hid=
08048c54 t fail=0A=
08048c30 t frame_dummy=0A=
08048fca T main=0A=
         U memset@domain.hid=
         U mlockall@domain.hid=
0804a660 d msg=0A=
0804a6ac B nrt=0A=
         U open@domain.hid=
         U perror@domain.hid=
         U pthread_attr_init@domain.hid=
         U pthread_attr_setdetachstate@domain.hid=
         U pthread_attr_setinheritsched@domain.hid=
         U pthread_attr_setschedparam@domain.hid=
         U pthread_attr_setschedpolicy@domain.hid=
         U pthread_cancel@domain.hid=
         U pthread_create@domain.hid=
         U pthread_join@domain.hid=
         U pthread_sigmask@domain.hid=
         U read@domain.hid=
08048c71 T realtime_thread=0A=
         U recvfrom@domain.hid=
08048ea0 T regular_thread=0A=
0804a6a8 B rt=0A=
         U rt_print_auto_init=0A=
         U rt_printf=0A=
         U sendto@domain.hid=
         U setsockopt@domain.hid=
         U sigaddset@domain.hid=
         U sigemptyset@domain.hid=
         U signal@domain.hid=
         U sigsuspend@domain.hid=
         U socket@domain.hid=
         U strlen@domain.hid=
         U write@domain.hid=

------=_NextPart_000_0037_01CBACE9.BC1B6320--


