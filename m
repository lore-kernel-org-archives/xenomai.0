Message-ID: <20050901164619.pn5h4cg34s0w4gok@domain.hid>
Date: Thu, 01 Sep 2005 16:46:19 +0200
From: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Adeos-main] adeos i386 and ppc patches forward ported to 2.6.13
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
In-Reply-To: <1125583963.4635.0.camel@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
	charset=UTF-8;
	format="flowed"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Stelian Pop <stelian@domain.hid>
Cc: adeos-main@gna.org, Heikki Lindholm <holindho@domain.hid>

Quoting Stelian Pop <stelian@domain.hid>:

> Le jeudi 01 septembre 2005 =C3=A0 15:52 +0200, Philippe Gerum a =C3=A9cri=
t :
>
>> >> Are you sure this is not the same I was experiencing, eg. missed
>> >> decrementer interrupt that stalls the machine (looks like hard lock-u=
p)
>> >> for two minutes.
>> >
>> > I tried waiting (at least 5 minutes) and nothing happened.
>> >
>>
>> Here is a revisited version of Heikki's patch applicable against an
>> Adeos-patched kernel, and which is expected to solve the lagging
>> interrupt sync
>> issue; tested on a mpc8541 board. I'd be interested to know if this
>> still fixes
>> the issue discovered on ppc64, and maybe on the G4.
>
> Does not change a thing on the G4.
>

Of, so if Heikki confirms that this patch works on ppc64, I guess that 
we have a
brand new shiny bug to chase, with lots of headbanging sessions ahead. And =
I'm
not talking about dance style here...

Ok, question #1: does this lockup only happen with latency, or is it also
experienced with klatency?

> Stelian.
> --
> Stelian Pop <stelian@domain.hid>
>
>




