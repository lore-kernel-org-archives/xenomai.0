Message-ID: <38b44d590703060949lfa70769na93c19abd2ff248f@domain.hid>
Date: Tue, 6 Mar 2007 23:19:59 +0530
From: "Saiful Khan" <saiful.etc@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_108864_11334549.1173203399363"
Subject: [Xenomai-help] process memory not locked
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

------=_Part_108864_11334549.1173203399363
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,

I have ported my normal GNU/Linux (Posix) application in Xenomai, and I have
used Xenomai POSIX skin to do the same. In my application main() function is
spawning a thread using
pthread_attr_init()
pthread_attr_setdetachstate()
pthread_create()

But as soon as it spawn the thread the following message comes
*Xenomai*: process *memory not locked* (missing mlockall?), and I do not get
any message from that thread.

I have already  locked the paging  in main() as well as in the spawned
thread using  mlockall(MCL_CURRENT | MCL_FUTURE). After google search I
didnt found any solution to solve my problem.

1. Please tell me the reason? Is there anything I am doing wrong while
spawning thread?
2. What to do so that the thread also run in highest priority?

Thanks and regards
Saiful

------=_Part_108864_11334549.1173203399363
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<font size="-1">Hello,<br><br>I have ported my normal GNU/Linux (Posix) application in Xenomai, and I have used Xenomai POSIX skin to do the same. In my application main() function is spawning a thread using<br>pthread_attr_init()
<br>pthread_attr_setdetachstate()<br>pthread_create()<br><br>But as soon as it spawn the thread the following message comes<br><b><span style="font-weight: bold;">Xenomai</span></b><span style="font-weight: bold;">: process 
</span><b style="font-weight: bold;">memory not locked</b><span style="font-weight: bold;"> (missing mlockall?), </span>and I do not get any message from that thread.<br><br>I have already&nbsp; locked the paging&nbsp; in main() as well as in the spawned thread using&nbsp; mlockall(MCL_CURRENT | MCL_FUTURE). After google search I didnt found any solution to solve my problem.
<br><br>1. Please tell me the reason? Is there anything I am doing wrong while spawning thread?<br>2. What to do so that the thread also run in highest priority?<br><br>Thanks and regards<br>Saiful<br></font>

------=_Part_108864_11334549.1173203399363--

