Message-ID: <431946EC.4090804@domain.hid>
Date: Sat, 03 Sep 2005 09:47:08 +0300
From: Heikki Lindholm <holindho@domain.hid>
MIME-Version: 1.0
Subject: Re: [Adeos-main] adeos i386 and ppc patches forward ported to	2.6.13
References: <1125495609.4643.16.camel@domain.hid>	
	<20050831193733.w5f2d662w0gswwkg@domain.hid>	
	<20050831211425.GA32230@domain.hid>	
	<20050901104750.c0mpu3q4pkc088wg@domain.hid>	
	<1125577206.4641.8.camel@domain.hid>	
	<1125579791.4685.2.camel@domain.hid>	
	<4316FD8F.30203@domain.hid>	
	<1125581425.4639.3.camel@domain.hid>	
	<20050901155220.ifckrl94w00gksg8@domain.hid>	
	<1125583963.4635.0.camel@domain.hid>	
	<20050901164619.pn5h4cg34s0w4gok@domain.hid>
	<1125586184.4633.3.camel@domain.hid>
In-Reply-To: <1125586184.4633.3.camel@domain.hid>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Stelian Pop <stelian@domain.hid>
Cc: adeos-main@gna.org, Philippe Gerum <philippe.gerum@domain.hid>

Stelian Pop kirjoitti:
> Le jeudi 01 septembre 2005 à 16:46 +0200, Philippe Gerum a écrit :
> 
> 
>>Of, so if Heikki confirms that this patch works on ppc64, I guess that 
>>we have a
>>brand new shiny bug to chase, with lots of headbanging sessions ahead. And I'm
>>not talking about dance style here...
> 
> 
> :)
> 
> 
>>Ok, question #1: does this lockup only happen with latency, or is it also
>>experienced with klatency?
> 
> 
> I think I saw it only with latency.

Did this happen mid-way while executing or only at the end, eg. modules 
unload phase? On the ppc64 port, I got an easily reproducible access 
exception after unloading rtai_native while unloading rtai_nucleus.

-- Heikki Lindholm

