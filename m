From: Jan Kiszka <jan.kiszka@web.de>
Subject: [PATCH 1/3] testsuite/latency: Use corresponding pclose for popen
Date: Sat, 16 Oct 2021 20:31:23 +0200
Message-Id: <6fe6b75bef4b4bb9723b12f0e9ebfd9877e00a44.1634409085.git.jan.kiszka@web.de>
In-Reply-To: <cover.1634409085.git.jan.kiszka@web.de>
References: <cover.1634409085.git.jan.kiszka@web.de>
MIME-Version: 1.0
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

From: Jan Kiszka <jan.kiszka@siemens.com>

Was found by latest gcc-11 and -Werror=3Dmismatched-dealloc.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
=2D--
 testsuite/latency/latency.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testsuite/latency/latency.c b/testsuite/latency/latency.c
index a0e6f48260..6cd3a28b44 100644
=2D-- a/testsuite/latency/latency.c
+++ b/testsuite/latency/latency.c
@@ -412,7 +412,7 @@ static void dump_histo_gnuplot(int32_t *histogram, tim=
e_t duration)
 		fputs(buf, ofp);
 	}

-	fclose(ifp);
+	pclose(ifp);

 dump_data:
 	for (n =3D 0; n < histogram_size && histogram[n] =3D=3D 0; n++)
=2D-
2.31.1


