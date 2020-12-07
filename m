Subject: Re: [CXP][RFC] pick POSIX/cobalt for the common user API
References: <87mtyr1abi.fsf@xenomai.org>
 <5fcd902b.1c69fb81.79300.444fSMTPIN_ADDED_BROKEN@mx.google.com>
 <CALLqZ8TZkVBO4=AQD=0SKA_uJ++NJ8+dCW81scEeCs4UmcSBnA@mail.gmail.com>
From: chensong <chensong@tj.kylinos.cn>
Message-ID: <5FCDE329.7050509@tj.kylinos.cn>+9C37279B2F69FACE
Date: Mon, 7 Dec 2020 16:09:13 +0800
MIME-Version: 1.0
In-Reply-To: <CALLqZ8TZkVBO4=AQD=0SKA_uJ++NJ8+dCW81scEeCs4UmcSBnA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Greg Gallagher <greg@embeddedgreg.com>
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>



On 2020年12月07日 14:59, Greg Gallagher wrote:
>
>
> On Sun, Dec 6, 2020 at 9:15 PM chensong via Xenomai <xenomai@xenomai.org
> <mailto:xenomai@xenomai.org>> wrote:
>
>     hi Philippe,
>
>     As far as i know, some vxworks customers like xenomai because they can
>     move their RT processes from vxworks to linux without rewriting their
>     code by the help of vxworks skin.
>
> These are legacy vxworks applications?

yes, legacy vxworks apps, i heard of that from marketing guys, they are 
trying to move to linux, xenomai is a perfect alternative in this case.

i was also asked to write a demo with vxworks skin.

>
>     If we "Excluding the legacy RTOS emulators such as VxWorks", we will
>     lose them. It could depend on the balance of the request and effort.
>
> It might make sense to only support the vxworks skin, would any of these
> users be willing to help with support?
>
i'm not sure, we can talk about it when we get that place, either users 
or i can apply resources in our R&D.

song

> -Greg
>
>
>     BR
>
>     song
>
>     On 2020年12月06日 18:46, Philippe Gerum via Xenomai wrote:
>      >
>      > The common Xenomai platform specification is about defining the
>      > commonalities among future Xenomai releases starting from 3.3,
>     including
>      > the Xenomai 4 series based on a next generation (EVL) core. A
>     common API
>      > available to applications for issuing requests to the real-time
>     core is
>      > part of this specification.
>      >
>      > Implementing such interface would not preclude other APIs from
>      > co-existing in particular releases. However, use of this common API
>      > only would guarantee portability > Excluding the legacy RTOS
>     emulators such as VxWorks and pSOS, Xenomai
>      > 3.x provides two main APIs, a POSIX-compliant one (libcobalt) and a
>      > custom RTOS API aka Alchemy (libalchemy) on top of the Copperplate
>      > interface.
>      >
>      > PROPOSAL: Pick libcobalt as the common API defined by the CXP.
>      >
>      > As a consequence, Xenomai 4 would provide two direct interfaces
>     to the
>      > underlying EVL core: via the libevl API [1] which is readily
>      > available, and its own implementation of libcobalt as part of a CXP
>      > compliance.
>      >
>      >                    applications
>      >        ....................................
>      >        libalchemy            libevl libcobalt
>      >             |                  |      |
>      >             |                  |      |
>      >        libcopperplate          |      |
>      >             |                  |      |
>      >             |                  |      |
>      >         libcobalt              |      |
>      >             |                  |      |
>      >             v                  v      v
>      >       (Cobalt core)           (EVL core)
>      >        -----------            ---------
>      >        Xenomai 3.x            Xenomai 4
>      >
>      >
>      > Thanks,
>      >
>      > [1] https://evlproject.org/core/user-api/
>      >
>



