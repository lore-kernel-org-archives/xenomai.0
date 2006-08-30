From: Philippe Gerum <rpm@xenomai.org>
Content-Type: text/plain
Date: Wed, 30 Aug 2006 14:36:29 +0200
Message-Id: <1156941389.4323.17.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] [Fwd: Performance decrease]
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
To: xenomai@xenomai.org

-------- Forwarded Message --------
> From: Daniel Schnell <danielsch@domain.hid>
> To: xenomai-help <xenomai@xenomai.org>
> Subject: Performance decrease
> Date: Wed, 30 Aug 2006 11:58:25 -0000
> 
> Hi,
> 
>  
> 
> I have made some CPU throughput tests with/without "Nucleus options->pervasive real-time support in user-space"  enabled/disabled. And the performance dicrease in using that option is for my processor (MPC5200, 400 MHz) about 10%. On the other side I cannot compile RTDM support in without it; the error message when linking vmlinux at the end of the Kernel compile stage is:
> 
>  
> 
> drvlib.c:(.text+0x19f8): undefined reference to `__va_to_kva'
> 
>  
> 
> 
> 
> For what is the real-time support in user space option good for ?
> 
> If it is necessary for RTDM support, shouldn't it be automatically switched on when choosing the RTDM option ?
> 
>  
> 
> 
> 
> 
> 
> I am using ELDK-4.0 + latest 2.4.25-developer kernel from Denx + latest subversion xenomai + adeos patch 1.1-04
> 
>  
> 
> Thanks in advance,
> 
>  
> 
> 
> 
> Ciao,
> 
>  
> 
> Daniel.
> 
-- 
Philippe.



