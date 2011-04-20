Message-ID: <4DAF2177.1000707@domain.hid>
Date: Wed, 20 Apr 2011 20:09:59 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [PULL] vfile: Fix NULL pointer exception on shapshot
	restarts
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Xenomai core <Xenomai-core@domain.hid>

The following changes since commit cf683ac01817bb19ae5429df4ca9e0e57d78b5b1:

  arm: clean-up context switch (2011-04-16 12:47:50 +0200)

are available in the git repository at:
  git://git.xenomai.org/xenomai-jki.git for-upstream

Jan Kiszka (1):
      vfile: Fix NULL pointer exception on shapshot restarts

 ksrc/nucleus/vfile.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

---

vfile: Fix NULL pointer exception on shapshot restarts

it->endfn is only accessed if if->databuf is non-NULL. But we are
writing endfn on every snapshot restart. If ops->end is NULL but databuf
was set during a previous run, calling endfd will oops.

Fix it by only setting endfn when databuf is initialized.

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---
 ksrc/nucleus/vfile.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/ksrc/nucleus/vfile.c b/ksrc/nucleus/vfile.c
index c553480..d8ac398 100644
--- a/ksrc/nucleus/vfile.c
+++ b/ksrc/nucleus/vfile.c
@@ -205,7 +205,6 @@ redo:
 	 * a NULL return from ->rewind() tells us that the vfile won't
 	 * output any snapshot data via ->show().
 	 */
-	it->endfn = ops->end;
 	nrdata = 0;
 	if (ops->rewind) {
 		nrdata = ops->rewind(it);
@@ -239,8 +238,10 @@ redo:
 			kfree(it);
 			return -ENOMEM;
 		}
-		if (data != VFILE_SEQ_EMPTY)
+		if (data != VFILE_SEQ_EMPTY) {
 			it->databuf = data;
+			it->endfn = ops->end;
+		}
 	} else if (nrdata > 0 && vfile->datasz > 0) {
 		/* We have a hint for auto-allocation. */
 		data = kmalloc(vfile->datasz * nrdata, GFP_KERNEL);
-- 
1.7.1

