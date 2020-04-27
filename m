Subject: Re: Problem with gdb
References: <e393e320-54ea-7a16-d645-3441c80cdc0c@mitrol.it>
 <23d1e027-2e62-8d52-de94-0e9d53b6aa5c@siemens.com>
 <7509227c-b773-8484-1a2d-52c716e67072@mitrol.it>
 <73619ace-a142-ae30-cb1e-a80ab7338a48@siemens.com>
From: Paolo Minazzi <Paolo.Minazzi@mitrol.it>
Message-ID: <55dd13ab-b909-c373-52ad-56949c9f4103@mitrol.it>
Date: Mon, 27 Apr 2020 11:30:25 +0200
MIME-Version: 1.0
In-Reply-To: <73619ace-a142-ae30-cb1e-a80ab7338a48@siemens.com>
Content-Type: text/plain; charset="iso-8859-15"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@xenomai.org

Il 27/04/2020 07:39, Jan Kiszka ha scritto:
> On 26.04.20 14:50, Paolo Minazzi wrote:
>> Il 26/04/2020 10:33, Jan Kiszka ha scritto:
>>> Can you cross-check with ipipe-core-4.19.114-cip24-arm-08? 4.9 is=20
>>> unmaintained regarding I-pipe.
>> Hi Jan,
>> I could try 4.19. But then I would have a complex task to to the=20
>> porting all of my system to linux-4.19.
>
> If you aren't being a lab device, this would be better anyway in order=20
> to receive bug fixes for a longer time. As I said: 4.9 is dead,=20
> already lagging behind. 4.4-cip is still maintained but a bad start=20
> for a new project.
Hi Jan,

Ok, I'm trying to port my system to 4.19.

I confirm that gdb with

- xenomai-3.0.9
- ipipe4-9

works correctly.

Kind regards,
Paolo
>
>>
>> I have tried now downgrading xenomai to 3.0.9 with the same=20
>> ipipe-4.9.38.
>> I have seen something changed in xenomai 3.1 about debugging.
>
> Yes, we need=20
> https://gitlab.denx.de/Xenomai/ipipe-arm/-/commit/5f032ff0126222ee944e4e4=
4ea0c2b49a9c66d02=20
> and more.
>
> Jan
>
>> With xenomai-3.0.9 gdb seems working OK.
>> Tomorrow I will test better and I will post results.
>>
>>> How did you build Xenomai (configure options)? How are you building=20
>>> your demo?
>>>
>> Xenomai build
>>
>> ./scripts/bootstrap --with-core=3Dcobalt
>> configure --build=3Di686-pc-linux-gnu \
>> --host=3Darm-linux-gnueabihf \
>> --with-core=3Dcobalt \
>> --prefix=3D$HERE/../$XENOMAI-install \
>> CC=3Darm-linux-gnueabihf-gcc LD=3Darm-linux-gnueabihf-ld
>> make
>>
>> Application build
>>
>> CROSS=3Darm-linux-gnueabihf-
>>
>> INCLUDES=3D$(shell sh ../../xenomai-3.1-install/bin/xeno-config=20
>> --skin=3Dalchemy --cflags)
>> LIBS=3D$(shell sh ../../xenomai-3.1-install/bin/xeno-config=20
>> --skin=3Dalchemy --ldflags)
>>
>> All:
>> =A0=A0=A0=A0=A0=A0=A0=A0 $(CROSS)gcc $(INCLUDES) $(LIBS) -o demo demo.c =
-g
>>
>>
>> Kind regards,
>> Paolo
>>
>


