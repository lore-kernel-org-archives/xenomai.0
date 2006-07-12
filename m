Message-ID: <b647ffbd0607120645n69a20805rfb9e62c8cfb3061f@domain.hid>
Date: Wed, 12 Jul 2006 15:45:48 +0200
From: "Dmitry Adamushko" <dmitry.adamushko@domain.hid>
Subject: Re: [Xenomai-core] [PATCH] relax context check for rt_task_suspend
In-Reply-To: <44B4EA3B.1010109@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_89944_21051153.1152711948184"
References: <44B4C09F.209@domain.hid>
	<b647ffbd0607120500jccf65cdqd781ff668f2c7ba8@domain.hid>
	<44B4EA3B.1010109@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

------=_Part_89944_21051153.1152711948184
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--- task.c      2006-05-19 18:25:19.000000000 +0200
+++ task-my.c   2006-07-12 15:40:16.549170000 +0200
@@ -426,7 +426,8 @@ int rt_task_suspend(RT_TASK *task)
         goto unlock_and_exit;
     }


-    if (xnpod_unblockable_p()) {
+    /* we are about to suspend a task, let's check wehther it may sleep */
+    if (xnthread_test_flags(task, XNLOCK|XNROOT)) {
         err = -EPERM;
         goto unlock_and_exit;
     }



See the difference? :) it was slightly broken indeed, meaning it just bailed
out all the calls from the interrupt context which is wrong according to
spec.

maybe something like xnthread_task_unblockable/blockable(task)  would be
also of avail.


Oh, my dear. I should stop hacking patches while talking to colleagues.
> Does this one make more sense?
>

maybe it's better that the other way around? I mean, writting good code and
saying nonsense to your collegues... :o>


-- 
Best regards,
Dmitry Adamushko

------=_Part_89944_21051153.1152711948184
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div><div><br>
--- task.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2006-05-19 18:25:19.000000000 +0200<br>
+++ task-my.c&nbsp;&nbsp; 2006-07-12 15:40:16.549170000 +0200<br>
@@ -426,7 +426,8 @@ int rt_task_suspend(RT_TASK *task)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto unlock_and_exit;<br>
&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<br>
-&nbsp;&nbsp;&nbsp; if (xnpod_unblockable_p()) {<br>
+&nbsp;&nbsp;&nbsp; /* we are about to suspend a task, let's check wehther it may sleep */<br>
+&nbsp;&nbsp;&nbsp; if (xnthread_test_flags(task, XNLOCK|XNROOT)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; err = -EPERM;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto unlock_and_exit;<br>
&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<br>
<br>
See the difference? :) it was slightly broken indeed, meaning it just
bailed out all the calls from the interrupt context which is wrong
according to spec.<br>
<br>
maybe something like xnthread_task_unblockable/blockable(task)&nbsp; would be also of avail.<br>
<br>
</div><br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Oh, my dear. I should stop hacking patches while talking to colleagues.<br>
Does this one make more sense?<br></blockquote></div><br>
maybe it's better that the other way around? I mean, writting good code and saying nonsense to your collegues... :o&gt;<br>
<br clear="all"><br>-- <br>Best regards,<br>Dmitry Adamushko<br>
<br>


------=_Part_89944_21051153.1152711948184--

