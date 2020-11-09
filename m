From: =?utf-8?q?Fran=C3=A7ois_Legal?= <devel@thom.fr.eu.org>
MIME-Version: 1.0
Date: Mon, 09 Nov 2020 21:26:08 +0100
Subject: RTNET and rtskb size
Message-ID: <1174-5fa9a600-5b-37e14c00@74917988>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello list,

I'm working on a project with a custom MAC which is using up to 2048 et=
hernet frame length.
Lately, I was having weird crash in RX interrupt code, or even sometime=
s in RTNET packet dispatch logic.
It turned out that while rt=5Falloc=5Fetherdev () requests the number o=
f rtskb to allocate in the device pool (and with associated packet buff=
ers of RTSKB=5FSIZE bytes), rtnetdev=5Falloc=5Frtskb (that is usually c=
alled after one packet is received to allocate a new rtskb for another =
packet to be received) takes a size parameter, and uses this as the rts=
kb buffer actual length whereas RTSKB=5FSIZE only is allocated.
Because of this, I believe I might be having the MAC overwriting rtskbs=
 that are being used.

I was wondering if it would not be a good thing to either make rtnetdev=
=5Falloc=5Frtskb check size against RTSKB=5FSIZE or even discard size p=
arameters, or maybe add a new rt=5Falloc=5Fetherdev function which woul=
d allow passing the max frame length.

Any thoughs on this ?

Fran=C3=A7ois


