From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <12fbb161f5b.sdiani@domain.hid>
References: <12fbb161f5b.sdiani@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 04 May 2011 16:44:15 +0200
Message-ID: <1304520255.2140.3.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Adeos-main] Adeos for PowerPc 2.6.29.4-64 bit
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/options/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: "sdiani@domain.hid" <sdiani@domain.hid>
Cc: adeos-main@gna.org

On Wed, 2011-05-04 at 14:57 +0200, sdiani@domain.hid wrote:
> 
> Hi everyone,
> i'm trying to compile the 2.6.29.4 64-bit Denx kernel for PowerPC
> ( PPC 970 , G5 Desktop ).
> I have applied the
> patch  adeos-ipipe-2.6.29.4-powerpc-DENX-2.7-04.patch  and after
> reboot i get this error:
> 
>                         NIP [000001C968] .power4_idle+0x54/0x58 
>                         LR = (null)
>                             ....
>                         Exceptionn: 901 at power4_idle+0x54/0x58
>                                     LR = .cpu_idle +0x11c/0x1d4
> 
> It regards the idle_power4.S file and the only changes in it, are
> about the CONFIG_SOFTDISABLE.
> Can Anyone help me to solve it ?

The power save code for powermac won't work as is with Adeos. Try
booting with powersave=off.

> 
> Thank you in advance
> 
> Sergio
> _______________________________________________
> Adeos-main mailing list
> Adeos-main@domain.hid
> https://mail.gna.org/listinfo/adeos-main

-- 
Philippe.



