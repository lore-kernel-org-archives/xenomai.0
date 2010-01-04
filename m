Message-ID: <4B426A3D.5020706@domain.hid>
Date: Mon, 04 Jan 2010 23:22:53 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <725957.56219.qm@domain.hid>	<4AF04886.9040903@domain.hid>	<1f3e02580911030745o128df8aeve4bdd44bad9c3db7@domain.hid>	<4AF15D68.7060001@domain.hid>	<873433.54790.qm@domain.hid>	<1f3e02580911060139q60bc91f8k4e71d933a50895ba@domain.hid>	<20091215213210.19d5b6a5@domain.hid>	<1f3e02580912151715n1f587e87x48834799baf7eea7@domain.hid>	<4303dd240912310452m6db83032rb42d13777efbf5a3@domain.hid>	<4B3CC62D.6070709@domain.hid>
	<1262643246.20365.10.camel@domain.hid>
In-Reply-To: <1262643246.20365.10.camel@domain.hid>
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
To: flavio.alves@domain.hid
Cc: xenomai@xenomai.org

Flavio Alves wrote:
> <1>Unable to handle kernel NULL pointer dereference at virtual address 00000000 
> Looking at the code (and perform some analysis) I saw that the call that
> is crashing the kernel is:
> 
>  __asm__("ldmia %1, %M0\n":
> 	    "=r"(result.full): "r"(local_tsc), "m"(*local_tsc));
> 
> And looking into the implementation of this function for other
> platforms, I can see that it is the same instruction, without
> difference.

On all other platforms the "local_tsc" pointer is not NULL...

-- 
					    Gilles.

