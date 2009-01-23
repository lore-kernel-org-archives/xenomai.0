Message-ID: <497A2344.8060605@domain.hid>
Date: Fri, 23 Jan 2009 21:06:28 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <51CAD0CE1504444DBE77CBBE51A0135D5908A3@domain.hid>
	<497A1963.8030902@domain.hid>
	<51CAD0CE1504444DBE77CBBE51A0135D5908A4@domain.hid>
	<497A1E95.4080805@domain.hid>
	<51CAD0CE1504444DBE77CBBE51A0135D5908A5@domain.hid>
In-Reply-To: <51CAD0CE1504444DBE77CBBE51A0135D5908A5@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] shadow task and rt_task_self()
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Steven Seeger <sseeger@domain.hid>
Cc: xenomai@xenomai.org

Steven Seeger wrote:
> Gilles,
> 
> Attached is my simple test that repeats this problem.
> 
> Output is:
> 
> 0
> 0 0
> 
> This is using latest xenomai trunk.
> 

Ok. Try this:

Index: src/skins/native/task.c
===================================================================
--- src/skins/native/task.c	(revision 4570)
+++ src/skins/native/task.c	(working copy)
@@ -210,8 +210,12 @@ int rt_task_shadow(RT_TASK *task, const
 	err = XENOMAI_SKINCALL2(__native_muxid, __native_task_create, &bulk,
 				NULL);

-	if (!err)
+	if (!err) {
+#ifdef HAVE___THREAD
+		__native_self = *task;
+#endif /* HAVE___THREAD */
 		xeno_set_current();
+	}

 	return err;
 }


-- 
					    Gilles.

