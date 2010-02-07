Message-ID: <4B6E8167.6010907@domain.hid>
Date: Sun, 07 Feb 2010 10:01:27 +0100
From: Roland Stigge <stigge@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------030608040205090203000005"
Subject: [Xenomai-core] Xenomai in Debian
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Xenomai core <Xenomai-core@domain.hid>
Cc: Jan Kiszka <jan.kiszka@domain.hid>

This is a multi-part message in MIME format.
--------------030608040205090203000005
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I'm just working on the Xenomai 2.5.1 Debian package and encountered 
non-PIC code (evil! ;-) in the shared libraries (skins libraries).

You can see it with e.g.

$ readelf -d src/skins/native/.libs/libnative.so.3.0.0

The "TEXTREL" tag indicates non-PIC code.

$ scanelf -qT src/skins/native/.libs/libnative.so.3.0.0

Shows the function and code offset of the relocation.

With

$ objdump -d src/skins/native/.libs/libnative.so.3.0.0

I found the actual location of the relocation.

I prepared a patch (attached) that fixes it: First, the relocation 
itself by letting GCC create the address in PIC style. Second, "extern 
inline" looks a bit counterintuitive at first, but according to the GCC 
manual, it seems to be what we want (macro behaviour).

Thanks Jan for reminding me!

bye,
   Roland

--------------030608040205090203000005
Content-Type: text/x-patch;
 name="xenomai.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="xenomai.patch"

--- xenomai-2.5.1.orig/include/asm-x86/syscall.h
+++ xenomai-2.5.1/include/asm-x86/syscall.h
@@ -161,9 +161,11 @@
      ".endif\n\t"
      ".endm\n\t");
 
-static inline void __xn_get_eip(void **dest)
+__attribute__((always_inline))
+extern inline void __xn_get_eip(void **dest)
 {
-        asm volatile("movl $1f, %0; 1:": "=m"(*dest));
+addr:
+	*dest = &&addr;
 }
 
 static inline void __xn_get_ebp(void **dest)

--------------030608040205090203000005--

