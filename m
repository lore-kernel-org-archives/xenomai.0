Message-ID: <4CB6A592.7080205@domain.hid>
Date: Thu, 14 Oct 2010 08:39:14 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTik6p=tM+JWHhsp8McPo+ZydtTZZk6ay-Ot_pgRk@domain.hid>	<4CB552F2.90500@domain.hid>
	<AANLkTinKiBchwG6F0GkG-VucM=QikUO8LefNeDOw_jCb@domain.hid>
In-Reply-To: <AANLkTinKiBchwG6F0GkG-VucM=QikUO8LefNeDOw_jCb@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] HELP: Real-time Drivers
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Peter Warner <xenomai.start@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

Peter Warner wrote:
> Hi Gilles,
> 
> Thanks for your mail,
> 
> I will just give the detail of my system:
> Processor Core 2 Duo.
> Operating System: Ubuntu 10.04
> Kernel version: 2.6.32.20
> xenomai Version: 2.5.5.1
> 
> Now I will Explain What I Did.
> 
> In  the Kernel Configuration(make menuconfig)
> 
>  Real-time sub-system  --->
>     DRIVERS ---->
>          SERIAL DRIVERS ------>
>          <M> 16550A UART driver
>           HARDWARE ACCESS MODE(PORT-based I/O) ------->
> 
> I build the kernel and installed the xenomai patched kernel.
> the Include path is /usr/include/xenomai/

You should have installed the kernel modules too...

> Later I entered into the directory xenomai-2.5.5.1/examples.
> Invoked the command make.
> next to folder native and invoked the generated executables they all are
> working fine
> 
> next i entered to folder
> 
> /usr/src/xenomai-2.5.5.1/examples/rtdm/profiles/serial     and invoked
> make. finally  the executable *cross-link* was generated.
> 
> When I invoke the *cross-link* it ihas given the following error message:
>                      *main : can't open rtser0 (write), No such device*
> 
> I guess the corresponding device driver I need to install. How can I do
> the same.

If the device driver is compiled as a module, you need to load the
module, yes.

> on the Other hand i have done one more Operation
> 
> I used /usr/src/xenomai-2.5.5.1/ksrc/drivers/serial  and Tried to invoke
> the make but it has  given the following error message;
> Makefile:25: /Rules.make: No such file or directory
> make: *** No rule to make target `/Rules.make'.  Stop.
> 
> I just want to clarify from you that is it a driver module. How can I
> fix this bug.

No bug here. At least not in Xenomai code. The question you ask is about
Linux kernel modules. I am sorry, but you are on the Xenomai mailing
list here, we will help you solve issues with Xenomai, but we do not
have the bandwidth to teach you how to compile and use Linux and Linux
kernel modules. There are a lot of ressources on the web which will
teach you that anyway.

-- 
                                                                Gilles.

