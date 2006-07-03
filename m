MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="VmSy/PubkQ"
Content-Transfer-Encoding: 7bit
Message-ID: <17577.6249.88197.452730@domain.hid>
Date: Mon, 3 Jul 2006 15:15:21 +0200
Subject: RE: [Xenomai-help] pthread_mutex_destroy in 2.2 rc2
In-Reply-To: <02AA386EB831044F8537A696BA785C78A66770@domain.hid>
References: <02AA386EB831044F8537A696BA785C78A66770@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Landau, Bracha" <BLandau@domain.hid>
Cc: xenomai@xenomai.org


--VmSy/PubkQ
Content-Type: text/plain; charset=us-ascii
Content-Description: message body and .signature
Content-Transfer-Encoding: 7bit

Landau, Bracha wrote:
 > As you suggested, I've upgraded to xenomai 2.2 rc3.
 > I still see the same phenomenon.
 > I'm attaching code that will reproduce the error.
 > (When you ^c out of the main loop, the pthread_cleanup_pop is called, and the call to pthread_mutex_destroy returns 0x10.)

Thanks for the piece of code. The error was due to a missing
initialization, that got unseen under simulation because simulator
allocated memory was always zero. It is now fixed in the repository. You
can apply the attached patch to 2.2 rc3 to fix it.

-- 


					    Gilles Chanteperdrix.

--VmSy/PubkQ
Content-Type: text/plain
Content-Disposition: inline;
	filename="xeno-posix-mutex-c.diff"
Content-Transfer-Encoding: 7bit

Index: ksrc/skins/posix/mutex.c
===================================================================
--- ksrc/skins/posix/mutex.c	(revision 1288)
+++ ksrc/skins/posix/mutex.c	(revision 1289)
@@ -132,6 +132,7 @@
 	inith(&mutex->link);
 	mutex->attr = *attr;
 	mutex->count = 0;
+	mutex->condvars = 0;
 
 	appendq(mutexq, &mutex->link);
 

--VmSy/PubkQ--

