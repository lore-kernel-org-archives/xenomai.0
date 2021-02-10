Subject: Re: undefined symbol in tests
References: <CAPnNZ0UJEFhQXnmkH=RyBWVuXWiymw-S3jCcH+U5B_1VESALJA@mail.gmail.com>
 <cd4f3b32-d2bf-a96d-527a-5f7f3403e4d2@siemens.com>
 <CAPnNZ0Vt=mVk-JQoZM3TSGBBFOwqc+7KtnhtHVR89iLBo+cRqg@mail.gmail.com>
 <b6aa1c1a-7f68-c678-01ca-7cbb0fddffde@siemens.com>
 <CAPnNZ0Xv3gB5xnXaGN8wBfbgZgBB5XfDv9zBmyO9wD4T4WOBbA@mail.gmail.com>
 <c0ac33c8-51a8-d2c9-e8cf-088bc17f033a@siemens.com>
 <CAPnNZ0WyMCjodtJopJ7h0=28OVxeZHSgN6sQ9KJFKvf-aKYhug@mail.gmail.com>
 <00236a7b-33bc-a8ee-859e-6956d3679ce2@siemens.com>
 <CAPnNZ0WnsfxCrGWRhV0J0ROYB6t0wHTD25w4f8-cm1k5y4yvWg@mail.gmail.com>
 <3c86b640-63f3-a358-4175-0397ce319c0a@siemens.com>
 <1ded9560-5aa5-fdd1-6d64-6c02720cb02b@siemens.com>
 <CAPnNZ0XoaDA-PK+h2MdUsWJEv7Rm-yYSKLM8VCSm6EmBJjSo0w@mail.gmail.com>
 <8347be71-a8e2-1c0f-5229-6e379a380151@siemens.com>
 <CAPnNZ0WYrZUfX112tQYEypXd-A6PhfmZzoaL3XL2633t9sbW0A@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <78bab65f-f58a-9c93-a3c9-fcc1d406456d@siemens.com>
Date: Wed, 10 Feb 2021 09:15:04 +0100
MIME-Version: 1.0
In-Reply-To: <CAPnNZ0WYrZUfX112tQYEypXd-A6PhfmZzoaL3XL2633t9sbW0A@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Antoine Hoarau <antoine@flr.io>
Cc: Gylstorff Quirin <quirin.gylstorff@siemens.com>, Xenomai <xenomai@xenomai.org>

On 10.02.21 08:20, Antoine Hoarau wrote:
> Still having this "undefined reference" issue on 3.1. Is there any news
> on that ?
> 

Have to dig in history... Can you refresh my memories? The discussion
went nowhere after
https://xenomai.org/pipermail/xenomai/2020-February/042543.html.

Jan

> Le mer. 19 févr. 2020 à 13:13, Jan Kiszka <jan.kiszka@siemens.com
> <mailto:jan.kiszka@siemens.com>> a écrit :
> 
>     On 19.02.20 13:11, Antoine Hoarau wrote:
>     > Dohell does no seem to be included either. Is that normal ?
>     >
> 
>     It is, see /usr/lib/xenomai/testsuite/dohell.
> 
>     Jan
> 
>     > Le mer. 19 févr. 2020 à 12:35, Jan Kiszka <jan.kiszka@siemens.com
>     <mailto:jan.kiszka@siemens.com>
>     > <mailto:jan.kiszka@siemens.com <mailto:jan.kiszka@siemens.com>>> a
>     écrit :
>     >
>     >     On 19.02.20 09:54, Jan Kiszka via Xenomai wrote:
>     >      > On 18.02.20 18:45, Antoine Hoarau via Xenomai wrote:
>     >      >> Le mar. 18 févr. 2020 à 12:12, Gylstorff Quirin <
>     >      >> quirin.gylstorff@siemens.com
>     <mailto:quirin.gylstorff@siemens.com>
>     >     <mailto:quirin.gylstorff@siemens.com
>     <mailto:quirin.gylstorff@siemens.com>>> a écrit :
>     >      >>
>     >      >>> Hi Antoine,
>     >      >>>
>     >      >>> On 2/18/20 12:04 AM, Antoine Hoarau via Xenomai wrote:
>     >      >>>> # ldd /usr/lib/xenomai/testsuite/libalchemy-test.so
>     >      >>>>           linux-vdso.so.1 (0x00007fff1f944000)
>     >      >>>>           libcobalt.so.2 => /usr/lib/libcobalt.so.2
>     >      >>>> (0x00007f2a40bc9000)
>     >      >>>>           libalchemy.so.0 => /usr/lib/libalchemy.so.0
>     >      >>>> (0x00007f2a409b1000)
>     >      >>>>           libcopperplate.so.0 =>
>     /usr/lib/libcopperplate.so.0
>     >      >>>> (0x00007f2a407a3000)
>     >      >>>>           libc.so.6 => /lib/x86_64-linux-gnu/libc.so.6
>     >      >>> (0x00007f2a403b2000)
>     >      >>>>           librt.so.1 => /lib/x86_64-linux-gnu/librt.so.1
>     >      >>> (0x00007f2a401aa000)
>     >      >>>>           libpthread.so.0 =>
>     /lib/x86_64-linux-gnu/libpthread.so.0
>     >      >>>> (0x00007f2a3ff8b000)
>     >      >>>>           /lib64/ld-linux-x86-64.so.2 (0x00007f2a40ff4000)
>     >      >>>>
>     >      >>>>
>     >      >>>> For info I added --enable-dlopen-libs
>     >      >>>> As in
>     >     https://xenomai.org/pipermail/xenomai/2020-January/042306.html
>     <https://xenomai.org/pipermail/xenomai/2020-January/042306.html>
>     >      >>>>
>     >      >>>> Le lun. 17 févr. 2020 à 17:51, Jan Kiszka
>     >     <jan.kiszka@siemens.com <mailto:jan.kiszka@siemens.com>
>     <mailto:jan.kiszka@siemens.com <mailto:jan.kiszka@siemens.com>>> a
>     >      >>> écrit :
>     >      >>>>
>     >      >>>>> On 14.02.20 15:15, Antoine Hoarau wrote:
>     >      >>>>>> I just built the debians:
>     >      >>>>>> debchange -v 3.1 Release 3.1
>     >      >>>>>> debuild -uc -us
>     >      >>>>>>
>     >      >>>
>     >      >>> What is the Debian version and CPU architecture of your build
>     >     system?A
>     >      >>
>     >      >>
>     >      >> A very standard Ubuntu 18.04 x64.
>     >      >> Debuild version 2.17.12ubuntu1.1
>     >      >>
>     >      >
>     >      > Ah! That is surely untested as no one here is using Ubuntu
>     anymore.
>     >      > Will check if it's a generic or a Ubuntu-exposed issue.
>     >      >
>     >
>     >     I'm starting to understand the issue. It's likely related to
>     >     optimizations of library dependency done differently by the Ubuntu
>     >     toolchain than that of Debian 10. I think we can avoid that by
>     adding
>     >     all actual deps to our libs. Playing with it...
>     >
>     >     Jan
>     >
>     >     --
>     >     Siemens AG, Corporate Technology, CT RDA IOT SES-DE
>     >     Corporate Competence Center Embedded Linux
>     >
> 
>     -- 
>     Siemens AG, Corporate Technology, CT RDA IOT SES-DE
>     Corporate Competence Center Embedded Linux
> 


-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

