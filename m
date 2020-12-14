Subject: Re: [CXP][RFC] pick POSIX/cobalt for the common user API
References: <87mtyr1abi.fsf@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <3a59871e-0051-de96-6346-2f7af74c3e80@siemens.com>
Date: Mon, 14 Dec 2020 13:44:15 +0100
MIME-Version: 1.0
In-Reply-To: <87mtyr1abi.fsf@xenomai.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, xenomai@xenomai.org

On 06.12.20 11:46, Philippe Gerum via Xenomai wrote:
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
>                   applications
>       ....................................
>       libalchemy            libevl libcobalt
>            |                  |      |
>            |                  |      |
>       libcopperplate          |      |
>            |                  |      |
>            |                  |      |
>        libcobalt              |      |
>            |                  |      |
>            v                  v      v
>      (Cobalt core)           (EVL core)
>       -----------            ---------
>       Xenomai 3.x            Xenomai 4
> 
> 
> Thanks,
> 
> [1] https://evlproject.org/core/user-api/
> 

Ack from my side.

Besides using Xenomai 3.x as a stepping stone to migrate from legacy
RTOSes like Vxworks, there may also be the option to use the mercurial
version on top of Xenomai 4 at some point. In any case, it will first of
all take users to actively express their long-term needs regarding such
features - and contributions.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

