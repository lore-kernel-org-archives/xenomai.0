Date: Wed, 4 Feb 2015 12:40:50 +0100 (CET)
From: Huy Cong Vu <huy-cong.vu@wandercraft.eu>
Message-ID: <735225138.4138.1423050050231.JavaMail.zimbra@wandercraft.eu>
In-Reply-To: <2118665101.4111.1423048074765.JavaMail.zimbra@wandercraft.eu>
References: <1928985868.3780.1423040133670.JavaMail.zimbra@wandercraft.eu>
 <54D1E2AA.40000@xenomai.org>
 <2118665101.4111.1423048074765.JavaMail.zimbra@wandercraft.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Xenomai 3 - no skin detected in program
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org



----- Mail original -----
> De: "Huy Cong Vu" <huy-cong.vu@wandercraft.eu>
> =C3=80: "Philippe Gerum" <rpm@xenomai.org>
> Cc: xenomai@xenomai.org
> Envoy=C3=A9: Mercredi 4 F=C3=A9vrier 2015 12:07:54
> Objet: Re: [Xenomai] Xenomai 3 - no skin detected in program

> ----- Mail original -----
>> De: "Philippe Gerum" <rpm@xenomai.org>
>> =C3=80: "Huy Cong Vu" <huy-cong.vu@wandercraft.eu>, xenomai@xenomai.org
>> Envoy=C3=A9: Mercredi 4 F=C3=A9vrier 2015 10:13:14
>> Objet: Re: [Xenomai] Xenomai 3 - no skin detected in program
>=20
>> On 02/04/2015 09:55 AM, Huy Cong Vu wrote:
>>> Hello everyone,
>>> I recently try to run an application compiled in native skin of Xenomai=
 3. When
>>> trying to run the binary, these line appeared:
>>> WARNING: [main] no skin detected in program
>>> BUG: [main] initialization failed, EINVAL
>>> I know that this is a cooperplate_init() warning when trying to initial=
ize
>>> native skin, but I don't understand the reason why:
>>> if (pvlist_empty(&skins)){
>>> warning("no skin detected in program");
>>> ret =3D -EINVAL;
>>> goto fail;
>>> }
>>=20
>> It seems that your application was not linked against libalchemy.so.
>> When API libraries are properly linked in, internal constructor routines
>> populate this list. POSIX support is built-in within the Cobalt
>> interface, so it won't appear here though.
>>=20
I change the order of the linker flags, now my app is linked against libalc=
hemy.so, but this message shown up:
symbol lookup error: /usr/xenomai/lib/libcopperplate.so.0: undefined symbol=
: main

I guess that it stills a problem due to the linker flag, am I right?=20

>> You may want to check this with ldd.
>>=20
>=20
> Indeed, I'm working on the linking option to find out why, it seems that
> -ffunctions-sections and -Wl,--gc-sections hides the -lalchemy flag so I
> removed it.
>=20
>>> In my main(), there are still native API calls:
>>> rt_print_auto_init(1);
>>> rt_task_spawn(...);
>>> rt_task_join(...);
>>> rt_task_delete(...);
>>> with mlockall also just to make sure, even I know that is pre-initializ=
e since
>>> Xenomai 2.6.
>>> I have xenomai-3-next patched on linux-3.14.17, here are my compilation=
 flags:
>>> cflags:
>>> xeno-config --alchemy --cflags
>>> xeno-config --rtdm --cflags
>>> ldflags:
>>> xeno-config --alchemy --ldflags
>>> xeno-config --rtdm --ldflags
>>=20
>> You should not mention --rtdm for userland apps, this is useless for
>> Xenomai 3. This has been kept for compatibility purpose with existing
>> application Makefiles targeting Xenomai 2.x.
>>
>=20
> But what if one of my static library calls from rtdm? Which flags should =
I add
> then if I can't use xeno-config --rtdm anymore?
>=20
>>>=20
>>> This issue is not reproduced with posix skin, I know that there are a m=
echanism
>>> change in the way Xenomai invoke function calls other than POSIX (alche=
my,
>>> vxworks...):
>>> https://xenomai.org//migrating-from-xenomai-2-x-to-3-x/#Copperplate_aut=
o-initialization
>>> Is this related with my issue? Is there anything I should add to my
>>> initialization process that I didn't know about?
>>> Thanks for your time,
>>>=20
>>=20
>> Check lib/alchemy/testsuite for a working Makefile you could derive
>> yours from.
>>=20
>> --
>> Philippe.
>=20
> --
> Huy Cong
> Wandercraft SAS
>=20
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> http://www.xenomai.org/mailman/listinfo/xenomai

--=20
Huy Cong
Wandercraft SAS

