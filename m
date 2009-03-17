Message-ID: <49BFCAEB.8080007@domain.hid>
Date: Tue, 17 Mar 2009 17:08:11 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <004301c9a683$c6b00200$0109220a@domain.hid>	<004801c9a69a$4a63aaf0$0109220a@domain.hid>
	<49BFBF48.7080102@domain.hid>
In-Reply-To: <49BFBF48.7080102@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] ENXIO error with large shared memory
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Henry Bausley <hbausley@domain.hid>
Cc: xenomai@xenomai.org

Gilles Chanteperdrix wrote:
> Henry Bausley wrote:
>> ftruncate returns 0
> 
> Ok. I think I understood what the problem is, I will try to send a patch
> tonight.
> 

The following not very subtil patch seems to fix the issue:

Index: include/nucleus/heap.h
===================================================================
--- include/nucleus/heap.h      (revision 4692)
+++ include/nucleus/heap.h      (working copy)
@@ -156,6 +156,7 @@

 static inline size_t xnheap_rounded_size(size_t hsize, size_t psize)
 {
+       size_t rounded_size;
        /*
         * Account for the minimum heap size (i.e. 2 * page size) plus
         * overhead so that the actual heap space is large enough to
@@ -167,7 +168,10 @@
        if (hsize < 2 * psize)
                hsize = 2 * psize;
        hsize += xnheap_overhead(hsize, psize);
-       return xnheap_align(hsize, psize);
+       rounded_size = xnheap_align(hsize, psize);
+       while (rounded_size - xnheap_overhead(rounded_size, psize) < hsize)
+               rounded_size += psize;
+       return rounded_size;
 }

 #ifdef __cplusplus


-- 
                                                 Gilles.

