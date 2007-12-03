Message-ID: <475433EF.4020804@domain.hid>
Date: Mon, 03 Dec 2007 17:50:55 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <5D63919D95F87E4D9D34FF7748CE2C2AE66E86@domain.hid>
In-Reply-To: <5D63919D95F87E4D9D34FF7748CE2C2AE66E86@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] rt_queue_write strange behaviour ++ testcase !!
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Roderik.Wildenburg@domain.hid
Cc: xenomai@xenomai.org

Roderik.Wildenburg@domain.hid wrote:
> After I realized that the error depends on TM_NONBLOCK in the queue reading task (rt_queue_read(&qtest1q, &buf, sizeof (buf), TM_NONBLOCK)), I finaly succeded in generating a simple testcase !
> 
> On my target (PPC 400MHZ) the appended programm produces an EINVAL error with rt_queue_write nearly immediately and the second rt_queue_write succeeds nearly allways.
> 
> So, could you/Philippe try this testcase on your target and tell me whether you face the same problem.
>

Do you have this patch in?

--- ksrc/skins/native/syscall.c	(revision 3195)
+++ ksrc/skins/native/syscall.c	(revision 3196)
@@ -2468,10 +2468,10 @@

 		if (size > 0)
 			__xn_copy_to_user(curr, buf, mbuf, size);
+
+		rt_queue_free(q, mbuf);
 	}

-	rt_queue_free(q, mbuf);
-
 	return (int)rsize;
 }

-- 
Philippe.

