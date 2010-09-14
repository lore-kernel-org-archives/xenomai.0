MIME-Version: 1.0
Sender: patrickdepinguin@domain.hid
In-Reply-To: <76E258664B189C4CBEF125491CA11ECC945B6553D4@domain.hid>
References: <76E258664B189C4CBEF125491CA11ECC945B6553D4@domain.hid>
Date: Tue, 14 Sep 2010 13:32:26 +0200
Message-ID: <AANLkTinotGb-qKX6wY6j-tYkW-NxpJspJVBjOrKGDtMk@domain.hid>
From: Thomas De Schampheleire <patrickdepinguin+xenomai@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
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

Hi,

On Tue, Sep 14, 2010 at 1:15 PM, Zafar Iqbal
<Zafar.Iqbal2@domain.hid> wrote:
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

The POSIX nor native skin are currently loaded in your kernel. This
can mean that:
* you did not patch the Linux kernel correctly
* you did patch the kernel correctly, but did not enable the posix and
native skin
* you did patch the kernel correctly, compiled the respective skins as
modules, but did not load the module. In this case, as the output
suggests, you should load the kernel modules using modprobe or insmod.

Best regards,
Thomas

