From: =?iso-8859-1?Q?H=E4nel-Baas=2C_Alexander?=
 <alexander.haenel-baas@sieb-meyer.de>
Date: Tue, 8 Jul 2014 07:03:39 +0000
Message-ID: <9BA84827B30CBE4996725F98F7DC9123428DE4DA@SMExchange01.siebmeyer.org>
Content-Language: de-DE
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] Kernel 3.14 hal.c struct irq_desc has no member named chip
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hallo Xenomai users and developers,

I am try to compile Kernel 3.14 with Xenomai 2.6.3 and the ipipe-core-3.14-=
arm-1.patch for the
Freescale i.mx6 sabresd board.

I get the following error:

CC      mm/slab_common.o
arch/arm/xenomai/hal.c: In function 'rthal_irq_enable':
arch/arm/xenomai/hal.c:469:9: error: 'struct irq_desc' has no member named =
'chip'
arch/arm/xenomai/hal.c: In function 'rthal_irq_disable':
arch/arm/xenomai/hal.c:479:9: error: 'struct irq_desc' has no member named =
'chip'
make[2]: *** [arch/arm/xenomai/hal.o] Error 1

In the kernelconfig I have enabled -> Real-time sub-system/Interface/Native=
 API/Interrupts

In the past I have already compile the Kernel 3.10.18 with, Xenomai 2.6.3 a=
nd ipipe-core-3.10.18-arm-1.patch successful.
But I'm afraid the irq's don't work properly and so I check out the new ver=
sion.

Any ideas what is going wrong at the compile step?

With best regards,
Alexander H=E4nel-Baas


With best regards,
Alexander H=E4nel-Baas
