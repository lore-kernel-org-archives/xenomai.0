Message-ID: <4316FD8F.30203@domain.hid>
Date: Thu, 01 Sep 2005 16:09:35 +0300
From: Heikki Lindholm <holindho@domain.hid>
MIME-Version: 1.0
Subject: Re: [Adeos-main] adeos i386 and ppc patches forward ported to 2.6.13
References: <1125495609.4643.16.camel@domain.hid>	<20050831193733.w5f2d662w0gswwkg@domain.hid>	<20050831211425.GA32230@domain.hid>	<20050901104750.c0mpu3q4pkc088wg@domain.hid>	<1125577206.4641.8.camel@domain.hid>
	<1125579791.4685.2.camel@domain.hid>
In-Reply-To: <1125579791.4685.2.camel@domain.hid>
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
Cc: adeos-main@gna.org, Philippe Gerum <rpm@xenomai.org>

Stelian Pop kirjoitti:
> Le jeudi 01 septembre 2005 à 14:20 +0200, Stelian Pop a écrit :
> 
> 
>>I'll try testing the 2.6.10 patch, maybe this will tell if the problem
>>is in the adeos core or in the newer kernel changes...
> 
> 
> Okay, it also hangs with the 2.6.10 patch (even with the fix for
> activate_mm()). It took two invocations of 'rtai-test' but it ended up
> hanging just like before.

Are you sure this is not the same I was experiencing, eg. missed 
decrementer interrupt that stalls the machine (looks like hard lock-up) 
for two minutes. It only happens on the more "advanced" PPCs, like 6xx 
and 7xxx.

-- Heikki Lindholm

