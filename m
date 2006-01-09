From: Niklaus Giger <niklaus.giger@domain.hid>
Subject: Re: [Xenomai-core] Two patches for the documentation
Date: Mon, 9 Jan 2006 21:34:01 +0100
References: <200601072103.32588.niklaus.giger@domain.hid>
	<43C0EF40.6090501@domain.hid>
In-Reply-To: <43C0EF40.6090501@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601092134.02094.niklaus.giger@domain.hid>
Reply-To: niklaus.giger@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

Am Sonntag, 8. Januar 2006 11.53 schrieb Philippe Gerum:
> Niklaus Giger wrote:
> > Hi
<...>
> > Index: sim/README
> > ===================================================================
> > --- sim/README	(Revision 392)
> > +++ sim/README	(Arbeitskopie)
> > @@ -28,7 +28,11 @@
> >  Building the simulator
> >  ======================
> >
> > -You will need the libelf, libpng, tcl8.x/tk8.x and tix41 _development
> > +The simulator does not build with GCC 4.0 or later.
> > +
> > +Currently it does not work on PowerPC systems.
> > +
>
> Why?

xenoscope is not even able to open a window as apparently it goes somewhere 
into a recursion. I do not know however how to debug it.

gdb /usr/xenomai/bin/xenoscope
GNU gdb 6.3-debian
Copyright 2004 Free Software Foundation, Inc.
GDB is free software, covered by the GNU General Public License, and you are
welcome to change it and/or distribute copies of it under certain conditions.
Type "show copying" to see the conditions.
There is absolutely no warranty for GDB.  Type "show warranty" for details.
This GDB was configured as "powerpc-linux"...Using host libthread_db library 
"/lib/tls/libthread_db.so.1".

(gdb) run
Starting program: /usr/xenomai/bin/xenoscope
[Thread debugging using libthread_db enabled]
[New Thread 805421056 (LWP 25333)]
[New Thread 813860064 (LWP 25336)]

Program received signal SIGSEGV, Segmentation fault.
[Switching to Thread 805421056 (LWP 25333)]
0x0f80c2e8 in strchr () from /lib/tls/libc.so.6
(gdb) info stack
#0  0x0f80c2e8 in strchr () from /lib/tls/libc.so.6
#1  0x0fef3958 in TkpGetFontFamilies () from /usr/lib/libtk8.4.so.0
#2  0x0fef3958 in TkpGetFontFamilies () from /usr/lib/libtk8.4.so.0
#3  0x0fef3958 in TkpGetFontFamilies () from /usr/lib/libtk8.4.so.0
#4  0x0fef3958 in TkpGetFontFamilies () from /usr/lib/libtk8.4.so.0
<..>
#63 0x0fef3958 in TkpGetFontFamilies () from /usr/lib/libtk8.4.so.0
Previous frame inner to this frame (corrupt stack?)

Best regards
-- 
Niklaus Giger

