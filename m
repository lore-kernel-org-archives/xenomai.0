Message-ID: <54b161f50611010049k5c721465v5472cf50da38efde@domain.hid>
Date: Wed, 1 Nov 2006 09:49:55 +0100
From: "Frits de Klark" <mailing.xenomai@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_23955_17358370.1162370995871"
Subject: [Xenomai-help] Xenomai fresh installation, problems
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

------=_Part_23955_17358370.1162370995871
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello everyone,

yesterday I installed a machine from scratch with Linux and Xenomai. I used
the old configurations for the kernel (and thus Xenomai).
After following the instructions described in README.INSTALL everything
seems to install correctly. No errors, no problems.
But when I try to run the latency test from the testsuite, I get the
following message:

FATAL: Error inserting xeno_timerbench
(/lib/modules/2.6.17-ipipe/kernel/drivers/xenomai/testing/xeno_timerbench.ko):
Kernel does not have module support
Xenomai: native skin or CONFIG_XENO_OPT_PERVASIVE disabled.
(modprobe xeno_native?)
ERROR: Module xeno_timerbench does not exist in /proc/modules

Module support IS enabled however, and the native skin as well as
CONFIG_XENO_OPT_PERVASIVE are both enabled.
My former installation worked without a problem.

Does anyone have any idea what I'm doing wrong here?

Thanks very much in advance.

Best regards,

Frits

------=_Part_23955_17358370.1162370995871
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello everyone,<br>
<br>
yesterday I installed a machine from scratch with Linux and Xenomai. I
used the old configurations for the kernel (and thus Xenomai).<br>
After following the instructions described in README.INSTALL everything seems to install correctly. No errors, no problems.<br>
But when I try to run the latency test from the testsuite, I get the following message:<br>
<br>
FATAL: Error inserting xeno_timerbench
(/lib/modules/2.6.17-ipipe/kernel/drivers/xenomai/testing/xeno_timerbench.ko):
Kernel does not have module support<br>
Xenomai: native skin or CONFIG_XENO_OPT_PERVASIVE disabled.<br>
(modprobe xeno_native?)<br>
ERROR: Module xeno_timerbench does not exist in /proc/modules<br>
<br>
Module support IS enabled however, and the native skin as well as CONFIG_XENO_OPT_PERVASIVE are both enabled.<br>
My former installation worked without a problem. <br>
<br>
Does anyone have any idea what I'm doing wrong here?<br>
<br>
Thanks very much in advance.<br>
<br>
Best regards,<br>
<br>
Frits<br>

------=_Part_23955_17358370.1162370995871--

