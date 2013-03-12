Message-ID: <513F8434.6070405@xenomai.org>
Date: Tue, 12 Mar 2013 20:38:28 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <512C806F.2020209@hilscher.com>	<512C9E78.1060208@siemens.com>	<512CC5C6.8050204@hilscher.com>	<512CC6A3.1010005@siemens.com>	<512F120A.5060109@hilscher.com>	<512F4005.60000@siemens.com>	<512F48AA.8020601@hilscher.com>	<5130B39C.70300@hilscher.com>	<513465CF.4030807@hilscher.com>	<51350D5B.6060309@xenomai.org>	<5135CCDE.5090401@hilscher.com>	<5135D667.8060309@siemens.com>	<51361281.20307@hilscher.com>	<51364A61.3090002@xenomai.org>	<5136F9E9.9030604@hilscher.com>	<5136FC1E.6060608@xenomai.org>	<51371B89.4020103@hilscher.com>	<513730CE.2070102@xenomai.org>	<51374B98.7030103@hilscher.com>	<51376093.7060701@siemens.com>	<5137AF89.1020009@xenomai.org>	<5138B33C.1060506@hilscher.com>	<5139BABA.8010602@hilscher.com>	<5139D7F5.2090904@xenomai.org>
	<513EF0F0.4070705@hilscher.com>	<513F1DBD.5090603@xenomai.org>
	<513F4944.9010202@hilscher.com>
In-Reply-To: <513F4944.9010202@hilscher.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Hilscher driver for cifX boards
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jerome Poncin <JPoncin@hilscher.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 03/12/2013 04:27 PM, Jerome Poncin wrote:

> Le 12/03/2013 13:21, Gilles Chanteperdrix a =C3=A9crit :
>> On 03/12/2013 10:10 AM, Jerome Poncin wrote:
>>
>>> Le 08/03/2013 13:22, Gilles Chanteperdrix a =C3=A9crit :
>>>> On 03/08/2013 11:17 AM, Jerome Poncin wrote:
>>>>
>>>>> Le 07/03/2013 16:33, Jerome Poncin a =C3=A9crit :
>>>>>> Le 06/03/2013 22:05, Gilles Chanteperdrix a =C3=A9crit :
>>>>>>> On 03/06/2013 04:28 PM, Jan Kiszka wrote:
>>>>>>>
>>>>>>>> Also here: Do not misuse write(), define an IOCTL that contains
>>>>>>>> something like "MMAP" and another one with MUNMAP in its name - =
that's
>>>>>>>> the purpose of this service, no?
>>>>>>> A lot of drivers probably have to reinvent a way to pass all the
>>>>>>> parameters for an mmap, why not adding an "mmap" method to RTDM d=
rivers?
>>>>>>>
>>>>>>>
>>>>>> Hello,
>>>>>>
>>>>>> I  re factored my code with all your remarks (I think and I hope).=

>>>>>>
>>>>>> Could you say me if it's correct now ?
>>>>>>
>>>>>> Jan, you're right, It's possible to use Xenomai with UIO driver, b=
ut I
>>>>>> would like to use more real time possibilities of Xenomai in futur=
e
>>>>>> (like IRQ).
>>>>>> My first goal is to have a code compliant.
>>>>>> I added IRQ, and my next step will be to understand why the kernel=

>>>>>> crash after IRQ registration.
>>>>>>
>>>>>> Thank you for your help,
>>>>>>
>>>>>> Jerome
>>>>>>
>>>>>>
>>>>>>
>>>>> Hello,
>>>>>
>>>>> I have good news because, I arrived to validated driver with IRQ
>>>>> support. I changed position of cifx on my motherboard in my PC and =
the
>>>>> IRQ affected is not shared ;-) !
>>>>>
>>>>> I have now a question about IRQ. What is the good method to signal =
to
>>>>> user-land that there is an IRQ. Is there an example ?
>>>> Almost every "read" call is an example... ;-)
>>>>
>>> Hello,
>>>
>>> I'm finishing my driver with IRQ. I saw that there is two mode, Real
>>> time and Non real time for RTDM driver function.
>>> My driver should run in the two mode. When I compile my User Space
>>> Shared library that call Xenomai Kernel driver,
>>> I saw that library call every time Non real time function and no real=

>>> time function...
>>> I use a shared library with posix skin with makefile in attached file=
=2E I
>>> read explanation for static library with posix skin :
>>>
>>> http://www.xenomai.org/index.php/Porting_POSIX_applications_to_Xenoma=
i
>>>
>>> What must I do with shared library for using rt mode ?
>>
>> Use the LDLIBS variable when linking the library?
>>
> Gilles,
>=20
> you're right ;-), I didn't use LDLIBS for linking the library, therefor=
e=20
> I corrected this.
>=20
> Now I have this as link line for my library :
>=20
> gcc -shared -Xlinker -rpath -Xlinker /usr/xenomai/lib=20
> -I/usr/xenomai/include/include/xenomai=20
> -I/usr/xenomai/include/include/xenomai/compat=20
> -I/usr/xenomai/include/include/xenomai/posix -I./ -I.//Toolkit=20
> -Wl,@/usr/xenomai/lib/posix.wrappers -L/usr/xenomai/lib -lpthread_rt=20
> -lxenomai -lpthread -lrt -o libcifx.so .//cifXDownload.o=20
> .//cifXEndianess.o .//cifXFunctions.o .//cifXHWFunctions.o .//cifXInit.=
o=20
> .//cifXInterrupt.o .//md5.o   .//cifx_xenomai.o .//OS_xenomai.o=20
> .//USER_xenomai.o
>=20
> and this for the application :
>=20
> gcc -DCONSUMER -I/usr/xenomai/include -D_GNU_SOURCE -D_REENTRANT=20
> -D__XENO__ -I/usr/xenomai/include/posix -I../libcifx=20
> -I../libcifx/Toolkit -O2   -lcifx -lpciaccess -lrtdm -Xlinker -rpath=20
> -Xlinker /usr/xenomai/lib  cifx_xenomai_sample.c=20
> -Wl,@/usr/xenomai/lib/posix.wrappers -L/usr/xenomai/lib -lpthread_rt=20
> -lxenomai -lpthread -lrt -lcifx -lpciaccess -lrtdm -o cifx_xenomai_samp=
le
>=20
> with
>=20
> mlockall(MCL_CURRENT | MCL_FUTURE);
>=20
>=20
> first line in main
>=20
> I have a new log :
>=20
> [ 4700.073616] cifx 0000:04:01.0: PCI INT A -> GSI 16 (level, low) -> I=
RQ 16
> [ 4700.073643] cifx 0000:04:01.0: DPM at FEBF0000
> [ 4700.073654] cifx 0000:04:01.0: registered CifX card
> [ 4734.146888] NRT mode
> [ 4751.104009] rt
> [ 4751.388002] Xenomai: Posix: destroying mutex f8419600.
>=20
> But as you see It seems I'm always in Non Real Time mode...


I do not see anything, as I do not see the sources for either your
driver or application.

>=20
> Do you have an idea about my problem ?
>=20

> The log "rt" and " Xenomai: Posix: destroying mutex f8419600." is norma=
l ?


It depends if you consider normal leaving an application with a mutex
created but not destroyed.

--=20
                                                                Gilles.


