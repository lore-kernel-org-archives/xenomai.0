From: Jan Leupold <leupold@rsi-elektrotechnik.de>
Date: Wed,  7 Dec 2016 13:39:41 +0100
Message-Id: <1481114381-17548-1-git-send-email-leupold@rsi-elektrotechnik.de>
Subject: [Xenomai] [PATCH] analogy: fix __a4l_get_sbsize() if device has
	only one subdevice
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

All a4l_sbinfo_t are handled in __a4l_fill_desc() as a contiguous array
and is stored as data in a4l_root_t. The old code allocated enough
memory when the device had at least two subdevices, but missed 8 bytes
(on ARM32), which is the difference between sizeof(a4l_root_t) and
sizeof(a4l_leaf_t).
---
 lib/analogy/descriptor.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/analogy/descriptor.c b/lib/analogy/descriptor.c
index bc4d7bd..fa8cf93 100644
--- a/lib/analogy/descriptor.c
+++ b/lib/analogy/descriptor.c
@@ -100,8 +100,9 @@ static inline a4l_leaf_t *a4l_leaf_get(a4l_leaf_t * lf,
 static int __a4l_get_sbsize(int fd, a4l_desc_t * dsc)
 {
 	unsigned int i, j, nb_chan, nb_rng;
+	/* all subdevice a4l_sbinfo_t are within one special leaf: the root */
 	int ret, res =
-		dsc->nb_subd * (sizeof(a4l_sbinfo_t) + sizeof(a4l_leaf_t));
+		sizeof(a4l_root_t) + dsc->nb_subd * (sizeof(a4l_sbinfo_t));
 
 	for (i = 0; i < dsc->nb_subd; i++) {
 
-- 
1.9.1


-- 
_____________________________________________________________
R-S-I Elektrotechnik GmbH & Co. KG
Woelkestrasse 11
D-85301 Schweitenkirchen
Fon: +49 8444 9204-0
Fax: +49 8444 9204-50
www.rsi-elektrotechnik.de

_____________________________________________________________
Amtsgericht Ingolstadt - GmbH: HRB 191328 - KG: HRA 170363
Gesch���ftsf���hrer: Dr.-Ing. Michael Sorg, Dipl.-Ing. Franz Sorg
USt-IdNr.: DE 128592548


