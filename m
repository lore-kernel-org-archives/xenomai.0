Message-ID: <43455a600802150455p41ea028excec13d73ff4f1114@domain.hid>
Date: Fri, 15 Feb 2008 18:25:31 +0530
From: "rakesh bk" <rakeshbk402@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_6895_27355507.1203080131951"
Subject: [Xenomai-help] Error while porting xenomai to power pc 750Cxe based
	SBC
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

------=_Part_6895_27355507.1203080131951
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello Everyone

I am new to Xenomai , I have ported linux-2.6.14 to our custom board based
   on IBM750Cxe Iam unable to boot my kernel cross compiled with eldk-3.0with
   enabled xenomai support.If i remove xenomai and ipipe support     the
kernel
   boots correctly , but if i enable i get the following oops message .
   The following patches are applied and arguements of scripts/prepare-
   kernel.sh is mentioned as follows
   adeos-ipipe-2.6.14-ppc-1.3-05.patch,
   Target architecture [default i686]: ppc
   Adeos patch[default linux-2.6.14/xenomai-2.2.0
   /ksrc/arch/powerpc/patches
/adeos-ipipe-2.6.14-ppc64-1.2-03.patch]:
   adeos-ipipe-2.6.14-ppc-1.3-05.patch,

Xenomai: ALTIVEC support enabled in kernel but no hardware found.
         Disable CONFIG_ALTIVEC in the kernel configuration.
Xenomai: system init failed, code -19.
Xenomai: native skin init failed, code -19.
Xenomai: starting POSIX services.
Xenomai: POSIX skin init failed, code -19.
Xenomai: RTDM skin init failed, code -19.

Thanks ,
with regards,
           Rakesh.B.K

------=_Part_6895_27355507.1203080131951
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello Everyone<br><br>I am new to Xenomai , I have ported linux-2.6.14 to our custom board based<br>&nbsp;&nbsp; on IBM750Cxe Iam unable to boot my kernel cross compiled with eldk-3.0 with<br>&nbsp;&nbsp; enabled xenomai support.If i remove xenomai and ipipe support&nbsp;&nbsp;&nbsp;&nbsp; the kernel<br>
&nbsp;&nbsp; boots correctly , but if i enable i get the following oops message .<br>&nbsp;&nbsp; The following patches are applied and arguements of scripts/prepare-<br>&nbsp;&nbsp; kernel.sh is mentioned as follows<br>&nbsp;&nbsp; adeos-ipipe-2.6.14-ppc-1.3-05.patch,<br>
&nbsp;&nbsp; Target architecture [default i686]: ppc<br>&nbsp;&nbsp; Adeos patch[default linux-2.6.14/xenomai-2.2.0<br>&nbsp;&nbsp; /ksrc/arch/powerpc/patches<br>/adeos-ipipe-2.6.14-ppc64-1.2-03.patch]:<br>&nbsp;&nbsp; adeos-ipipe-2.6.14-ppc-1.3-05.patch,<br><br>
Xenomai: ALTIVEC support enabled in kernel but no hardware found.<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Disable CONFIG_ALTIVEC in the kernel configuration.<br>Xenomai: system init failed, code -19.<br>Xenomai: native skin init failed, code -19.<br>
Xenomai: starting POSIX services.<br>Xenomai: POSIX skin init failed, code -19.<br>Xenomai: RTDM skin init failed, code -19.<br><br>Thanks ,<br>with regards,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Rakesh.B.K<br><br><br>

------=_Part_6895_27355507.1203080131951--

