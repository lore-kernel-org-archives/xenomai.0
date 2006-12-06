Date: Wed, 6 Dec 2006 08:11:35 -0800 (PST)
From: mani bhatti <imranbashirbhatti@domain.hid>
In-Reply-To: <4576E1F9.5030707@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-485984728-1165421495=:69459"
Content-Transfer-Encoding: 8bit
Message-ID: <293.69459.qm@domain.hid>
Subject: [Xenomai-help] Re: problem persists with rt_queue
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

--0-485984728-1165421495=:69459
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi
Please tell me how can i do the following 

run the test over SVN trunk 

Thanks a lot for the gr8 help Jan.




Jan Kiszka <jan.kiszka@domain.hid> wrote: mani bhatti wrote:
> Hi 
> I had a problem of rt_queue overflow in xenomai 2.1.Then installed xenomai 2.2.5 but previous poblem with rt_queue is still there.I repeat the problem that when there is no listener on the queue the sender the sender displays the error message 
> 
> rt_queue_send(queue_input) failed sent bytes: 0
> rt_queue_send(queue_input) failed sent bytes: 0
> rt_queue_send(queue_input) failed sent bytes: 0
> rt_queue_alloc(queue_inout, 8) failed
> 
> 
>  and then stops and if i try to start my program again following message 
> 
> start
> rt_queue_alloc(queue_inout, 8) failed
> Segmentation fault
> 
> is displayed and program doesnot work at all.I would be very thankful for the correcting me what wrong am i doing.the code for the sender is attached.

...and your code still runs fine (SVN trunk, but the required patch is
in 2.2.5 as well). Moreover, stopping and restarting also causes no problem.

So, please check:

 - content of /proc/xenomai/version

If this actually gives "2.2.5":

 - run the test over SVN trunk (make sure you actually run trunk via
   /proc/xenomai/version, should give "2.3-rc2")

 - report your findings

Again, *precisely* your problem was understood, fixed, and applied to
both branches. It should really not show up the same way as before.

Jan



 
---------------------------------
Want to start your own business? Learn how on Yahoo! Small Business.
--0-485984728-1165421495=:69459
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi<br>Please tell me how can i do the following <br><pre><tt><tt><span style="text-decoration: underline;">run the test over SVN trunk</span> <br><br>Thanks a lot for the gr8 help Jan.<br></tt></tt></pre><br><br><br><b><i>Jan Kiszka &lt;jan.kiszka@domain.hid&gt;</i></b> wrote:<blockquote class="replbq" style="border-left: 2px solid rgb(16, 16, 255); margin-left: 5px; padding-left: 5px;"> mani bhatti wrote:<br>&gt; Hi <br>&gt; I had a problem of rt_queue overflow in xenomai 2.1.Then installed xenomai 2.2.5 but previous poblem with rt_queue is still there.I repeat the problem that when there is no listener on the queue the sender the sender displays the error message <br>&gt; <br>&gt; rt_queue_send(queue_input) failed sent bytes: 0<br>&gt; rt_queue_send(queue_input) failed sent bytes: 0<br>&gt; rt_queue_send(queue_input) failed sent bytes: 0<br>&gt; rt_queue_alloc(queue_inout, 8) failed<br>&gt; <br>&gt; <br>&gt;  and then stops and if i try to start my program again following
 message <br>&gt; <br>&gt; start<br>&gt; rt_queue_alloc(queue_inout, 8) failed<br>&gt; Segmentation fault<br>&gt; <br>&gt; is displayed and program doesnot work at all.I would be very thankful for the correcting me what wrong am i doing.the code for the sender is attached.<br><br>...and your code still runs fine (SVN trunk, but the required patch is<br>in 2.2.5 as well). Moreover, stopping and restarting also causes no problem.<br><br>So, please check:<br><br> - content of /proc/xenomai/version<br><br>If this actually gives "2.2.5":<br><br> - run the test over SVN trunk (make sure you actually run trunk via<br>   /proc/xenomai/version, should give "2.3-rc2")<br><br> - report your findings<br><br>Again, *precisely* your problem was understood, fixed, and applied to<br>both branches. It should really not show up the same way as before.<br><br>Jan<br><br></blockquote><br><p>&#32;

<hr size=1>Want to start your own business? Learn how on <a href="http://us.rd.yahoo.com/evt=41244/*http://smallbusiness.yahoo.com/r-index">Yahoo! Small Business.</a>
--0-485984728-1165421495=:69459--

