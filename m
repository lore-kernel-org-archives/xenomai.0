Message-ID: <4B3CC62D.6070709@domain.hid>
Date: Thu, 31 Dec 2009 16:41:33 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <725957.56219.qm@domain.hid>	<4AF04886.9040903@domain.hid>	<1f3e02580911030745o128df8aeve4bdd44bad9c3db7@domain.hid>	<4AF15D68.7060001@domain.hid>	<873433.54790.qm@domain.hid>	<1f3e02580911060139q60bc91f8k4e71d933a50895ba@domain.hid>	<20091215213210.19d5b6a5@domain.hid>	<1f3e02580912151715n1f587e87x48834799baf7eea7@domain.hid>
	<4303dd240912310452m6db83032rb42d13777efbf5a3@domain.hid>
In-Reply-To: <4303dd240912310452m6db83032rb42d13777efbf5a3@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Porting I-Pipe for new ARM board
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Flavio de Castro Alves Filho <flavio.alves@domain.hid>
Cc: xenomai@xenomai.org

Flavio de Castro Alves Filho wrote:
> Hello,
>  
> I am currently working on the port of Xenomai for the TI OMAP L-138
> processor (DaVinci platform). I didn't finish yet. As soon as I finish,
> I will send the patch, and I intend to do so next week.
>  
> I followed the instructions from Xenomai's wiki page. Until now, I am
> able to boot my ported kernel with the I-Pipe feature. When I build the
> kernel with Xenomai feature, the kernel stops to boot.
>  
> I have some questions:
>  
> 1) How is the better way to debug the boot process? When my kernel stops
> booting, after the message "Uncompressing .........." the boot halts. I
> don't know what is going on and I don't know what to do in order to
> follow the processes internally. Both debuggers (kernel and i-ipipe) are
> enabled in the kernel configuration.

This is tips and tricks number 1:
http://www.xenomai.org/index.php/I-pipe:ArmPorting#Tips_and_tricks.

>  
> 2) How tested the code must be done in order to send you a patch? Is
> there any minimal set of tests that I should perform just before sending
> you a patch for revision?

The validation tool I use is LTP. You can check that LTP returns the
same results with a vanilla kernel, and with the Xenomai patched kernel
when running LTP while a latency test is running. Unfortunately, to run
ltp on low-end arms, I had to make a few local changes. Which means I am
using an out-dated, patched version of LTP:
http://sisyphus.hd.free.fr/~gilles/ltp-20081130-patched.tar.bz2

-- 
					    Gilles.

