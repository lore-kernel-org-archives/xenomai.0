Message-ID: <20050901155220.ifckrl94w00gksg8@domain.hid>
Date: Thu, 01 Sep 2005 15:52:20 +0200
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: [Adeos-main] adeos i386 and ppc patches forward ported to 2.6.13
References: <1125495609.4643.16.camel@domain.hid>
	<20050831193733.w5f2d662w0gswwkg@domain.hid>
	<20050831211425.GA32230@domain.hid>
	<20050901104750.c0mpu3q4pkc088wg@domain.hid>
	<1125577206.4641.8.camel@domain.hid>
	<1125579791.4685.2.camel@domain.hid>
	<4316FD8F.30203@domain.hid>
	<1125581425.4639.3.camel@domain.hid>
In-Reply-To: <1125581425.4639.3.camel@domain.hid>
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

> Le jeudi 01 septembre 2005 =C3=A0 16:09 +0300, Heikki Lindholm a =C3=A9cr=
it :
>> Stelian Pop kirjoitti:
>> > Le jeudi 01 septembre 2005 =C3=A0 14:20 +0200, Stelian Pop a =C3=A9cri=
t :
>> >
>> >
>> >>I'll try testing the 2.6.10 patch, maybe this will tell if the problem
>> >>is in the adeos core or in the newer kernel changes...
>> >
>> >
>> > Okay, it also hangs with the 2.6.10 patch (even with the fix for
>> > activate_mm()). It took two invocations of 'rtai-test' but it ended up
>> > hanging just like before.
>>
>> Are you sure this is not the same I was experiencing, eg. missed
>> decrementer interrupt that stalls the machine (looks like hard lock-up)
>> for two minutes.
>
> I tried waiting (at least 5 minutes) and nothing happened.
>

Here is a revisited version of Heikki's patch applicable against an
Adeos-patched kernel, and which is expected to solve the lagging 
interrupt sync
issue; tested on a mpc8541 board. I'd be interested to know if this 
still fixes
the issue discovered on ppc64, and maybe on the G4.

--- linuxppc-mpc52xx-adeos/kernel/adeos.c=092005-08-21 11:44:52.000000000 +=
0200
+++ linux-2.6.10-ppc-adeos/kernel/adeos.c=092005-09-01 00:19:58.000000000 +=
0200
@@ -173,6 +173,13 @@
=09=09break;
=09=09}
=09    }
+=09else if (next_domain !=3D this_domain &&
+=09=09 next_domain->cpudata[cpuid].irq_pending_hi !=3D 0 &&
+=09=09 !test_bit(IPIPE_STALL_FLAG,&next_domain->cpudata[cpuid].status))
+=09    {
+=09    __adeos_switch_to(this_domain,next_domain,cpuid);
+=09    adeos_load_cpuid(); /* Processor might have changed. */
+=09    }

=09if (next_domain =3D=3D this_domain)
=09    break;
@@ -223,6 +230,13 @@

=09    propagate =3D evinfo.propagate;
=09    }
+=09else if (next_domain !=3D this_domain &&
+=09=09 next_domain->cpudata[cpuid].irq_pending_hi !=3D 0 &&
+=09=09 !test_bit(IPIPE_STALL_FLAG,&next_domain->cpudata[cpuid].status))
+=09    {
+=09    __adeos_switch_to(this_domain,next_domain,cpuid);
+=09    adeos_load_cpuid(); /* Processor might have changed. */
+=09    }

=09if (next_domain =3D=3D this_domain || !propagate)
=09    break;



