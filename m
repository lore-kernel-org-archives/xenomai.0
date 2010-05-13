From: Jonata Apolinario <jonataapolinario@domain.hid>
Date: Thu, 13 May 2010 22:05:05 +0000 (UTC)
Message-ID: <loom.20100514T000318-597@domain.hid>
References: <SNT125-W47B0622A941FB9CEDA2C479C350@domain.hid>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai-help] a problem about Calibrating delay loop...
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

费朱青 <mouse19875 <at> hotmail.com> writes:

> 
> 
> HI all,
>      I am porting xenomai-2.5.1 to arm architecture(Samsung
S3C2440).Everything is ok when I do patch and compile.But the board start
up,console lock and say"calbrating delay loop...".(before patch xenomai into
kernel,the kernel image can work well)
>      Xenomai say that it supports "S3C24xx family" ,but I always meet this
problem.
>      Someone said the timer interrupt does not work,I don't know how to watch
it and work out this problem.
>      Do you know some methods that can  solve it ? 
> thanks
> justin fei更多热辣资讯尽在新版MSN首页！ 立刻访问！
> 
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help <at> gna.org
> https://mail.gna.org/listinfo/xenomai-help
> 


Hi!
well, i think i solved.
i found in arch/arm/plat-s3c/time.c:
the path inserted these lines:

tcfg1 = __raw_readl(S3C2410_TCFG1);
tcfg1 &= ~(S3C2410_TCFG1_MUX4_MASK | S3C2410_TCFG1_MUX3_MASK);
tcfg1 |= (S3C2410_TCFG1_MUX4_TCLK1 | S3C2410_TCFG1_MUX3_TCLK1);
__raw_writel(tcfg1, S3C2410_TCFG1);

in the function "static void s3c2410_timer_setup (void)"
in the "else" side of the "if (use_tclk1_12())"
use_tclk1_12 as i can see is to use external clock on pin clk1.
the patch put these lines in the else too, that as i can see, is wrong.
i removed these lines from the ELSE side and the kernel passed by this point.

see if it solves your problem and post your results.
 Thanks!


