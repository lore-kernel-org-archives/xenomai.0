From: Josh Karch <jkarch@FirstMode.com>
Subject: xeno_can_mem (and other driver) IRQ issues with Zynq UltraScale
Date: Wed, 1 Jul 2020 15:15:20 +0000
Message-ID: <MN2PR19MB39679C9A623AB7AFBC312DE5D56C0@MN2PR19MB3967.namprd19.prod.outlook.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hello,

I just wanted to give a quick update on the xeno_can_mem issues.  It appear=
s for the Zynq UltraScale+ MPSoC that in order to register IRQs for use by =
Xenomai Drivers you first need to create a "generic-uio" entry in the devic=
e tree pointing to the device's PL (programmable logic) interrupt.  This wi=
ll reserve the IRQ in Linux based on the mapping from whatever interrupt co=
ntroller is being used.  At that point you can then modprobe the Xenomai dr=
iver.  I was receiving faults trying to directly register the interrupt lin=
e (#121 for example).

Best,


Josh Karch

