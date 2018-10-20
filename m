Date: Sat, 20 Oct 2018 19:27:13 +0000 (UTC)
From: Alec Ari <neotheuser@ymail.com>
Message-ID: <1521267485.13306337.1540063633073@mail.yahoo.com>
In-Reply-To: <d1c7004d-c205-4ee2-c8c6-fa39e9bf1583@siemens.com>
References: <0B8B4C90A6FEA34E9EA10570C016C358BB7D9D8A@DEMUC-SMX001.data-modul.local>
 <c371a628-edc2-0713-767b-80efac64833e@siemens.com>
 <0B8B4C90A6FEA34E9EA10570C016C358BB7DA2CC@DEMUC-SMX001.data-modul.local>
 <0c0a94e6-6650-88e2-7b89-3b6fa92efa65@siemens.com>
 <0B8B4C90A6FEA34E9EA10570C016C358BB7DA73C@DEMUC-SMX001.data-modul.local>
 <52b6df12-fbb5-871a-7c4c-5208e7e04978@siemens.com>
 <cuc1u0s6krjua13us78v6n9g.1539284434958@email.android.com>
 <0B8B4C90A6FEA34E9EA10570C016C358BB7DB540@DEMUC-SMX001.data-modul.local>
 <d1c7004d-c205-4ee2-c8c6-fa39e9bf1583@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] Cobolt core not enabled in kernel
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

Wanted to take a quick jab at wip/4.14-split -- kernel boots up fine:

[=C2=A0=C2=A0=C2=A0 0.000000] Interrupt pipeline (release #2112)

However when trying to do anything with Xenomai, I get this:

0"000.000| BUG in low_init(): [main] Cobalt core not enabled in kernel

Everything is set accordingly:

CONFIG_LOCALVERSION=3D"-IPIPE"
CONFIG_HAVE_IPIPE_SUPPORT=3Dy
CONFIG_IPIPE=3Dy
CONFIG_IPIPE_CORE=3Dy
CONFIG_IPIPE_WANT_PTE_PINNING=3Dy
CONFIG_IPIPE_CORE_APIREV=3D2
CONFIG_IPIPE_TARGET_APIREV=3D2
CONFIG_IPIPE_DEBUG=3Dy
CONFIG_IPIPE_DEBUG_CONTEXT=3Dy
CONFIG_IPIPE_DEBUG_INTERNAL=3Dy

Wanted debugging on so I can report back any problems with meaningful stack=
 traces.

Yes, I'm sure I'm running the correct kernel; this is definitely an IPIPE-e=
nabled 4.14 kernel. What am I missing?

$ git clone https://gitlab.denx.de/Xenomai/ipipe-x86.git
$ git clone https://gitlab.denx.de/Xenomai/xenomai.git
$ cd ipipe-x86 ; make menuconfig ; make ; copy stuff to /boot ; modify grub=
 ; reboot
$ cd xenomai ; ./scripts/bootstrap ; ./configure ; make ; make install ; no=
thing works, same error:

0"000.000| BUG in low_init(): [main] Cobalt core not enabled in kernel

Tried things in /usr/xenomai/bin{,demo} and ~/xenomai/testsuite and same pr=
oblem. Without me having to dig through enormous PDFs, source code and such=
, can you simply just tell me what I'm doing wrong?

Thank you!

Alec

