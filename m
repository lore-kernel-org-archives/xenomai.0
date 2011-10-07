Message-ID: <4E8F2CFA.1070306@domain.hid>
Date: Fri, 07 Oct 2011 18:46:50 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CACFV95JranppM+ZDoqsgjO5nJ-Th2fFAD0HowBSkL-t_wQ-t4w@domain.hid>
	<4E8F1643.1050700@domain.hid>
	<CACFV95LnySGuKP2NQ+BcYk-wuk+S9Gh2iu1Xmqh9VLNsH1Az0w@domain.hid>
In-Reply-To: <CACFV95LnySGuKP2NQ+BcYk-wuk+S9Gh2iu1Xmqh9VLNsH1Az0w@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai: /dev/rtheap is missing (chardev,
 major=10 minor=254) in mini2440
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Siva kumar Balasubramanian <sivakumar.bs@domain.hid>
Cc: xenomai@xenomai.org

On 10/07/2011 05:55 PM, Siva kumar Balasubramanian wrote:
> Mini2440 is based on s3c2440,
> 
> I did the following steps to patch xenomai for Mini2440
> 
> I patched the adeos-ipipe-2.6.37.6-arm-1.18-03.patch to linux
> kernel-2.6.37.6
> 
> I used mini2440_defconfig as configuration file, i did  not made any changes
> 
> After sucessful compilation, i booted the mini2440 compiled kernel
> 
> I crosscompiled xenomai-2.5.6 using the following command
> 
> ./configure --build=x86_64-pc-linux-gnu --host=arm-linux
> --enable-arm-mach=s3c2410 --enable-arm-tsc

So, no porting involved finally.

You are probably missing --enable-arm-eabi. Note that if you start with
xenomai 2.6.0, the configuration is much easier (basically, you just run
configure with no arguments and it works).

And xenomai 2.6.0's xeno-test should work better.

-- 
					    Gilles.

