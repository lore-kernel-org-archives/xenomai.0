MIME-Version: 1.0
Sender: had2006@gmail.com
In-Reply-To: <CAKk99t3Z-euF4518Q5WsGFmsxqvwRgvz0bTBQm5pbBCD5d8MwA@mail.gmail.com>
References: <CAKk99t1N5b0_iQerSxPyKmMTLC8PePTJCO9zzFLdkmt_mDiiVg@mail.gmail.com>
 <54F73E7A.2070100@xenomai.org>
 <CAKk99t0z4Tq==LTzFK_9cmbrDTZ+RFt2vo=ur56VbVG3sso_iQ@mail.gmail.com>
 <5505B14F.4060107@xenomai.org>
 <CAKk99t3Gv-3Nz=drk-bOvbYo7EU3F-DSsGA35Z6D6GdF_z00Zg@mail.gmail.com>
 <55072D34.1070405@xenomai.org>
 <CAKk99t2ZsNmY4myJAF+H3hWNpHN4bVm255QEsU6Nu+ytG-B0dA@mail.gmail.com>
 <550837E2.9050701@xenomai.org>
 <CAKk99t2eGYME0BsLCjJV7VMm8VU_2okmpd8sYfMb_02sTvOfLQ@mail.gmail.com>
 <55083DA4.3080201@xenomai.org>
 <CAKk99t0pG6HWOucFXDw1-_5-=EGQ7faqA22yVog6Ye6TcGjevA@mail.gmail.com>
 <550850D5.9060207@xenomai.org>
 <CAKk99t0q3iNcah1Us79hJUjjHQCr2rEPu9gukSNjO2a6+Gk3sg@mail.gmail.com>
 <CAKk99t3wP-WLemoO_bbsvE4uwh-Sh-5eGPJrM=6cAc5edyQW5Q@mail.gmail.com>
 <5508600D.4020500@xenomai.org>
 <CAKk99t3xFzLuydH3HoPzWBzjd5DNtC_4Kf3YQuodHDpXTLdsUg@mail.gmail.com>
 <550B0626.5090801@xenomai.org> <550B1584.8040309@xenomai.org>
 <CAKk99t0ndeNODKHf3mmL4GTg9wrOnOcsgf_okqx_-dmNitWkXA@mail.gmail.com>
 <550FF5FB.3090603@xenomai.org>
 <CAKk99t2wHiUC_YCuLVt_4q_OKT_+PCeM3FY1pHSpOoz_faBZ4g@mail.gmail.com>
 <CAKk99t3Z-euF4518Q5WsGFmsxqvwRgvz0bTBQm5pbBCD5d8MwA@mail.gmail.com>
Date: Mon, 23 Mar 2015 12:11:49 +0000
Message-ID: <CAKk99t1S8wXb2c7rBue_tBqrHBkYn8hQWkp6eBDaBO3O5e-=DQ@mail.gmail.com>
From: Helder Daniel <hdaniel@ualg.pt>
Content-Type: text/plain; charset=UTF-8
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
To: Philippe Gerum <rpm@xenomai.org>
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>

But the issue should not be the Xenomai version.

With the older version now I am getting the same compilation error.

I mean the older next branch Xenomai 3 version

On 23 March 2015 at 11:47, Helder Daniel <hdaniel@ualg.pt> wrote:

> PS: I can run also /usr/xenomai/bin/latency
>
> On 23 March 2015 at 11:47, Helder Daniel <hdaniel@ualg.pt> wrote:
>
>> It seems that the Xenomai support was not loaded at boot time:
>>
>> root@debian:/usr/src# dmesg | grep -i xeno
>> [    1.780077] [Xenomai] scheduling class idle registered.
>> [    1.780077] [Xenomai] scheduling class rt registered.
>> [    1.784077] [Xenomai] init failed, code -19
>> [   12.612754] *** RTnet for Xenomai v3.0-rc3 ***
>>
>> I rebooted and now it seems it is loaded:
>>
>>  dmesg | grep -i xeno
>> [    1.048963] [Xenomai] scheduling class idle registered.
>> [    1.048985] [Xenomai] scheduling class rt registered.
>> [    1.049211] I-pipe: head domain Xenomai registered.
>> [    1.070494] [Xenomai] Cobalt v3.0-rc3 (Exact Zero)
>> [    5.453304] *** RTnet for Xenomai v3.0-rc3 ***
>>
>> But I still get the same compilation error.
>> I can compile and run a Xenomai user space app.
>>
>> I am using a Cobalt setup, kernel 3.16, ipipe patch version
>> 3: ipipe-core-3.16-x86-3.patch
>>
>> root@debian:/usr/src# uname -a
>> Linux debian 3.16.0-ipipe #1 SMP Fri Mar 6 14:27:41 WET 2015 x86_64
>> GNU/Linux
>>
>> root@debian:/usr/xenoami/sbin/version -a
>> Xenomai/cobalt v3.0-rc3 --
>> Target: x86_64-unknown-linux-gnu
>> Compiler: gcc version 4.9.2 (Debian 4.9.2-10)
>> Build args:  '--with-core=cobalt' '--enable-registry' '--enable-pshared'
>> '--enable-smp'
>>
>>
>> On 23 March 2015 at 11:16, Philippe Gerum <rpm@xenomai.org> wrote:
>>
>>> On 03/23/2015 11:59 AM, Helder Daniel wrote:
>>> > Ok,
>>> >
>>> > but now I am compiling a module to write for an I/O port (code below)
>>> > With the previous version of next branch I can compile it without any
>>> > error, insert it check that it is working fine by reading te I/O port
>>> > from an user space app, but with this new version, when compiling the
>>> > module, I get:
>>> >
>>> >  CC [M]  /mnt/hgfs/apps-3.x/10-portAccessSyncKernel/writeportK.o
>>> > In file included from include/xenomai/rtdm/driver.h:43:0,
>>> >                  from
>>> > /mnt/hgfs/apps-3.x/10-portAccessSyncKernel/writeportK.c:8:
>>> > include/xenomai/cobalt/kernel/init.h:24:33: fatal error:
>>> > cobalt/uapi/corectl.h: No such file or directory
>>> >  #include <cobalt/uapi/corectl.h>
>>>
>>> I just checked and the module builds fine ou of tree, using the very
>>> same Makefile. Could you check that the kernel you build against is
>>> actually prepared with Xenomai sources?
>>>
>>> --
>>> Philippe.
>>>
>>
>>
>>
>> --
>> Helder Daniel
>> UALG - FCT
>> DEEI
>>
>> http://w3.ualg.pt/~hdaniel
>>
>
>
>
> --
> Helder Daniel
> UALG - FCT
> DEEI
>
> http://w3.ualg.pt/~hdaniel
>



-- 
Helder Daniel
UALG - FCT
DEEI

http://w3.ualg.pt/~hdaniel
