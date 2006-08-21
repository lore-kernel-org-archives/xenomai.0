Subject: Re: [Xenomai-help] problem with testsuite/latency
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <200608212144.51485.nicola17@domain.hid>
References: <200608212144.51485.nicola17@domain.hid>
Content-Type: text/plain
Date: Mon, 21 Aug 2006 22:10:22 +0200
Message-Id: <1156191023.4321.43.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Nicola Pezzotti <nicola17@domain.hid>
Cc: xenomai@xenomai.org

On Mon, 2006-08-21 at 21:44 +0200, Nicola Pezzotti wrote:
> Hi.
> 
> 	I also have some problem with Xenomai.
> 
> I solve the kernel's compilation problem and I compile Xenomai
> 
> (Kernel 2.6.16 Xenomai 2.2.0)
> 
> Now I trying to launch the testsuite's latency program but I have this 
> problem:
> 
> 
> Xenomai: incompatible feature set
> (required="sep tsc", present="sep", missing="tsc").
> 
> 
> Someone can give my an hint?
> 

Your kernel config says that your x86 CPU does not provide any
time-stamp counter, but the user-space programs ask for it. If the
kernel config is right (i.e. the CPU selection is correct), then you
need to switch off the TSC requirement [which defaults to on] when
configuring the user-space Xenomai support: e.g.

.../configure --disable-x86-tsc

$ make clean install 

README.INSTALL has more on feature selection, and explains why we must
enforce it.

> thanks
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
-- 
Philippe.



