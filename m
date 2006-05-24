From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="n3/KqVxevN"
Content-Transfer-Encoding: 7bit
Message-ID: <17524.40722.711406.322672@domain.hid>
Date: Wed, 24 May 2006 19:59:46 +0200
Subject: Re: [Xenomai-help] Error compiling posix skin
In-Reply-To: <44743475.4070108@domain.hid>
References: <44743475.4070108@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Nicola Pace <nicola@domain.hid>
Cc: xenomai@xenomai.org


--n3/KqVxevN
Content-Type: text/plain; charset=us-ascii
Content-Description: message body and .signature
Content-Transfer-Encoding: 7bit

Nicola Pace wrote:
 > I am trying to compile xenomai.2.2-rc1, but compiling the posix skin I 
 > get the error :
 > 
 > /usr/src/xenomai-2.2-rc1/include/posix/time.h:103: parse error before 
 > 'clock_id'
 > 
 > Some Suggestions ?

Your libc is likely a bit old and does not define clockid_t, what
version of glibc are you using ? Could you try the attached patch ?
Maybe other definitions than clockid_t are missing, timer_t for
example.

-- 


					    Gilles Chanteperdrix.

--n3/KqVxevN
Content-Type: text/plain
Content-Disposition: inline;
	filename="xeno-posix-time-h.diff"
Content-Transfer-Encoding: 7bit

Index: include/posix/time.h
===================================================================
--- include/posix/time.h	(revision 1135)
+++ include/posix/time.h	(working copy)
@@ -48,6 +48,11 @@
 #define CLOCK_MONOTONIC 1
 #endif /* CLOCK_MONOTONIC */
 
+#ifndef __clockid_t_defined
+#define __clockid_t_defined 1
+typedef int clockid_t;
+#endif /* !__clockid_t_defined */
+
 #if defined(__KERNEL__) || defined(__XENO_SIM__)
 
 struct sigevent;

--n3/KqVxevN--

