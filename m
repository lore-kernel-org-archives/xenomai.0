MIME-Version: 1.0
From: =?UTF-8?B?TWF0w7rFoSBPbGVrxaHDoWs=?= <oleksak.matus@gmail.com>
Date: Wed, 19 Feb 2020 19:59:37 +0100
Message-ID: <CAG6b3Eos-mVCQHyHVh6Vr=4xr+ud_t+EsvW8o939i6MpJbcC6Q@mail.gmail.com>
Subject: [PATCH] Fixed long size in UDP port bitmap index
Content-Type: text/plain; charset="UTF-8"
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

Hello,
I am posting once again this patch. Now it is according CONTRIBUTING.md.
There is issue when you are using 64bit Linux and increasing RT_UDP_SOCKETS
above 64, because on 64 bit Linux long has 64 bits instead of hardcoded 32
bits. This patch fixes the situation on both 32 and 64 bit OS.

Signed-off-by: Mat=C3=BA=C5=A1 Olek=C5=A1=C3=A1k <oleksak.matus@gmail.com>
---
kernel/drivers/net/stack/ipv4/udp/udp.c | 2 +-
1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/drivers/net/stack/ipv4/udp/udp.c
b/kernel/drivers/net/stack/ipv4/udp/udp.c
index 5e3679780..c26b4bd81 100644
--- a/kernel/drivers/net/stack/ipv4/udp/udp.c
+++ b/kernel/drivers/net/stack/ipv4/udp/udp.c
@@ -301,7 +301,7 @@ int rt_udp_socket(struct rtdm_fd *fd)
                       break;
       index =3D ffz(port_bitmap[i]);
       set_bit(index, &port_bitmap[i]);
-       index +=3D i * 32;
+       index +=3D i * BITS_PER_LONG;
       sock->prot.inet.reg_index =3D index;
       sock->prot.inet.sport =3D index + auto_port_start;

--
2.25.1
