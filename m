Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Apr 2009 11:16:19 +0200
Message-ID: <4B2EEE69E41E524EB7FCDC62A15D68D802E1D45D@ARVMAIL1.mra.roland-man.biz>
From: <thomas.debes@domain.hid>
Subject: [Xenomai-help] problems with sigxcpu
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

Hello,

recently I was playing around with SIGXCPU to provide a modeswitch =
notification in our application. Therefore I started with the native =
example sigxcpu.c. When running it I got 2 different modeswitch sources: =
the first one comes from rt_task_trampoline (task.c:85) while the second =
one comes from the call to printf() which I expected to get (see the =
following backtrace).=20

What is the reason for the first modeswitch? Is it by design? I am using =
Xenomai 2.4.6.

Thanks for your help
Thomas

prompt:/fat # ./sigxcpu
./sigxcpu[0x10001990]
/lib/libpthread.so.0[0xff9ad38]
[0x300367a8]
/usr/lib/xenomai/libnative.so.0[0xff6b4ec]
/lib/libpthread.so.0[0xff957f0]
/lib/libc.so.6(__clone+0x58)[0xfee9dc4]
./sigxcpu[0x10001990]
/lib/libpthread.so.0[0xff9ad38]
[0x30036788]
./sigxcpu[0x10001954]
/usr/lib/xenomai/libnative.so.0[0xff6b5f0]
/lib/libpthread.so.0[0xff957f0]
/lib/libc.so.6(__clone+0x58)[0xfee9dc4]
Switched to secondary mode
./sigxcpu[0x10001990]
/lib/libpthread.so.0[0xff9ad38]
[0x30036048]
/lib/libc.so.6(__write+0x38)[0xfedbbbc]
/lib/libc.so.6(_IO_file_write+0x48)[0xfe79b88]
/lib/libc.so.6[0xfe78aa4]
/lib/libc.so.6(_IO_do_write+0x38)[0xfe78a28]
/lib/libc.so.6(_IO_file_overflow+0x174)[0xfe79258]
/lib/libc.so.6(_IO_file_xsputn+0x114)[0xfe79d18]
/lib/libc.so.6(_IO_vfprintf+0x244)[0xfe51da0]
/lib/libc.so.6(printf+0x90)[0xfe5bdb4]
./sigxcpu[0x10001964]
/usr/lib/xenomai/libnative.so.0[0xff6b5f0]
/lib/libpthread.so.0[0xff957f0]
/lib/libc.so.6(__clone+0x58)[0xfee9dc4]
Switched to secondary mode

--------------------------------------------------------
manroland AG
Vorsitzender des Aufsichtsrates: Hanno C. Fiedler
Vorstand: Gerd Finkbeiner (Vorsitzender), Dr. Ingo Koch, Dr. Markus =
Rall, Paul Steidle  =20
Sitz der Gesellschaft: Offenbach am Main, Registergericht: Amtsgericht =
Offenbach HRB-Nr. 42592
USt-Ident-Nr. DE 250200933

