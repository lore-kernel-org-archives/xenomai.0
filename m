Message-ID: <47FF704F.8040708@domain.hid>
Date: Fri, 11 Apr 2008 16:06:07 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <47FF5EB9.9070605@domain.hid>
	<18431.26441.771360.551180@domain.hid>
In-Reply-To: <18431.26441.771360.551180@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH] Fix tiny memory leaks around
	rt_task_self()
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai-core@domain.hid

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>  > Nothing critical, but when using rt_task_self != NULL as a hint if the
>  > caller is Xenomai-mapped or not, this stall malloc can become at least
>  > unpleasant. This is also material for stable.
> 
> This looks useless: TSD cleanup routines are automatically called
> upon thread termination. It is even worse: you risk a double free if you
> do not re-set pthread_setspecific after having called free.

Ah, I missed the already existing cleanup in init.c. Then we are done
with this patch:

Index: xenomai/ChangeLog
===================================================================
--- xenomai/ChangeLog	(Revision 3698)
+++ xenomai/ChangeLog	(Arbeitskopie)
@@ -1,3 +1,8 @@
+2008-04-11  Jan Kiszka  <jan.kiszka@domain.hid>
+
+	* src/skins/native/task.c (rt_task_self): Fix tiny memory leak
+	when being invoked over a non-Xenomai thread.
+
 2008-04-10  Philippe Gerum  <rpm@xenomai.org>
 
 	* src/skins/*: Force minimum stack size to 32k, in order to work
Index: xenomai/src/skins/native/task.c
===================================================================
--- xenomai/src/skins/native/task.c	(Revision 3698)
+++ xenomai/src/skins/native/task.c	(Arbeitskopie)
@@ -294,8 +294,10 @@ RT_TASK *rt_task_self(void)
 	self = (RT_TASK *)malloc(sizeof(*self));
 
 	if (!self ||
-	    XENOMAI_SKINCALL1(__native_muxid, __native_task_self, self) != 0)
+	    XENOMAI_SKINCALL1(__native_muxid, __native_task_self, self) != 0) {
+		free(self);
 		return NULL;
+	}
 
 	pthread_setspecific(__native_tskey, self);
 

