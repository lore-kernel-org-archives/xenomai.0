Subject: Re: Error compiling 3.0.8
References: <014b0e4c-9aee-3f05-b6a5-2ecaefcfbc25@alaxarxa.net>
 <65c0d39a-6d70-602d-fdfb-64742e152823@web.de>
 <b12be0ba-2d5d-f875-2ace-d7eb32a3cf54@alaxarxa.net>
From: Jan Kiszka <jan.kiszka@web.de>
Message-ID: <8d22cc15-3c7b-f4c2-0ebb-3941fb6efb00@web.de>
Date: Wed, 1 May 2019 22:27:17 +0200
MIME-Version: 1.0
In-Reply-To: <b12be0ba-2d5d-f875-2ace-d7eb32a3cf54@alaxarxa.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Leopold Palomo-Avellaneda <leo@alaxarxa.net>, Xenomai list <xenomai@xenomai.org>

On 01.05.19 22:20, Leopold Palomo-Avellaneda wrote:
> El 1/5/19 a les 20:55, Jan Kiszka ha escrit:
>> On 01.05.19 18:46, Leopold Palomo-Avellaneda via Xenomai wrote:
>>> Hi,
>>>
>>>
>>> trying to build a new kernel for xenomai 3.0.8 using debian packages
>>> (x86 arch) I have found that fails:
>>>
>>> scripts/Makefile.build:585: recipe for target
>>> 'drivers/xenomai/net/addons' failed
>>> make[4]: *** [drivers/xenomai/net/addons] Error 2
>>> make[4]: *** Waiting for unfinished jobs....
>>>  =C2=A0=C2=A0 CC [M]=C2=A0 drivers/staging/rtl8712/rtl8712_cmd.o
>>> In file included from drivers/xenomai/net/stack/include/rtdev.h:37:0,
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 from drivers/xenomai/net/stack/include/r=
tnet_port.h:32,
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 from drivers/xenomai/net/drivers/too.c:5=
4:
>>> drivers/xenomai/net/stack/include/rtskb.h:32:22: fatal error:
>>> rtdm/net.h: El fitxer o directori no existeix
>>>  =C2=A0 #include <rtdm/net.h>
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^
>>> compilation terminated.
>>> scripts/Makefile.build:326: recipe for target
>>> 'drivers/xenomai/net/drivers/8139too.o' failed
>>>
>>> checking a bit, I have found that that include is used:
>>>
>>> drivers/xenomai/net/stack/rtdev_mgr.c:#include <rtdm/net.h>
>>> drivers/xenomai/net/stack/include/rtskb.h:#include <rtdm/net.h>
>>> drivers/xenomai/net/stack/include/rtnet_socket.h:#include <rtdm/net.h>
>>> drivers/xenomai/net/stack/socket.c:#include <rtdm/net.h>
>>> drivers/xenomai/net/stack/ipv4/tcp/timerwheel.h:#include <rtdm/net.h>
>>> drivers/xenomai/net/drivers/macb.c:#include <rtdm/net.h>
>>> drivers/xenomai/net/drivers/at91_ether.c:#include <rtdm/net.h>
>>>
>>> that file is here:
>>>
>>> xenomai-dev: /usr/include/xenomai/rtdm/net.h
>>> xenomai-kernel-source: /usr/src/xenomai-kernel-source/include/rtdm/net=
.h
>>>
>>> so, or the prepare-kernel.sh is wrong forget to make a link, or I made=
 a
>>> some mistake in the debian package or something is happening.
>>>
>>> Any idea?
>>>
>>
>> There are no obviously related patches in next or master that might be
>> missing
>> in stable.
>>
>> Does it work when you build that thing outside of the package generatio=
n?
>
> yes, it works, but not 100%. But it's another issue.
>
> drivers/xenomai/net/drivers/e1000e/netdev.c: In function
> =E2=80=98e1000e_set_interrupt_capability=E2=80=99:
> drivers/xenomai/net/drivers/e1000e/netdev.c:1225:11: error: implicit
> declaration of function =E2=80=98pci_enable_msix=E2=80=99
> [-Werror=3Dimplicit-function-declaration]
>       err =3D pci_enable_msix(adapter->pdev,
>             ^~~~~~~~~~~~~~~
>

Yeah, that's already fixed in stable/v3.0.x.

> I will check what happens with the debian package.

Ok. I'm planning for some 3.0.9 soon, so we should sort out remaining issu=
es.

>
> Leopold
>
> Ps. didn't receive any email from the list ...
>

Seems only slightly delayed: the archive shows it now, also news.gmane.org=
.

Jan

