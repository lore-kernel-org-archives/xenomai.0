Message-ID: <20061030160829.3119.qmail@domain.hid>
Date: Mon, 30 Oct 2006 08:08:29 -0800 (PST)
From: mani bhatti <imranbashirbhatti@domain.hid>
Subject: Re: [Xenomai-help] Problem with rt_queue
In-Reply-To: <45423948.10203@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1327746162-1162224509=:2883"
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

--0-1327746162-1162224509=:2883
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Thanks Jan .
I have executed # patch -p0 < native-queue-bcast-fix.patch in directory where xenomai is installed and in my case it is  /usr/xenomai directory but sender still goes out of memory  if no  listener  is  waiting on the queue and displays the message

rt_queue_alloc(queue_inout, 8) failed

After this message is displayed and i try to execute sender again then sender doesnot execute at all and simply displays above message so i need to restart my computer if i want to eecute sender again .Should i execute patch in some other directory or  is it some other problem?
Thanks for the help.

Jan Kiszka <jan.kiszka@domain.hid> wrote: mani bhatti wrote:
> Thanks a lot Jan for the reply.Now after changing the task name queue is working but 
>   following message is displayed by the sender if there is no queue which you had pointed in the last email.
>   rt_queue_alloc(queue_inout, 8) failed
> Segmentation fault
> 
>   Actually i dont  understand about the patch which you had sent in your last email (because patch seems to be incomple to me ) because that seems to be part of xenomai source code and if that is how can i use that source code in my program for solving my problem i mean at which place in my program should i put that patch .Sorry for your inconvenience.thanks.
>   

Goto xenomai source directory and execute

# patch -p0 < native-queue-bcast-fix.patch

But I guess the patch will soon be SVN as well fixing your problem.

Jan



 
---------------------------------
Get your email and see which of your friends are online - Right on the  new Yahoo.com
--0-1327746162-1162224509=:2883
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Thanks Jan .<br>I have executed # patch -p0 &lt; native-queue-bcast-fix.patch in directory where xenomai is installed and in my case it is&nbsp; /usr/xenomai directory but sender still goes out of memory&nbsp; if no&nbsp; listener&nbsp; is&nbsp; waiting on the queue and displays the message<br><br>rt_queue_alloc(queue_inout, 8) failed<br><br>After this message is displayed and i try to execute sender again then sender doesnot execute at all and simply displays above message so i need to restart my computer if i want to eecute sender again .Should i execute patch in some other directory or&nbsp; is it some other problem?<br>Thanks for the help.<br><br><b><i>Jan Kiszka &lt;jan.kiszka@domain.hid&gt;</i></b> wrote:<blockquote class="replbq" style="border-left: 2px solid rgb(16, 16, 255); margin-left: 5px; padding-left: 5px;"> mani bhatti wrote:<br>&gt; Thanks a lot Jan for the reply.Now after changing the task name queue is working but <br>&gt;   following message is displayed by
 the sender if there is no queue which you had pointed in the last email.<br>&gt;   rt_queue_alloc(queue_inout, 8) failed<br>&gt; Segmentation fault<br>&gt; <br>&gt;   Actually i dont  understand about the patch which you had sent in your last email (because patch seems to be incomple to me ) because that seems to be part of xenomai source code and if that is how can i use that source code in my program for solving my problem i mean at which place in my program should i put that patch .Sorry for your inconvenience.thanks.<br>&gt;   <br><br>Goto xenomai source directory and execute<br><br># patch -p0 &lt; native-queue-bcast-fix.patch<br><br>But I guess the patch will soon be SVN as well fixing your problem.<br><br>Jan<br><br></blockquote><br><p>&#32;

<hr size=1>Get your email and see which of your friends are online - Right on the <a href="http://us.rd.yahoo.com/evt=42973/*http://www.yahoo.com/preview"> new Yahoo.com</a>

--0-1327746162-1162224509=:2883--

