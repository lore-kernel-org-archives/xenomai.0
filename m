Subject: Re: Error compiling 3.0.8
References: <014b0e4c-9aee-3f05-b6a5-2ecaefcfbc25@alaxarxa.net>
From: Jan Kiszka <jan.kiszka@web.de>
Message-ID: <65c0d39a-6d70-602d-fdfb-64742e152823@web.de>
Date: Wed, 1 May 2019 20:55:32 +0200
MIME-Version: 1.0
In-Reply-To: <014b0e4c-9aee-3f05-b6a5-2ecaefcfbc25@alaxarxa.net>
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

On 01.05.19 18:46, Leopold Palomo-Avellaneda via Xenomai wrote:
> Hi,
>
>
> trying to build a new kernel for xenomai 3.0.8 using debian packages
> (x86 arch) I have found that fails:
>
> scripts/Makefile.build:585: recipe for target
> 'drivers/xenomai/net/addons' failed
> make[4]: *** [drivers/xenomai/net/addons] Error 2
> make[4]: *** Waiting for unfinished jobs....
>    CC [M]  drivers/staging/rtl8712/rtl8712_cmd.o
> In file included from drivers/xenomai/net/stack/include/rtdev.h:37:0,
>                   from drivers/xenomai/net/stack/include/rtnet_port.h:32=
,
>                   from drivers/xenomai/net/drivers/too.c:54:
> drivers/xenomai/net/stack/include/rtskb.h:32:22: fatal error:
> rtdm/net.h: El fitxer o directori no existeix
>   #include <rtdm/net.h>
>                        ^
> compilation terminated.
> scripts/Makefile.build:326: recipe for target
> 'drivers/xenomai/net/drivers/8139too.o' failed
>
> checking a bit, I have found that that include is used:
>
> drivers/xenomai/net/stack/rtdev_mgr.c:#include <rtdm/net.h>
> drivers/xenomai/net/stack/include/rtskb.h:#include <rtdm/net.h>
> drivers/xenomai/net/stack/include/rtnet_socket.h:#include <rtdm/net.h>
> drivers/xenomai/net/stack/socket.c:#include <rtdm/net.h>
> drivers/xenomai/net/stack/ipv4/tcp/timerwheel.h:#include <rtdm/net.h>
> drivers/xenomai/net/drivers/macb.c:#include <rtdm/net.h>
> drivers/xenomai/net/drivers/at91_ether.c:#include <rtdm/net.h>
>
> that file is here:
>
> xenomai-dev: /usr/include/xenomai/rtdm/net.h
> xenomai-kernel-source: /usr/src/xenomai-kernel-source/include/rtdm/net.h
>
> so, or the prepare-kernel.sh is wrong forget to make a link, or I made a
> some mistake in the debian package or something is happening.
>
> Any idea?
>

There are no obviously related patches in next or master that might be mis=
sing
in stable.

Does it work when you build that thing outside of the package generation?

Jan

