Subject: Re: [Adeos-main] adeos i386 and ppc patches forward ported to 2.6.13
From: Stelian Pop <stelian@domain.hid>
In-Reply-To: <1125577206.4641.8.camel@domain.hid>
References: <1125495609.4643.16.camel@domain.hid>
	<20050831193733.w5f2d662w0gswwkg@domain.hid>
	<20050831211425.GA32230@domain.hid>
	<20050901104750.c0mpu3q4pkc088wg@domain.hid>
	<1125577206.4641.8.camel@domain.hid>
Content-Type: text/plain; charset=utf-8
Date: Thu, 01 Sep 2005 15:03:11 +0200
Message-Id: <1125579791.4685.2.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: adeos-main@gna.org

Le jeudi 01 septembre 2005 =C3=A0 14:20 +0200, Stelian Pop a =C3=A9crit :

> I'll try testing the 2.6.10 patch, maybe this will tell if the problem
> is in the adeos core or in the newer kernel changes...

Okay, it also hangs with the 2.6.10 patch (even with the fix for
activate_mm()). It took two invocations of 'rtai-test' but it ended up
hanging just like before.

Stelian.
--=20
Stelian Pop <stelian@domain.hid>


