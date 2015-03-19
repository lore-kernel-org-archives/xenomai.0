Message-ID: <550B0626.5090801@xenomai.org>
Date: Thu, 19 Mar 2015 18:23:50 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <CAKk99t1N5b0_iQerSxPyKmMTLC8PePTJCO9zzFLdkmt_mDiiVg@mail.gmail.com>	<54F716CC.1010600@xenomai.org>	<CAKk99t14auR=Ez-9k6bSxDQt5iNbTjvYtxeaAyGzMPuwQi_nnQ@mail.gmail.com>	<54F73E7A.2070100@xenomai.org>	<CAKk99t0z4Tq==LTzFK_9cmbrDTZ+RFt2vo=ur56VbVG3sso_iQ@mail.gmail.com>	<5505B14F.4060107@xenomai.org>	<CAKk99t3Gv-3Nz=drk-bOvbYo7EU3F-DSsGA35Z6D6GdF_z00Zg@mail.gmail.com>	<55072D34.1070405@xenomai.org>	<CAKk99t2ZsNmY4myJAF+H3hWNpHN4bVm255QEsU6Nu+ytG-B0dA@mail.gmail.com>	<550837E2.9050701@xenomai.org>	<CAKk99t2eGYME0BsLCjJV7VMm8VU_2okmpd8sYfMb_02sTvOfLQ@mail.gmail.com>	<55083DA4.3080201@xenomai.org>	<CAKk99t0pG6HWOucFXDw1-_5-=EGQ7faqA22yVog6Ye6TcGjevA@mail.gmail.com>	<550850D5.9060207@xenomai.org>	<CAKk99t0q3iNcah1Us79hJUjjHQCr2rEPu9gukSNjO2a6+Gk3sg@mail.gmail.com>	<CAKk99t3wP-WLemoO_bbsvE4uwh-Sh-5eGPJrM=6cAc5edyQW5Q@mail.gmail.com>	<5508600D.4020500@xenomai.org>
 <CAKk99t3xFzLuydH3HoPzWBzjd5DNtC_4Kf3YQuodHDpXTLdsUg@mail.gmail.com>
In-Reply-To: <CAKk99t3xFzLuydH3HoPzWBzjd5DNtC_4Kf3YQuodHDpXTLdsUg@mail.gmail.com>
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
To: Helder Daniel <hdaniel@ualg.pt>, "Xenomai@xenomai.org" <xenomai@xenomai.org>

On 03/17/2015 06:19 PM, Helder Daniel wrote:
> ok
> 
> On 17 March 2015 at 17:10, Philippe Gerum <rpm@xenomai.org
> <mailto:rpm@xenomai.org>> wrote:
> 
>     On 03/17/2015 06:06 PM, Helder Daniel wrote:
>     > I am sorry I just found now.
>     > It still happens with Mercury (with the configuration described in the
>     > previous email)
>     >
>     > When I compiled another app and try to run it I got the same error:
>     >
>     > root@debian:~/09-portAccessSyncTwoAppsC++# ./writeport
>     > sysregd: create_directory_recursive("/var/run/xenomai/anon/system"):
>     > Transport endpoint is not connected
>     > sysregd: create_directory_recursive("/var/run/xenomai/anon/system"):
>     > Transport endpoint is not connected
>     > sysregd: create_directory_recursive("/var/run/xenomai/anon/system"):
>     > Transport endpoint is not connected
>     >    3"012.188| WARNING: [main] cannot connect to registry daemon
>     >    3"012.188| BUG: [main] initialization failed, EAGAIN
> 
>     Ok. This one is different from the ENOMEM issue, which is
>     Cobalt-specific. The problem with mounting the anon/system root is a
>     FUSE issue, which still needs a work around it seems.
> 

The ENOMEM issue is now fixed in -next. I'll tackle the C++ parsing
problem with libtrank next.

-- 
Philippe.

