Message-ID: <431A9714.6030809@domain.hid>
Date: Sun, 04 Sep 2005 09:41:24 +0300
From: Heikki Lindholm <holindho@domain.hid>
MIME-Version: 1.0
Subject: Re: [Adeos-main] adeos i386 and ppc patches forward ported to	2.6.13
References: <1125495609.4643.16.camel@domain.hid>	<20050831193733.w5f2d662w0gswwkg@domain.hid>	<20050831211425.GA32230@domain.hid>	<20050901104750.c0mpu3q4pkc088wg@domain.hid>	<1125577206.4641.8.camel@domain.hid>	<1125579791.4685.2.camel@domain.hid>	<4316FD8F.30203@domain.hid>	<1125581425.4639.3.camel@domain.hid>	<20050901155220.ifckrl94w00gksg8@domain.hid>	<1125583963.4635.0.camel@domain.hid>
	<20050901164619.pn5h4cg34s0w4gok@domain.hid>
In-Reply-To: <20050901164619.pn5h4cg34s0w4gok@domain.hid>
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
To: Philippe Gerum <philippe.gerum@domain.hid>
Cc: Stelian Pop <stelian@domain.hid>, adeos-main@gna.org

Philippe Gerum kirjoitti:
> Quoting Stelian Pop <stelian@domain.hid>:
> 
>> Le jeudi 01 septembre 2005 à 15:52 +0200, Philippe Gerum a écrit :
>>
>>> >> Are you sure this is not the same I was experiencing, eg. missed
>>> >> decrementer interrupt that stalls the machine (looks like hard 
>>> lock-up)
>>> >> for two minutes.
>>> >
>>> > I tried waiting (at least 5 minutes) and nothing happened.
>>> >
>>>
>>> Here is a revisited version of Heikki's patch applicable against an
>>> Adeos-patched kernel, and which is expected to solve the lagging
>>> interrupt sync
>>> issue; tested on a mpc8541 board. I'd be interested to know if this
>>> still fixes
>>> the issue discovered on ppc64, and maybe on the G4.
>>
>>
>> Does not change a thing on the G4.
>>
> 
> Of, so if Heikki confirms that this patch works on ppc64, I guess that 
> we have a
> brand new shiny bug to chase, with lots of headbanging sessions ahead. 
> And I'm
> not talking about dance style here...

I've now tried both 32- and 64-bit kernels on the G5 with and without 
the patch and the results seem consistent with the G4. Without the 
patch, stalls happen always with nucleus loaded, but I didn't observe 
any with the patch. However, I'm still not happy with how the patch 
handles the !threaded case: If everyone had handlers like
my_handler(...);
{
    traps++;
    return PROPAGATE;
}
the patch wouldn't help at all. I'd prefer something more along the 
lines of my original posting.

-- Heikki Lindholm

