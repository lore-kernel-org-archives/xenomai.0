Message-ID: <4BB10B38.30806@domain.hid>
Date: Mon, 29 Mar 2010 22:19:04 +0200
From: Daniele Nicolodi <daniele@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------000203080103070302010406"
Subject: [Xenomai-core] Analogy: improve a4l_find_range()
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>, Alexis Berlemont <alexis.berlemont@domain.hid>

This is a multi-part message in MIME format.
--------------000203080103070302010406
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hello Alexis, I wrote a small patch to improve a4l_find_range().

As many every other functions expect to have the range specified as its
idx into the struct describing the subdevice it is useful have it
returned from a4l_find_range(). I also made returning a pointer to the
range struncture optional.

I also attache a simple patch to clean up trailing whitespaces in the
range.c file.

Cheers,
-- 
Daniele

--------------000203080103070302010406
Content-Type: text/x-diff;
 name="analogy-range.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="analogy-range.patch"

commit ec80d59f5ecfdc74b45d9da7edfdb54f6cab555a
Author: Daniele Nicolodi <nicolodi@domain.hid>
Date:   Mon Mar 29 22:11:44 2010 +0200

    Make a4l_find_range() more useful by returning the idx of the most suitable range too.

diff --git a/src/drvlib/analogy/range.c b/src/drvlib/analogy/range.c
index 934c52a..fc4e302 100644
--- a/src/drvlib/analogy/range.c
+++ b/src/drvlib/analogy/range.c
@@ -154,8 +154,9 @@ int a4l_sizeof_subd(a4l_sbinfo_t *subd)
  * @param[in] max Maximal limit value
  * @param[out] rng Found range
  *
- * @return 0 on success. Otherwise:
+ * @return The index of the most suitable range on success. Otherwise:
  *
+ * - -ENOENT is returned if a suitable range is not found.
  * - -EINVAL is returned if some argument is missing or wrong;
  *    idx_subd, idx_chan and the dsc pointer should be checked; check
  *    also the kernel log ("dmesg"); WARNING: a4l_fill_desc() should
@@ -171,10 +172,14 @@ int a4l_find_range(a4l_desc_t * dsc,
 	int i, ret;
 	long lmin, lmax;
 	a4l_chinfo_t *chinfo;
-	a4l_rnginfo_t *rnginfo;
+	a4l_rnginfo_t *rnginfo, *tmp = NULL;
+	unsigned int idx_rng = -ENOENT;
+
+	if (rng != NULL)
+		*rng = NULL;
 
 	/* Basic checkings */
-	if (dsc == NULL || rng == NULL)
+	if (dsc == NULL)
 		return -EINVAL;
 
 	/* a4l_fill_desc() must have been called on this descriptor */
@@ -184,38 +189,39 @@ int a4l_find_range(a4l_desc_t * dsc,
 	/* Retrieves the ranges count */
 	ret = a4l_get_chinfo(dsc, idx_subd, idx_chan, &chinfo);
 	if (ret < 0)
-		goto out_get_range;
+		return ret;
 
 	/* Initializes variables */
 	lmin = (long)(min * A4L_RNG_FACTOR);
 	lmax = (long)(max * A4L_RNG_FACTOR);
-	*rng = NULL;
 
 	/* Performs the research */
 	for (i = 0; i < chinfo->nb_rng; i++) {
 
 		ret = a4l_get_rnginfo(dsc, idx_subd, idx_chan, i, &rnginfo);
 		if (ret < 0)
-			goto out_get_range;
+			return ret;
 
 		if (A4L_RNG_UNIT(rnginfo->flags) == unit &&
 		    rnginfo->min <= lmin && rnginfo->max >= lmax) {
 
-			if (*rng != NULL) {
-				if (rnginfo->min >= (*rng)->min &&
-				    rnginfo->max <= (*rng)->max)
-					*rng = rnginfo;
-			} else
-				*rng = rnginfo;
+			if (tmp != NULL) {
+				if (rnginfo->min >= tmp->min &&
+				    rnginfo->max <= tmp->max) {
+					idx_rng = i;
+					tmp = rnginfo;
+				}
+			} else {
+				idx_rng = i;
+				tmp = rnginfo;
+			}
 		}
 	}
 
-out_get_range:
-
-	if (ret < 0)
-		*rng = NULL;
+	if (rng != NULL)
+		*rng = tmp;
 
-	return ret;
+	return idx_rng;
 }
 
 /**

--------------000203080103070302010406
Content-Type: text/x-diff;
 name="analogy-whitespace.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="analogy-whitespace.patch"

commit 10dca3a6ae97cff6b2ebf9cf595283ffac94af44
Author: Daniele Nicolodi <nicolodi@domain.hid>
Date:   Mon Mar 29 22:13:03 2010 +0200

    Remove trailing white spaces.

diff --git a/src/drvlib/analogy/range.c b/src/drvlib/analogy/range.c
index fc4e302..51b0405 100644
--- a/src/drvlib/analogy/range.c
+++ b/src/drvlib/analogy/range.c
@@ -130,7 +130,7 @@ int a4l_sizeof_subd(a4l_sbinfo_t *subd)
 	   channels are acquired in one shot); for other kind of
 	   subdevice, the user must use a4l_sizeof_chan() so as to
 	   find out the size of the channel he wants to use */
-	if ((subd->flags & A4L_SUBD_TYPES) != A4L_SUBD_DIO && 
+	if ((subd->flags & A4L_SUBD_TYPES) != A4L_SUBD_DIO &&
 	    (subd->flags & A4L_SUBD_TYPES) != A4L_SUBD_DI &&
 	    (subd->flags & A4L_SUBD_TYPES) != A4L_SUBD_DO)
 		return -EINVAL;
@@ -233,7 +233,7 @@ int a4l_find_range(a4l_desc_t * dsc,
  *
  * @param[in] chan Channel descriptor
  * @param[in] rng Range descriptor
- * @param[out] dst Ouput buffer 
+ * @param[out] dst Ouput buffer
  * @param[in] src Input buffer
  * @param[in] cnt Count of transfer to copy
  *
@@ -257,7 +257,7 @@ int a4l_rawtoul(a4l_chinfo_t * chan, unsigned long *dst, void *src, int cnt)
 	if (chan == NULL)
 		return -EINVAL;
 
-	/* Find out the size in memory */ 
+	/* Find out the size in memory */
 	size = a4l_sizeof_chan(chan);
 
 	/* Get the suitable accessor */
@@ -285,7 +285,7 @@ int a4l_rawtoul(a4l_chinfo_t * chan, unsigned long *dst, void *src, int cnt)
 		j++;
 	}
 
-	return j;	
+	return j;
 }
 
 /**
@@ -293,7 +293,7 @@ int a4l_rawtoul(a4l_chinfo_t * chan, unsigned long *dst, void *src, int cnt)
  *
  * @param[in] chan Channel descriptor
  * @param[in] rng Range descriptor
- * @param[out] dst Ouput buffer 
+ * @param[out] dst Ouput buffer
  * @param[in] src Input buffer
  * @param[in] cnt Count of conversion to perform
  *
@@ -322,7 +322,7 @@ int a4l_rawtof(a4l_chinfo_t * chan,
 	if (rng == NULL || chan == NULL)
 		return -EINVAL;
 
-	/* Find out the size in memory */ 
+	/* Find out the size in memory */
 	size = a4l_sizeof_chan(chan);
 
 	/* Get the suitable accessor */
@@ -366,7 +366,7 @@ int a4l_rawtof(a4l_chinfo_t * chan,
  *
  * @param[in] chan Channel descriptor
  * @param[in] rng Range descriptor
- * @param[out] dst Ouput buffer 
+ * @param[out] dst Ouput buffer
  * @param[in] src Input buffer
  * @param[in] cnt Count of conversion to perform
  *
@@ -395,7 +395,7 @@ int a4l_rawtod(a4l_chinfo_t * chan,
 	if (rng == NULL || chan == NULL)
 		return -EINVAL;
 
-	/* Find out the size in memory */ 
+	/* Find out the size in memory */
 	size = a4l_sizeof_chan(chan);
 
 	/* Get the suitable accessor */
@@ -443,7 +443,7 @@ int a4l_rawtod(a4l_chinfo_t * chan,
  *
  * @param[in] chan Channel descriptor
  * @param[in] rng Range descriptor
- * @param[out] dst Ouput buffer 
+ * @param[out] dst Ouput buffer
  * @param[in] src Input buffer
  * @param[in] cnt Count of transfer to copy
  *
@@ -495,7 +495,7 @@ int a4l_ultoraw(a4l_chinfo_t * chan, void *dst, unsigned long *src, int cnt)
 		j++;
 	}
 
-	return j;	
+	return j;
 }
 
 /**
@@ -503,7 +503,7 @@ int a4l_ultoraw(a4l_chinfo_t * chan, void *dst, unsigned long *src, int cnt)
  *
  * @param[in] chan Channel descriptor
  * @param[in] rng Range descriptor
- * @param[out] dst Ouput buffer 
+ * @param[out] dst Ouput buffer
  * @param[in] src Input buffer
  * @param[in] cnt Count of conversion to perform
  *
@@ -573,7 +573,7 @@ int a4l_ftoraw(a4l_chinfo_t * chan,
  *
  * @param[in] chan Channel descriptor
  * @param[in] rng Range descriptor
- * @param[out] dst Ouput buffer 
+ * @param[out] dst Ouput buffer
  * @param[in] src Input buffer
  * @param[in] cnt Count of conversion to perform
  *

--------------000203080103070302010406--

