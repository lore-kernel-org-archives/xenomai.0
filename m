From: Richard Weinberger <richard@nod.at>
Subject: [PATCH 5/6] alchemytests: Fix gcc warning in buffer-1
Date: Fri,  8 Apr 2022 10:04:00 +0200
Message-Id: <20220408080401.22235-6-richard@nod.at>
In-Reply-To: <20220408080401.22235-1-richard@nod.at>
References: <20220408080401.22235-1-richard@nod.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Cc: Richard Weinberger <richard@nod.at>

Make n an unsigned integer, such that gcc realizes that "%.2d" cannot
become negative and will fit into our 3 bytes buffer.

Fixes:
buffer-1.c:64:15: error: =E2=80=98%.2d=E2=80=99 directive writing between=
 2 and 10 bytes into a region of size 3 [-Werror=3Dformat-overflow=3D]
   sprintf(s, "%.2d", 11 * n);
               ^~~~

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 testsuite/alchemytests/buffer-1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testsuite/alchemytests/buffer-1.c b/testsuite/alchemytests/b=
uffer-1.c
index d6d1d9ad7..807db1dcf 100644
--- a/testsuite/alchemytests/buffer-1.c
+++ b/testsuite/alchemytests/buffer-1.c
@@ -49,7 +49,7 @@ static void background_task(void *arg)
 {
 	char c =3D 'A', s[3];
 	ssize_t ret;
-	int n =3D 0;
+	unsigned int n =3D 0;
=20
 	traceobj_enter(&trobj);
=20
--=20
2.34.1


