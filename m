From: Wolfgang Denk <wd@denx.de>
Subject: Re: [CXP][RFC] pick POSIX/cobalt for the common user API
MIME-Version: 1.0
Content-type: text/plain; charset=UTF-8
Content-transfer-encoding: 8bit
In-reply-to: <87mtyr1abi.fsf@xenomai.org>
References: <87mtyr1abi.fsf@xenomai.org>
Date: Mon, 14 Dec 2020 08:22:29 +0100
Message-ID: <438826.1607930549@gemini.denx.de>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, Philippe Gerum via Xenomai <xenomai@xenomai.org>

Dear Philippe,

In message <87mtyr1abi.fsf@xenomai.org> you wrote:
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

Sonds good to me - ACK!

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
"...all the  good  computer  designs  are  bootlegged;  the  formally
planned  products,  if  they  are built at all, are dogs!" - David E.
Lundstrom, "A Few Good Men From Univac", MIT Press, 1987

