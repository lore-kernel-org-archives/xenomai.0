Subject: Re: [CXP][RFC] pick POSIX/cobalt for the common user API
References: <87mtyr1abi.fsf@xenomai.org>
From: chensong <chensong@tj.kylinos.cn>
Message-ID: <5FCD907C.6040309@tj.kylinos.cn>+BA6FC9DAC615AEA6
Date: Mon, 7 Dec 2020 10:16:28 +0800
MIME-Version: 1.0
In-Reply-To: <87mtyr1abi.fsf@xenomai.org>
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
To: xenomai@xenomai.org

hi Philippe,

As far as i know, some vxworks customers like xenomai because they can 
move their RT processes from vxworks to linux without rewriting their 
code by the help of vxworks skin.

If we "Excluding the legacy RTOS emulators such as VxWorks", we will 
lose them. It could depend on the balance of the request and effort.

BR

song

On 2020年12月06日 18:46, Philippe Gerum via Xenomai wrote:
>
> The common Xenomai platform specification is about defining the
> commonalities among future Xenomai releases starting from 3.3, including
> the Xenomai 4 series based on a next generation (EVL) core. A common API
> available to applications for issuing requests to the real-time core is
> part of this specification.
>
> Implementing such interface would not preclude other APIs from
> co-existing in particular releases. However, use of this common API
> only would guarantee portability across releases.
>
> Excluding the legacy RTOS emulators such as VxWorks and pSOS, Xenomai
> 3.x provides two main APIs, a POSIX-compliant one (libcobalt) and a
> custom RTOS API aka Alchemy (libalchemy) on top of the Copperplate
> interface.
>
> PROPOSAL: Pick libcobalt as the common API defined by the CXP.
>
> As a consequence, Xenomai 4 would provide two direct interfaces to the
> underlying EVL core: via the libevl API [1] which is readily
> available, and its own implementation of libcobalt as part of a CXP
> compliance.
>
>                    applications
>        ....................................
>        libalchemy            libevl libcobalt
>             |                  |      |
>             |                  |      |
>        libcopperplate          |      |
>             |                  |      |
>             |                  |      |
>         libcobalt              |      |
>             |                  |      |
>             v                  v      v
>       (Cobalt core)           (EVL core)
>        -----------            ---------
>        Xenomai 3.x            Xenomai 4
>
>
> Thanks,
>
> [1] https://evlproject.org/core/user-api/
>

