From: Giulio Moro <g.moro@qmul.ac.uk>
Subject: Re: include/boilerplate/compiler.h breaks clang 3.9's arm_acle.h
Date: Mon, 19 Nov 2018 11:59:05 +0000
Message-ID: <VI1PR0701MB2126E2FCB190BCE61C77329CB5D80@VI1PR0701MB2126.eurprd07.prod.outlook.com>
References: <VI1PR0701MB21264AF72FDA99A8694C2E6AB5DE0@VI1PR0701MB2126.eurprd07.prod.outlook.com>,
 <d0e4aced-93eb-1e3c-ed39-7b406df3ee53@siemens.com>
In-Reply-To: <d0e4aced-93eb-1e3c-ed39-7b406df3ee53@siemens.com>
Content-Language: en-GB
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

right, digging deeper into the issue, ARM says that if the __ARM_ACLE macro=
 is defined by the compiler, then it's safer to include `arm_acle.h`, which=
 will define __clz() as a function, so a better approach could be perhaps:

#ifdef __ARM_ACLE
#include <arm_acle.h>
#else
#define __clz(__v)    \
      // .... currently defined code
#endif

Happy to prepare a patch for the above. On the other hand, I am not sure wh=
at the current purpose of this definition of __clz() in a public header fil=
e is:=20

$ grep -RI __clz .
./lib/copperplate/heapobj-pshared.c:		log2size =3D sizeof(size) * 8 - 1 - _=
_clz(size);
./include/boilerplate/compiler.h:#define __clz(__v)

so it's used only in lib/copperplate/heapobj-pshared.c (similarly for __ctz=
()) . Even if they was used in multiple places, why should they be defined =
in a public header, risking to cause issues when user code includes stdlib.=
h?

It seems to me that we can safely remove=20
#include <boilerplate/compiler.h>

from include/cobalt/wrappers.h in order to fix the above issue for the Coba=
lt API. Possibly something similar can be done for the other APIs?

Giulio

