From: "Reitinger, Peter" <preitinger@carl-valentin.de>
Date: Fri, 26 Sep 2014 09:23:24 +0000
Message-ID: <a704f2630b5f4f11a891ffe53088983a@CVEX13.valentin-carl.de>
Content-Language: de-DE
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Xenomai] xeno-test on arm: ("/usr/xenomai/bin/smokey:
 sched_setconfig_np(add-quota-group): Invalid argument")
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, "xenomai@xenomai.org" <xenomai@xenomai.org>

-----Urspr=FCngliche Nachricht-----
Von: Philippe Gerum [mailto:rpm@xenomai.org]=20
Gesendet: Freitag, 26. September 2014 10:29
An: Reitinger, Peter
Betreff: Re: AW: AW: [Xenomai] bad syscall <167772715>/ Segmentation fault =
during xeno-test

On 09/26/2014 09:53 AM, Reitinger, Peter wrote:
> -----Urspr=FCngliche Nachricht-----
> Von: Philippe Gerum [mailto:rpm@xenomai.org]
> Gesendet: Freitag, 26. September 2014 09:54
> An: Reitinger, Peter
> Betreff: Re: AW: [Xenomai] bad syscall <167772715>/ Segmentation fault=20
> during xeno-test
>=20
> On 09/26/2014 09:39 AM, Reitinger, Peter wrote:
>> Hi Philippe,
>>
>> sorry for the late response, but I was out of office then ...
>>
>> I guess you mean sbin instead of bin. So, in case you still need it, the=
 output of version is:
>>
>> root@dimm-am335x:/usr/xenomai/sbin# ./version -a Xenomai/cobalt
>> v3.0-rc1 -- #a0b20f4 (2014-09-22 21:42:47 +0200)
>> Target: arm-poky-linux-gnueabi
>> Compiler: gcc version 4.8.1 (GCC)
>> Build args:  '--with-core=3Dcobalt' '--prefix=3D/usr/xenomai'=20
>> '--disable-debug' '--disable-assert' '--host=3Darm-poky-linux-gnueabi'=20
>> 'host_alias=3Darm-poky-linux-gnueabi' 'CC=3Darm-poky-linux-gnueabi-gcc=20
>> -marc h=3Darmv7-a -mthumb-interwork -mfloat-abi=3Dsoftfp -mfpu=3Dneon=20
>> --sysroot=3D/opt/poky/1.5.1/sysroots/armv7a-vfp-neon-poky-linux-gnueabi'
>> 'CFLAGS=3D -O2 -pipe -g -feliminate-unused-debug-types'=20
>> 'LDFLAGS=3D-Wl,-O1 -Wl,--hash-style=3Dgnu -Wl,--as-needed' 'CPPFLAGS=3D'
>> 'CPP=3Darm-poky-linux-gnueabi-gcc -E  -march=3Darmv7-a -mthumb-interwork=
=20
>> -mfloat-abi=3Dsoftfp -mfpu=3Dneon
>> --sysroot=3D/opt/poky/1.5.1/sysroots/armv7a-vfp-neon-
>> poky-linux-gnueabi' 'PKG_CONFIG_PATH=3D/opt/poky/1.5.1/sysroots/armv7a-v=
fp-neon-poky-linux-gnueabi/usr/lib/pkgconfig'
>> root@dimm-am335x:/usr/xenomai/sbin#
>>
>> Thank you for the very very fast reaction and help!
>=20
> I could reproduce the issue, which is now fixed in the repo. You may want=
 to resync with the master branch, which is significantly ahead of your tre=
e by now.
>=20
>>
>> Kind regards
>> Peter Reitinger
>>
>> -----Urspr=FCngliche Nachricht-----
>> Von: Philippe Gerum [mailto:rpm@xenomai.org]
>> Gesendet: Donnerstag, 25. September 2014 17:15
>> An: Reitinger, Peter; xenomai@xenomai.org
>> Betreff: Re: [Xenomai] bad syscall <167772715>/ Segmentation fault=20
>> during xeno-test
>>
>> On 09/25/2014 04:52 PM, Reitinger, Peter wrote:
>>> Dear Xenomai people,
>>>
>>> I have recently tried to migrate from 2.x to 3.x, but when I tried to r=
un xeno-test, I get the following output:
>>>
>>>
>>
>> [snip]
>>
>>> [   94.434282] [Xenomai] bad syscall <167772715>
>>> Segmentation fault
>>> root@dimm-am335x:/usr/xenomai/bin#
>>>
>>>
>>>
>>> Probably I just forgot one or another little thing to adapt...?
>>>
>>
>> This is not a Xenomai 3 syscall signature, but a Xenomai 2.x's. Could yo=
u provide the output of /usr/xenomai/bin/version -a?
>>
>> TIA,
>>
>> --
>> Philippe.
>>
>=20
>=20
> Sorry, I forgot and did top-posting again...
>=20
> Thank you very much for the very quick fix. I am unfortunately a newbie i=
n git. I just called:
> git clone http://git.xenomai.org/xenomai-forge.git
>=20
> But obviously, that did not bring me the latest version. I'll try to=20
> figure out how to get this master branch... :)
>=20

"git checkout master" from the tree you have cloned should suffice, it may =
already be switched to this branch by default actually. "git status"
will tell you which branch you are on. For the rest, you should follow one =
of the links mentioned here:

http://xenomai.org/start-here/#Using_GIT

--
Philippe.

Dear Xenomai people,

first of all, thank you very much for your very fast fix for my previous pr=
oblem regarding the xeno-test.

Unfortunately, after I have fetched the latest sources from master tree and=
 re-patched kernel, rebuilt kernel, re-configured xenomai libs and rebuilt =
them as well, I have run into a new problem with xeno-test, this time durin=
g " smokey", it seems:

root@dimm-am335x:/usr/xenomai/bin# ./xeno-test
Started child 1244: /bin/sh /usr/xenomai/bin/xeno-test-run-wrapper ./xeno-t=
est
+ echo 0
+ testdir=3D/usr/xenomai/bin
+ /usr/xenomai/bin/smokey --run
mul: 0x79364d93, shft: 26
integ: 30, frac: 0x4d9364d9364d9364

signed positive operation: 0x03ffffffffffffff * 1000000000 / 33000000
inline calibration: 0x0000000000000000: 219.887 ns, rejected 1/10000
inlined llimd: 0x79364d9364d9362f: 1270.941 ns, rejected 7/10000
inlined llmulshft: 0x79364d92ffffffe1: 33.141 ns, rejected 2/10000
inlined nodiv_llimd: 0x79364d9364d9362f: 60.212 ns, rejected 2/10000
out of line calibration: 0x0000000000000000: 230.087 ns, rejected 2/10000
out of line llimd: 0x79364d9364d9362f: 1283.858 ns, rejected 4/10000
out of line llmulshft: 0x79364d92ffffffe1: 29.962 ns, rejected 2/10000
out of line nodiv_llimd: 0x79364d9364d9362f: 53.370 ns, rejected 3/10000

signed negative operation: 0xfc00000000000001 * 1000000000 / 33000000
inline calibration: 0x0000000000000000: 219.904 ns, rejected 1/10000
inlined llimd: 0x86c9b26c9b26c9d1: 1279.983 ns, rejected 7/10000
inlined llmulshft: 0x86c9b26d0000001e: 40.145 ns, rejected 0/10000
inlined nodiv_llimd: 0x86c9b26c9b26c9d1: 60.295 ns, rejected 1/10000
out of line calibration: 0x0000000000000000: 230.124 ns, rejected 3/10000
out of line llimd: 0x86c9b26c9b26c9d1: 1289.825 ns, rejected 4/10000
out of line llmulshft: 0x86c9b26d0000001e: 29.837 ns, rejected 2/10000
out of line nodiv_llimd: 0x86c9b26c9b26c9d1: 59.825 ns, rejected 2/10000

unsigned operation: 0x03ffffffffffffff * 1000000000 / 33000000
inline calibration: 0x0000000000000000: 220.170 ns, rejected 1/10000
inlined nodiv_ullimd: 0x79364d9364d9362f: 59.916 ns, rejected 1/10000
out of line calibration: 0x0000000000000000: 230.016 ns, rejected 5/10000
out of line nodiv_ullimd: 0x79364d9364d9362f: 49.979 ns, rejected 5/10000
arith OK
server: received 4 bytes, 1 from port 12
client: sent 4 bytes, 1
server: received 4 bytes, 2 from port 12
client: sent 4 bytes, 2
server: received 4 bytes, 3 from port 12
client: sent 4 bytes, 3
server: received 4 bytes, 4 from port 12
client: sent 4 bytes, 4
server: received 4 bytes, 5 from port 12
client: sent 4 bytes, 5
server: received 4 bytes, 6 from port 12
client: sent 4 bytes, 6
server: received 4 bytes, 7 from port 12
client: sent 4 bytes, 7
server: received 4 bytes, 8 from port 12
client: sent 4 bytes, 8
server: received 4 bytes, 9 from port 12
client: sent 4 bytes, 9
server: received 4 bytes, 10 from port 12
client: sent 4 bytes, 10
server: received 4 bytes, 11 from port 12
client: sent 4 bytes, 11
server: received 4 bytes, 12 from port 12
client: sent 4 bytes, 12
server: received 4 bytes, 13 from port 12
client: sent 4 bytes, 13
server: received 4 bytes, 14 from port 12
client: sent 4 bytes, 14
server: received 4 bytes, 15 from port 12
client: sent 4 bytes, 15
server: received 4 bytes, 16 from port 12
client: sent 4 bytes, 16
server: received 4 bytes, 17 from port 12
client: sent 4 bytes, 17
server: received 4 bytes, 18 from port 12
client: sent 4 bytes, 18
server: received 4 bytes, 19 from port 12
client: sent 4 bytes, 19
server: received 4 bytes, 20 from port 12
client: sent 4 bytes, 20
server: received 4 bytes, 21 from port 12
client: sent 4 bytes, 21
server: received 4 bytes, 22 from port 12
client: sent 4 bytes, 22
server: received 4 bytes, 23 from port 12
client: sent 4 bytes, 23
server: received 4 bytes, 24 from port 12
client: sent 4 bytes, 24
server: received 4 bytes, 25 from port 12
client: sent 4 bytes, 25
server: received 4 bytes, 26 from port 12
client: sent 4 bytes, 26
server: received 4 bytes, 27 from port 12
client: sent 4 bytes, 27
server: received 4 bytes, 28 from port 12
client: sent 4 bytes, 28
server: received 4 bytes, 29 from port 12
client: sent 4 bytes, 29
bufp OK
simple_condwait
relative_condwait
absolute_condwait
sig_norestart_condwait
sig_restart_condwait
sig_norestart_condwait_mutex
sig_restart_condwait_mutex
sig_norestart_double
sig_restart_double
cond_destroy_whilewait
cond_torture OK
Test OK
fork_exec OK
server: received 4 bytes, 1 from port 13
client: sent 4 bytes, 1
server: received 4 bytes, 2 from port 13
client: sent 4 bytes, 2
server: received 4 bytes, 3 from port 13
client: sent 4 bytes, 3
server: received 4 bytes, 4 from port 13
client: sent 4 bytes, 4
server: received 4 bytes, 5 from port 13
client: sent 4 bytes, 5
server: received 4 bytes, 6 from port 13
client: sent 4 bytes, 6
server: received 4 bytes, 7 from port 13
client: sent 4 bytes, 7
server: received 4 bytes, 8 from port 13
client: sent 4 bytes, 8
server: received 4 bytes, 9 from port 13
client: sent 4 bytes, 9
server: received 4 bytes, 10 from port 13
client: sent 4 bytes, 10
server: received 4 bytes, 11 from port 13
client: sent 4 bytes, 11
server: received 4 bytes, 12 from port 13
client: sent 4 bytes, 12
server: received 4 bytes, 13 from port 13
client: sent 4 bytes, 13
server: received 4 bytes, 14 from port 13
client: sent 4 bytes, 14
server: received 4 bytes, 15 from port 13
client: sent 4 bytes, 15
server: received 4 bytes, 16 from port 13
client: sent 4 bytes, 16
server: received 4 bytes, 17 from port 13
client: sent 4 bytes, 17
server: received 4 bytes, 18 from port 13
client: sent 4 bytes, 18
server: received 4 bytes, 19 from port 13
client: sent 4 bytes, 19
server: received 4 bytes, 20 from port 13
client: sent 4 bytes, 20
server: received 4 bytes, 21 from port 13
client: sent 4 bytes, 21
server: received 4 bytes, 22 from port 13
client: sent 4 bytes, 22
server: received 4 bytes, 23 from port 13
client: sent 4 bytes, 23
server: received 4 bytes, 24 from port 13
client: sent 4 bytes, 24
server: received 4 bytes, 25 from port 13
client: sent 4 bytes, 25
server: received 4 bytes, 26 from port 13
client: sent 4 bytes, 26
server: received 4 bytes, 27 from port 13
client: sent 4 bytes, 27
server: received 4 bytes, 28 from port 13
client: sent 4 bytes, 28
server: received 4 bytes, 29 from port 13
client: sent 4 bytes, 29
iddp OK
simple_wait
recursive_wait
errorcheck_wait
timed_mutex
mode_switch
pi_wait
lock_stealing
NOTE: lock_stealing mutex_trylock: not supported
deny_stealing
mutex_torture OK
simple_condwait
recursive_condwait
auto_switchback
Setup
Exclusive open
Successive open
Defer close by pending reference
Normal close
Deferred module unload
rtdm OK
/usr/xenomai/bin/smokey: sched_setconfig_np(add-quota-group): Invalid argum=
ent
calibrating: 133262220 loops/sec
root@dimm-am335x:/usr/xenomai/bin#

----

My version is:

root@dimm-am335x:/usr/xenomai/sbin# ./version -a
Xenomai/cobalt v3.0-rc1 -- #2e808a6 (2014-09-25 21:12:15 +0200)
Target: arm-poky-linux-gnueabi
Compiler: gcc version 4.8.1 (GCC)
Build args:  '--with-core=3Dcobalt' '--prefix=3D/usr/xenomai' '--disable-de=
bug' '--disable-assert' '--host=3Darm-poky-linux-gnueabi' 'host_alias=3Darm=
-poky-linux-gnueabi' 'CC=3Darm-poky-linux-gnueabi-gcc  -marc
h=3Darmv7-a -mthumb-interwork -mfloat-abi=3Dsoftfp -mfpu=3Dneon --sysroot=
=3D/opt/poky/1.5.1/sysroots/armv7a-vfp-neon-poky-linux-gnueabi' 'CFLAGS=3D =
-O2 -pipe -g -feliminate-unused-debug-types' 'LDFLAGS=3D-Wl,-O1
-Wl,--hash-style=3Dgnu -Wl,--as-needed' 'CPPFLAGS=3D' 'CPP=3Darm-poky-linux=
-gnueabi-gcc -E  -march=3Darmv7-a -mthumb-interwork -mfloat-abi=3Dsoftfp -m=
fpu=3Dneon --sysroot=3D/opt/poky/1.5.1/sysroots/armv7a-vfp-neon-
poky-linux-gnueabi' 'PKG_CONFIG_PATH=3D/opt/poky/1.5.1/sysroots/armv7a-vfp-=
neon-poky-linux-gnueabi/usr/lib/pkgconfig'
root@dimm-am335x:/usr/xenomai/sbin#

I feel that it is no bad idea to automate my process for re-fetching source=
s, and re-building everything, meanwhile... ;-)

Thanks again in advance!

Kind regards
Peter Reitinger

