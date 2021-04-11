Subject: [PATCH 5/4] drivers/net/experimental/e1000: Annotate valid
 fall-through cases
References: <cover.1618127660.git.jan.kiszka@web.de>
From: Jan Kiszka <jan.kiszka@web.de>
Message-ID: <c4e3494d-0125-630a-950f-a652d2c44385@web.de>
Date: Sun, 11 Apr 2021 10:51:04 +0200
MIME-Version: 1.0
In-Reply-To: <cover.1618127660.git.jan.kiszka@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@web.de>, xenomai@xenomai.org

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
=2D--
 kernel/drivers/net/drivers/experimental/e1000/e1000_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/drivers/net/drivers/experimental/e1000/e1000_main.c b/=
kernel/drivers/net/drivers/experimental/e1000/e1000_main.c
index 443a9f55b9..c9751c1ddc 100644
=2D-- a/kernel/drivers/net/drivers/experimental/e1000/e1000_main.c
+++ b/kernel/drivers/net/drivers/experimental/e1000/e1000_main.c
@@ -2396,9 +2396,11 @@ static void e1000_setup_rctl(struct e1000_adapter *=
adapter)
 		case 3:
 			psrctl |=3D PAGE_SIZE <<
 				E1000_PSRCTL_BSIZE3_SHIFT;
+			/* fall through */
 		case 2:
 			psrctl |=3D PAGE_SIZE <<
 				E1000_PSRCTL_BSIZE2_SHIFT;
+			/* fall through */
 		case 1:
 			psrctl |=3D PAGE_SIZE >>
 				E1000_PSRCTL_BSIZE1_SHIFT;
=2D-
2.26.2

