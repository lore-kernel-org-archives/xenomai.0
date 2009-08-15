From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4A6C6101.5050707@domain.hid>
References: <4A6C6101.5050707@domain.hid>
Content-Type: text/plain
Date: Sat, 15 Aug 2009 23:48:41 +0200
Message-Id: <1250372921.2933.92.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] socket can compile broken
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Matteo Facchinetti <matteo.facchinetti@domain.hid>
Cc: xenomai@xenomai.org

On Sun, 2009-07-26 at 15:58 +0200, Matteo Facchinetti wrote:
> Hi,
> 
> I've upgrade xenomai to the last 2.4.8 (git) version.
> I'm using kernel 2.6.24powerpc and for compile socket-can module, need 
> to change MPC5xxx_GPIO define.
> In this kernel version I havn't mpc5xxx_gpio_find_and_map() function but 
> only mpc52xx_find_and_map("mpc5200-gpio").
> 

Merged, thanks.

-- 
Philippe.



