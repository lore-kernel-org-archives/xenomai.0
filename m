Message-ID: <550FF5FB.3090603@xenomai.org>
Date: Mon, 23 Mar 2015 12:16:11 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <CAKk99t1N5b0_iQerSxPyKmMTLC8PePTJCO9zzFLdkmt_mDiiVg@mail.gmail.com>	<54F73E7A.2070100@xenomai.org>	<CAKk99t0z4Tq==LTzFK_9cmbrDTZ+RFt2vo=ur56VbVG3sso_iQ@mail.gmail.com>	<5505B14F.4060107@xenomai.org>	<CAKk99t3Gv-3Nz=drk-bOvbYo7EU3F-DSsGA35Z6D6GdF_z00Zg@mail.gmail.com>	<55072D34.1070405@xenomai.org>	<CAKk99t2ZsNmY4myJAF+H3hWNpHN4bVm255QEsU6Nu+ytG-B0dA@mail.gmail.com>	<550837E2.9050701@xenomai.org>	<CAKk99t2eGYME0BsLCjJV7VMm8VU_2okmpd8sYfMb_02sTvOfLQ@mail.gmail.com>	<55083DA4.3080201@xenomai.org>	<CAKk99t0pG6HWOucFXDw1-_5-=EGQ7faqA22yVog6Ye6TcGjevA@mail.gmail.com>	<550850D5.9060207@xenomai.org>	<CAKk99t0q3iNcah1Us79hJUjjHQCr2rEPu9gukSNjO2a6+Gk3sg@mail.gmail.com>	<CAKk99t3wP-WLemoO_bbsvE4uwh-Sh-5eGPJrM=6cAc5edyQW5Q@mail.gmail.com>	<5508600D.4020500@xenomai.org>	<CAKk99t3xFzLuydH3HoPzWBzjd5DNtC_4Kf3YQuodHDpXTLdsUg@mail.gmail.com>	<550B0626.5090801@xenomai.org>	<550B1584.8040309@xenomai.org>
 <CAKk99t0ndeNODKHf3mmL4GTg9wrOnOcsgf_okqx_-dmNitWkXA@mail.gmail.com>
In-Reply-To: <CAKk99t0ndeNODKHf3mmL4GTg9wrOnOcsgf_okqx_-dmNitWkXA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Xenomai/cobalt: low_init(): binding failed: Function
 not implemented error issued when trting to run latency app on xeno 3.x-rc3
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Helder Daniel <hdaniel@ualg.pt>
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>

On 03/23/2015 11:59 AM, Helder Daniel wrote:
> Ok,
> 
> but now I am compiling a module to write for an I/O port (code below)
> With the previous version of next branch I can compile it without any
> error, insert it check that it is working fine by reading te I/O port
> from an user space app, but with this new version, when compiling the
> module, I get:
> 
>  CC [M]  /mnt/hgfs/apps-3.x/10-portAccessSyncKernel/writeportK.o
> In file included from include/xenomai/rtdm/driver.h:43:0,
>                  from
> /mnt/hgfs/apps-3.x/10-portAccessSyncKernel/writeportK.c:8:
> include/xenomai/cobalt/kernel/init.h:24:33: fatal error:
> cobalt/uapi/corectl.h: No such file or directory
>  #include <cobalt/uapi/corectl.h>

I just checked and the module builds fine ou of tree, using the very
same Makefile. Could you check that the kernel you build against is
actually prepared with Xenomai sources?

-- 
Philippe.

