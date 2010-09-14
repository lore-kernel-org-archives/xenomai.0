Date: Tue, 14 Sep 2010 11:40:17 -0400
From: Edward Hoffman <quantalgo@domain.hid>
In-reply-to: <76E258664B189C4CBEF125491CA11ECC945B6553D4@domain.hid>
Message-id: <1284478817.2345.5.camel@domain.hid>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
References: <76E258664B189C4CBEF125491CA11ECC945B6553D4@domain.hid>
Subject: Re: [Xenomai-help] HELP: Xenomai: POSIX skin or
 CONFIG_XENO_OPT_PERVASIVE disabled
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Zafar Iqbal <Zafar.Iqbal2@domain.hid>
Cc: "Xenomai-help@domain.hid" <Xenomai-help@domain.hid>

Zafar,

Rebuild the kernel after selecting support for pervasive:

Real-time subsystem --->
     [*]Pervasive real-time support in user space

Regards,

Ed



On Tue, 2010-09-14 at 16:45 +0530, Zafar Iqbal wrote:
> Dear Sir,
> 
> 
> I Installed the Xenomai Successfully in MY System with Ubuntu 10.04.
> Operationg System: Ubuntu 10.4
> Xenomai Version: 2.5.4.
> refrence for the installation: http://www.xenomai.org/index.php/Building_Debian_packages
> 
> 
> 
> later I compiled the example code provided in the xenomai folder and i got compiled sucessfully but while running the executable I am getting the following different error:
> 
> for POSIX Code:
> root@domain.hid# ./satch 
> Xenomai: POSIX skin or CONFIG_XENO_OPT_PERVASIVE disabled.
> (modprobe xeno_posix?)
> 
> for native code
> 
> root@domain.hid# ./rtprint 
> Xenomai: native skin or CONFIG_XENO_OPT_PERVASIVE disabled.
> (modprobe xeno_native?)
> root@domain.hid# 
> 
> 
> Please Suggest Me whats wrong here in the above code.
> 
> Thanks and Regards
> Zafar
> 
> 
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help



