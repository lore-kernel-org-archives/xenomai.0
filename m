From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4B71666A.6040508@domain.hid>
References: <4B71666A.6040508@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 09 Feb 2010 14:47:41 +0100
Message-ID: <1265723261.2368.18.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai FAILED to register object
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Alexandre Coffignal <alexandre.coffignal@domain.hid>
Cc: xenomai@xenomai.org

On Tue, 2010-02-09 at 14:43 +0100, Alexandre Coffignal wrote:
> Hi all,
> 
> I use xenomai to port PSOS application, so I am using xenomai PSOS skin,
> but i want to use xenomai pthread.
> 
> My question is do you know if i can use psos skin and posix skin in the
> same time?
> 
> I already test it without success : when I load my prog, I have this
> message :
>     Xenomai pSOS skin init: t_shadow() failed, status -17
> 
> and this message in dmess
>     Xenomai: FAILED to register object MAIN (unknown type), status -17

Don't call both of them "MAIN".

> 
> Thank in advance
> 
> 


-- 
Philippe.



