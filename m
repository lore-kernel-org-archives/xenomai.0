Message-ID: <49097EFE.4000606@domain.hid>
Date: Thu, 30 Oct 2008 10:31:42 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <f8b4363d0810300151p7782d43au76e009d9ce9f9303@domain.hid>
In-Reply-To: <f8b4363d0810300151p7782d43au76e009d9ce9f9303@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] [Total Newbie] Module xeno_native not found
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Antino Kim <antinokim@domain.hid>
Cc: xenomai@xenomai.org

Antino Kim wrote:
> Hello,
> 
> I'm a total newbie in using Linux kernel and Xenomai.
> Around 4am, I was able to successfully compile a Xenomai patched
> vanilla Linux kernel and install Xenomai! I thought all the trouble
> was over...
> When I tried running a example program, I got the following error message:
> 
> 
> /usr/src/xenomai-2.4.5/examples/native$ ./trivial-periodic
> Xenomai: native skin or CONFIG_XENO_OPT_PERVASIVE disabled.
> (modprobe xeno_native?)
> 
> /usr/src/xenomai-2.4.5/examples/native$ modprobe xeno_native
> FATAL: Module xeno_native not found.

By default, the native skin is built into the kernel, thus there is no
module.

> 
> 
> I will be willing to provide more information if needed, but my gut
> feeling tells me it should be a very simple (and obvious) problem to
> experienced users. I would really appreciate any help. Thanks.

You may face some issue that Xenomai is unable to work due to kernel
configuration conflicts. Please check the kernel console for messages
regarding Xenomai (dmesg or syslog). If you do not find the reason on
your own, we will need your .config for further help.

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

