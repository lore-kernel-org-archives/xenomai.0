Message-ID: <4B9A6633.9030806@domain.hid>
Date: Fri, 12 Mar 2010 17:05:07 +0100
From: Daniele Nicolodi <daniele@domain.hid>
MIME-Version: 1.0
References: <4B990EF1.1000400@domain.hid> <4B9985C3.4060100@domain.hid>
In-Reply-To: <4B9985C3.4060100@domain.hid>
Content-Type: multipart/mixed; boundary="------------070300070902060707030505"
Subject: Re: [Xenomai-core] [Xenomai-help] Experimenting with Analogy. Bugs
 found?
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

This is a multi-part message in MIME format.
--------------070300070902060707030505
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Daniele Nicolodi wrote:
>> 2. Looks like it is not possible to setup an endless acquisition. If I
>> set .stop_src = TRIG_NONE and .stop_arg = 0, the command submission goes
>> fine, but I obtain an ENOENT error at the first a4l_sys_read(). I have
>> no idea on where to look to track down this issue.

The attached patch (against Alex git three) fixes the problem, in the
case of analog input. I haven't test the same condition for analog output.

Cheers,
-- 
Daniele


--------------070300070902060707030505
Content-Type: text/x-diff;
 name="analogy01.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="analogy01.patch"

diff --git a/include/analogy/buffer.h b/include/analogy/buffer.h
index 0e8f279..e7b2416 100644
--- a/include/analogy/buffer.h
+++ b/include/analogy/buffer.h
@@ -253,7 +253,8 @@ static inline int __abs_put(a4l_buf_t * buf, unsigned long count)
 	if ((old / buf->size) != (count / buf->size))
 		set_bit(A4L_BUF_EOBUF_NR, &buf->evt_flags);
 
-	if (count >= buf->end_count)
+	/* In the case of continuos acquisition end_count is zero */
+	if ((buf->end_count != 0) && (count >= buf->end_count))
 		set_bit(A4L_BUF_EOA_NR, &buf->evt_flags);
 
 	return 0;
@@ -303,10 +304,15 @@ static inline unsigned long __count_to_get(a4l_buf_t * buf)
 {
 	unsigned long ret;
 
-	if (buf->end_count != 0 && (buf->end_count > buf->prd_count))
+	/* In the case of continuos acquisition end_count is zero */
+	if (buf->end_count != 0) {
+		if (buf->end_count > buf->prd_count)
+			ret = buf->prd_count;
+		else
+			ret = buf->end_count;
+	} else {
 		ret = buf->prd_count;
-	else
-		ret = buf->end_count;
+	}
 
 	if (ret > buf->cns_count)
 		ret -= buf->cns_count;

--------------070300070902060707030505--

