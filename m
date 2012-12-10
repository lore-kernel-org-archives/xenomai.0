Message-ID: <50C65D84.8000002@xenomai.org>
Date: Mon, 10 Dec 2012 23:09:08 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CANzNmi-O4C=z-sXqrq7HMTQ=B2apBBnZMco0p-_iHmfuu+Jexg@mail.gmail.com>	<50AA4EC2.1000206@xenomai.org>
	<CANzNmi-dFbx043zCszBwYu2yZh3awGkRAArwOnaTq3k=ijffdA@mail.gmail.com>
	<50AA5B96.9060009@xenomai.org> <50AB9449.2020203@gmail.com>
	<50AB96A0.3060204@xenomai.org> <50AB9991.9090901@gmail.com>
	<50AB9D18.9070902@xenomai.org> <50ABA4F8.2020807@gmail.com>
	<50C65A0C.1010309@gmail.com>
In-Reply-To: <50C65A0C.1010309@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Help with Xeno-test please
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Sebastian Pavez <sebastian.pavez.t@gmail.com>
Cc: Xenomai <xenomai@xenomai.org>

On 12/10/2012 10:54 PM, Sebastian Pavez wrote:

> El 20/11/2012 12:42 p.m., Sebastian Pavez escribi=C3=B3:
>> El 20/11/2012 12:09 p.m., Gilles Chanteperdrix escribi=C3=B3:
>>> On 11/20/2012 03:54 PM, Sebastian Pavez wrote:
>>>> El 20/11/2012 11:41 a.m., Gilles Chanteperdrix escribi=C3=B3:
>>>>> On 11/20/2012 03:31 PM, Sebastian Pavez wrote:
>>>>>> ioctl(RTTST_RTIOC_SWTEST_CREATE_KTASK): Cannot allocate memory
>>>>> You still do not have enough memory.
>>>>>
>>>> Ok,
>>>> I have 256 kb for CONFIG_XENO_OPT_SYS_HEAPSZ and 128 kb for
>>>> CONFIG_XENO_OPT_SYS_STACKPOOLSZ.
>>>> There's a recommended value to these? or I should try a value and lo=
ok
>>>> how they works?
>>>> In any case, I'll try to put 512kb for both ...
>>> The default values are for 1 core. If you have 6 cores, multiply by 6=
=2E
>>>
>>>
>> Ok, thank you for your answer ...
>> I know this question is not precisely a xenomai one, but when I try to=
=20
>> compile the new configuration, I get this:
>> labcontrol@labcontrol:/usr/src/linux-3.2.32$ make
>> scripts/kconfig/conf --silentoldconfig Kconfig
>>
>> *** Error during update of the configuration.
>>
>> make[2]: *** [silentoldconfig] Error 1
>> make[1]: *** [silentoldconfig] Error 2
>> make[1]: Nothing to be done for `relocs'.
>> make: *** No rule to make target `include/config/auto.conf', needed by=
=20
>> `include/config/kernel.release'.  Stop.
>>
>> Why is that??
> Hi Gilles,
>=20
> I finally reconfigured my kernel with 2048 kb for=20
> CONFIG_XENO_OPT_SYS_HEAPSZ and 1024 kb for CONFIG_XENO_OPT_SYS_STACKPOO=
LSZ.
> And the command  xeno-test -l "dohell -b=20
> /home/labcontrol/Downloads/ltp-full-20120903/testcases/kernel/sched/cfs=
-scheduler/hackbench=20
> 10800" works.
>=20
> I want to analyze the results, but I'm not able to find the log of the =

> test. I read that it should be in the /tmp folder, but I didn't find=20
> anything.
> I know this question is quite trivial compared to the others subjects o=
f=20
> the mail-list you're answering right now, but where I could find those =

> resulst? I have to choose a path?
>=20
> Thanks for your time,
> Seba.


The logs are not saved to a file and are printed directly on xeno-test
standard output. You should be able to redirect them or pipe them into
tee if you want to save them to a file.

And as usual, for meaningful results, you should use dohell -s and -m
arguments.

--=20
                                                                Gilles.


