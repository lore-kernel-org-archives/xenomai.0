Message-ID: <4F046865.9000408@domain.hid>
Date: Wed, 04 Jan 2012 15:55:33 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <000301cccaed$80667540$81335fc0$@soterem.fr>
In-Reply-To: <000301cccaed$80667540$81335fc0$@soterem.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] unresolved symbol - check the xenomai
	installation
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gregory Gosse <gregory.gosse@domain.hid>
Cc: xenomai@xenomai.org

On 01/04/2012 03:31 PM, Gregory Gosse wrote:
> Hello,
> 
>  
> 
> I have read here http://www.armadeus.com/wiki/index.php?title=Xenomai 
> 
> That the following commands can be used to check the xenomai installation :
> 
> $ dmesg | grep Xenomai
> 
> $ xeno-test
> 
>  
> 
> It gives the following results for me
> 
> 
> root@domain.hid:~# dmesg | grep Xenomai 
> 
> [    2.229354] I-pipe: Domain Xenomai registered. 
> 
> [    2.229358] Xenomai: hal/i386 started. 
> 
> [    2.229368] Xenomai: scheduling class idle registered. 
> 
> [    2.229370] Xenomai: scheduling class rt registered. 
> 
> [    2.229804] Xenomai: real-time nucleus v2.6.0 (Movin' On) loaded. 
> 
> [    2.229806] Xenomai: debug mode enabled. 
> 
> [    2.229877] Xenomai: starting native API services. 
> 
> [    2.229878] Xenomai: starting POSIX services. 
> 
> [    2.229899] Xenomai: starting RTDM services.

That is the output of xenomai 2.6.0.

> 
>  
> 
> 
> Xeno-test
> 
> .
> 
> .
> 
> Utilisation 2313:  W.... 
> 
>  2316:  W..X. 
> 
>  2317:  GS... 
> 
>  2338:  W...V 
> 
> [Domain info] 
> 
> id=0x58454e4f 
> 
> priority=topmost 

That is the output of xeno-test from the 2.5 branch, so, you probably
mixed two xenomai installations.

Also, as I already told you, a simple way to know if xenomai is
correctly installed is to run the latency test.

-- 
					    Gilles.

