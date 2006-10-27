Message-ID: <20061027151347.62705.qmail@domain.hid>
Date: Fri, 27 Oct 2006 08:13:47 -0700 (PDT)
From: mani bhatti <imranbashirbhatti@domain.hid>
Subject: Re: [Xenomai-help] Problem with rt_queue
In-Reply-To: <453FEA27.3020705@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1455400731-1161962027=:62103"
Content-Transfer-Encoding: 8bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

--0-1455400731-1161962027=:62103
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Thanks a lot Jan for the reply.Now after changing the task name queue is working but 
  following message is displayed by the sender if there is no queue which you had pointed in the last email.
  rt_queue_alloc(queue_inout, 8) failed
Segmentation fault

  Actually i dont  understand about the patch which you had sent in your last email (because patch seems to be incomple to me ) because that seems to be part of xenomai source code and if that is how can i use that source code in my program for solving my problem i mean at which place in my program should i put that patch .Sorry for your inconvenience.thanks.
  
 
  

Jan Kiszka <jan.kiszka@domain.hid> wrote:
  mani bhatti wrote:
> Hi Phillipe and Jan 
> Thanks a lot for your help.I am sending the compilable
> source code so that you have an idea what wrong am i
> doing.I am sending the listeners which are listening
> to the same queue at the same time.But i dont know why
> at one time only one listener receives data from
> sender queue inspite of that i am using broadcast
> mode.Thanks a lot.I have attached files for sender and
> listener.

Well, interesting test case. It actually revealed bugs, but not where
expected.

Your problem is a simple bug in the listener tests. They both register a
task of the name "beta", only the first one succeeds (your code is a bit
hackish in this regard - when hunting problems, make sure to check ALL
return codes for potential problems!). Once fixed, your code runs fine here.

Nevertheless, queue_sender by itself uncovered a problem of
rt_queue_send in broadcast mode when no one is listening. The message
reference count got messed up and the queue ran out of memory. The
attached patch fixes it:

Jan
Index: ksrc/skins/native/queue.c
===================================================================
--- ksrc/skins/native/queue.c (Revision 1747)
+++ ksrc/skins/native/queue.c (Arbeitskopie)
@@ -631,7 +631,9 @@ int rt_queue_send(RT_QUEUE *q, void *mbu
prependq(&q->pendq, &msg->link);
else
appendq(&q->pendq, &msg->link);
- }
+ } else
+ /* Ownership did not change, so update reference count. */
+ msg->refcount++;

err = nrecv;

Index: ChangeLog
===================================================================
--- ChangeLog (Revision 1748)
+++ ChangeLog (Arbeitskopie)
@@ -1,3 +1,8 @@
+2006-10-26 Jan Kiszka 
+
+ * ksrc/skins/native/queue.c (rt_queue_send): Track message count
+ correctly when broadcasting to a queue without listeners.
+
2006-10-25 Jan Kiszka 

* ksrc/drivers/testing/irqbench.c, doc/txt/irqbench.txt,


 		
---------------------------------
 All-new Yahoo! Mail - Fire up a more powerful email and get things done faster.
--0-1455400731-1161962027=:62103
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

<div>Thanks a lot Jan for the reply.Now after changing the task name queue is working but </div>  <div>following message is displayed by the sender if there is no queue which you had pointed in the last email.</div>  <div>rt_queue_alloc(queue_inout, 8) failed<BR>Segmentation fault<BR></div>  <div>Actually i dont&nbsp; understand about the patch which you had sent in your last email (because patch seems to be incomple to me )&nbsp;because that seems to be part of xenomai source code and if that is how can i use that source code in my program for solving my problem i mean at which place in my program should i put that patch&nbsp;.Sorry for your inconvenience.thanks.</div>  <div><BR>&nbsp;</div>  <div><BR><BR><B><I>Jan Kiszka &lt;jan.kiszka@domain.hid&gt;</I></B> wrote:</div>  <BLOCKQUOTE class=replbq style="PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #1010ff 2px solid">mani bhatti wrote:<BR>&gt; Hi Phillipe and Jan <BR>&gt; Thanks a lot for your help.I am sending the
 compilable<BR>&gt; source code so that you have an idea what wrong am i<BR>&gt; doing.I am sending the listeners which are listening<BR>&gt; to the same queue at the same time.But i dont know why<BR>&gt; at one time only one listener receives data from<BR>&gt; sender queue inspite of that i am using broadcast<BR>&gt; mode.Thanks a lot.I have attached files for sender and<BR>&gt; listener.<BR><BR>Well, interesting test case. It actually revealed bugs, but not where<BR>expected.<BR><BR>Your problem is a simple bug in the listener tests. They both register a<BR>task of the name "beta", only the first one succeeds (your code is a bit<BR>hackish in this regard - when hunting problems, make sure to check ALL<BR>return codes for potential problems!). Once fixed, your code runs fine here.<BR><BR>Nevertheless, queue_sender by itself uncovered a problem of<BR>rt_queue_send in broadcast mode when no one is listening. The message<BR>reference count got messed up and the queue ran out
 of memory. The<BR>attached patch fixes it:<BR><BR>Jan<BR>Index: ksrc/skins/native/queue.c<BR>===================================================================<BR>--- ksrc/skins/native/queue.c (Revision 1747)<BR>+++ ksrc/skins/native/queue.c (Arbeitskopie)<BR>@@ -631,7 +631,9 @@ int rt_queue_send(RT_QUEUE *q, void *mbu<BR>prependq(&amp;q-&gt;pendq, &amp;msg-&gt;link);<BR>else<BR>appendq(&amp;q-&gt;pendq, &amp;msg-&gt;link);<BR>- }<BR>+ } else<BR>+ /* Ownership did not change, so update reference count. */<BR>+ msg-&gt;refcount++;<BR><BR>err = nrecv;<BR><BR>Index: ChangeLog<BR>===================================================================<BR>--- ChangeLog (Revision 1748)<BR>+++ ChangeLog (Arbeitskopie)<BR>@@ -1,3 +1,8 @@<BR>+2006-10-26 Jan Kiszka <JAN.KISZKA@WEB.DE><BR>+<BR>+ * ksrc/skins/native/queue.c (rt_queue_send): Track message count<BR>+ correctly when broadcasting to a queue without listeners.<BR>+<BR>2006-10-25 Jan Kiszka <JAN.KISZKA@WEB.DE><BR><BR>*
 ksrc/drivers/testing/irqbench.c, doc/txt/irqbench.txt,<BR></BLOCKQUOTE><BR><p>&#32;
		<hr size=1><a href="http://us.rd.yahoo.com/evt=43256/*http://advision.webevents.yahoo.com/mailbeta"> All-new Yahoo! Mail </a>- Fire up a more powerful email and get things done faster.
--0-1455400731-1161962027=:62103--

