From: Wolfgang Denk <wd@domain.hid>
Subject: Re: [Xenomai-core] Patches: README.install & examples/common for
	cross-compiling 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 21 Dec 2006 22:59:05 +0100."
	<200612212259.06016.niklaus.giger@domain.hid> 
Date: Thu, 21 Dec 2006 23:40:04 +0100
Sender: wd@domain.hid
Message-Id: <20061221224004.13E75353C25@domain.hid>
Content-Transfer-Encoding: quoted-printable
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: niklaus.giger@domain.hid
Cc: xenomai@xenomai.org

Dear Niklaus,

in message <200612212259.06016.niklaus.giger@domain.hid> you wrote:
>
> -PowerPC-405-based system:
> +PowerPC-405-based system (assuming an ELDK cross-compiler and a 2.6.14=
 kernel)
                             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
			     This...

> +$ build_root /path/to/build-powerpc-405-2.6.14
> +$ mkdir $build_root
> +$ make ARCH=3Dppc CROSS_COMPILE=3Dpowerpc-405-linux-gnu- O=3D$build_ro=
ot xconfig/gconfig/menuconfig=20
                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
...
> +$ make ARCH=3Dppc CROSS_COMPILE=3Dpowerpc-405-linux-gnu- O=3D$build_ro=
ot bzImage modules=20
                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
...
> +$ $xenomai_root/configure --build=3Di686-linux --host=3Dpowerpc-405-li=
nux-gnu CC=3Dppc_4xx-gcc CXX=3Dppc_4xx-g++ LD=3Dppc_4xx-ld
                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

...and this seems contradictory to me. If you use the ELDK, then it's
"CROSS_COMPILE=3Dppc_4xx-";  also,  I  would  expect   that   you   set
"--target=3Dpowerpc-linux".  I mean, with ELDK, "powerpc-405-linux-gnu"
will neither work as CROSS_COMPILE prefix, nor as  a  host  /  target
name.

Best regards,

Wolfgang Denk

--=20
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@domain.hid
People are always a lot more complicated than you  think.  It's  very
important to remember that.             - Terry Pratchett, _Truckers_

