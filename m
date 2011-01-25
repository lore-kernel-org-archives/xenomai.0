Date: Tue, 25 Jan 2011 10:46:07 +0100 (CET)
From: Kolja Waschk <xenoka09@domain.hid>
In-Reply-To: <4D3E97D5.3050609@domain.hid>
Message-ID: <alpine.DEB.1.10.1101251039180.12329@domain.hid>
References: <alpine.DEB.1.10.1101251010320.12329@domain.hid>
	<4D3E97D5.3050609@domain.hid>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: "Kolja Waschk,,," <xenoka09@domain.hid>
Subject: Re: [Xenomai-help] NULL pointer access on bfin when linking with
 xenomai and pthread
Reply-To: xenoka09@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

> Some Xenomai code is executed before the main function is called. What I
> do not understand is why gdb does not stop at the place of the segfault?

Good point. Sorry, it does, but I fail to get useful information from there. Even
with -g and

> set solib-absolute-prefix notexistent
> set solib-search-path /opt/uClinux/blackfin-linux-dist/staging/usr/lib:/opt/uClinux/bfin-linux-uclibc/bfin-linux-uclibc/runtime/lib

..gdb doesn't seem to be able to resolve the addresses in the library:

Program received signal SIGSEGV, Segmentation fault.
0x01666f10 in ?? ()
(gdb) bt
#0  0x01666f10 in ?? ()
#1  0x01666eda in ?? ()
Backtrace stopped: previous frame identical to this frame (corrupt stack?)
(gdb) info sharedlibrary 
>From        To          Syms Read   Shared Object Library
0x016c33cc  0x016c8244  No          /opt/uClinux-2010R1-RC5_tools-RC4/blackfin-linux-dist/staging/usr/lib/libpthread_rt.so.1
0x00ea936c  0x00eab048  No          /opt/uClinux-2010R1-RC5_tools-RC4/blackfin-linux-dist/staging/usr/lib/libxenomai.so.0
0x01664108  0x016689ec  No          /opt/uClinux-2010R1-RC5_tools-RC4/bfin-linux-uclibc/bfin-linux-uclibc/runtime/lib/libpthread.so.0
0x0152060c  0x01520a54  No          /opt/uClinux-2010R1-RC5_tools-RC4/bfin-linux-uclibc/bfin-linux-uclibc/runtime/lib/librt.so.0
0x016523d4  0x0165dd88  No          /opt/uClinux-2010R1-RC5_tools-RC4/bfin-linux-uclibc/bfin-linux-uclibc/runtime/lib/libgcc_s.so.1
0x0160ca24  0x01636df8  No          /opt/uClinux-2010R1-RC5_tools-RC4/bfin-linux-uclibc/bfin-linux-uclibc/runtime/lib/libc.so.0
0x019c0c60  0x019c4634  No          /opt/uClinux-2010R1-RC5_tools-RC4/bfin-linux-uclibc/bfin-linux-uclibc/runtime/lib/ld-uClibc.so.0
(gdb)



Kolja



