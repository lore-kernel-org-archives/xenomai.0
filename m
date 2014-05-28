Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
From: Michael Haberler <mail17@mah.priv.at>
In-Reply-To: <538622C8.6000906@xenomai.org>
Date: Wed, 28 May 2014 22:31:37 +0200
Content-Transfer-Encoding: quoted-printable
Message-Id: <E8636526-7C80-4789-99F1-C570732F6928@mah.priv.at>
References: <CAO0fa7ZiofUS3wsbx89uYsnt6icuv+DVcDbiEfVyG5DUeprj2w@mail.gmail.com>	<5382E8B1.8070402@xenomai.org>	<CAO0fa7YQ0TxiAhbmFmt+41o+rugoLXKjXxtHygpthNOiu8gd9w@mail.gmail.com>	<5383406C.4070902@xenomai.org>	<CAO0fa7YavfJxxLW6h3Wm8CRmS2+yb9Uhv5RDfsv04+pcpvorFg@mail.gmail.com>	<CAO0fa7byLgJQ2_sLDtJLmjsf=oh2NF7k37qnWWxmwhZW6N1ksw@mail.gmail.com>
 <CAO0fa7YGSCmPducStbh7sM=HJtPYq86iO1e2ZAaKyjUjzPMEUA@mail.gmail.com>
 <5385F190.7050303@xenomai.org>
 <C528C59E-AFE8-4810-AC6F-E58A2C1DA47D@mah.priv.at>
 <538622C8.6000906@xenomai.org>
Subject: Re: [Xenomai] gdb / threads on beaglebone black
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org


Am 28.05.2014 um 19:54 schrieb Gilles Chanteperdrix =
<gilles.chanteperdrix@xenomai.org>:

> On 05/28/2014 04:45 PM, Michael Haberler wrote:
>>=20
>> Am 28.05.2014 um 16:24 schrieb Philippe Gerum <rpm@xenomai.org>:
>>=20
>>> On 05/28/2014 04:08 PM, Drew wrote:
>>>> Yes, my guess was correct.
>>>> The do - while loop in trampoline is exiting with error -38 =
(-ENOSYS?)
>>>> If I change line 110 of skins/native/task.c:
>>>>=20
>>>> - while(err =3D=3D -EINTR)
>>>> + while(err =3D=3D -EINTR || err =3D=3D -ENOSYS)
>>>>=20
>>>> then I'm able to single-step in gdb. :-)
>>>>=20
>>>> Is my change a hack, or is it the correct thing to do?
>>=20
>> I reproduced the behavior on an slightlier earlier kernel version =
than Drew used:
>>=20
>> config: http://static.mah.priv.at/public/config.txt
>> dmesg: http://static.mah.priv.at/public/dmesg.txt
>>=20
>> $ cat /proc/ipipe/version
>> 3
>> $ cat /proc/xenomai/version
>> 2.6.3
>>=20
>>>=20
>>> No Xenomai call should ever return ENOSYS. Something is definitely =
wrong with the current setup.
>>>=20
>>>> It looks like rt_task_trampoline is only expecting EINTR to occur. =
Is
>>>> some other bug causing ENOSYS?
>>>=20
>>> This means that the 'barrier' syscall did not get to Xenomai core, =
but was rejected as undefined.
>>>=20
>>> Could any of the hints mentioned here apply in your case?
>>> =
http://www.xenomai.org/documentation/xenomai-2.6/html/TROUBLESHOOTING/#_an=
y_xenomai_service_fails_with_code_38_enosys
>>=20
>> as above, I'm not seeing a violation of any of those conditions?
>=20
> Is there no message printed on the kernel console which would explain
> why this syscall gets rejected?

this is the complete session on the console:

machinekit@beaglebone:~/xenomai-2.6/examples/native$ gdb =
trivial-periodic
GNU gdb (GDB) 7.4.1-debian
Copyright (C) 2012 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later =
<http://gnu.org/licenses/gpl.html>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.  Type "show =
copying"
and "show warranty" for details.
This GDB was configured as "arm-linux-gnueabihf".
For bug reporting instructions, please see:
<http://www.gnu.org/software/gdb/bugs/>...
Reading symbols from =
/home/machinekit/xenomai-2.6/examples/native/trivial-periodic...done.
(gdb) r
Starting program: =
/home/machinekit/xenomai-2.6/examples/native/trivial-periodic
[Thread debugging using libthread_db enabled]
Using host libthread_db library =
"/lib/arm-linux-gnueabihf/libthread_db.so.1".
[New Thread 0xb6fc0470 (LWP 649)]
[New Thread 0xb6e83470 (LWP 650)]
[Thread 0xb6fc0470 (LWP 649) exited]
[Thread 0xb6e83470 (LWP 650) exited]
hello world

^C
Program received signal SIGINT, Interrupt.
0xb6fa6fcc in pause () from /lib/arm-linux-gnueabihf/libpthread.so.0
(gdb)

dmesg is empty here

- Michael


>=20
>=20
> --=20
>                                                                Gilles.


