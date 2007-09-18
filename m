Message-ID: <353969d40709180729s54307285i983eb7cc24c90642@domain.hid>
Date: Tue, 18 Sep 2007 16:29:21 +0200
From: "Guillaume Gaudonville" <guillaume.gaudonville@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_15753_31045249.1190125761369"
Subject: [Xenomai-help] Can't create more than one watchdog under vxworks
	skin
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

------=_Part_15753_31045249.1190125761369
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

I use Xenomai since a few time. I have to port an application
running under VxWorks on Linux. This application uses a lot of watchdog
to delay job it has to do.

When I use the function wdCreate under the VxWorks skin (in User Space),
I am not able to create more than 1 watchdog. I watched to the function
implementation in
user space and I saw that when I call wdCreate, a task is created with the
name: wdserver.

When I call wdCreate a second time, it returns me 0 because he can't create
another task with the same name (wdServer). But my watchdog seems to be
created in
kernel space because I can see it in
/proc/xenomai/registry/vxworks/watchdog.

Is it a mistake? If not, what is the reason for this behaviour?

I have modified the user space library to create a task of name
wdserver<WDOG_ID>,
and it seems to work fine. Is it correct?

I think a better solution would be to have only one task to manage all the
wathdog but I don't
have a lot of time to implement it. Maybe in a few weeks.

Thanks for your help.

-- 
Guillaume Gaudonville

------=_Part_15753_31045249.1190125761369
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,<br><br>I use Xenomai since a few time. I have to port an application<br>running under VxWorks on Linux. This application uses a lot of watchdog<br>to delay job it has to do.<br><br>When I use the function wdCreate under the VxWorks skin (in User Space),
<br>I am not able to create more than 1 watchdog. I watched to the function implementation in <br>user space and I saw that when I call wdCreate, a task is created with the name: wdserver.<br><br>When I call wdCreate a second time, it returns me 0 because he can&#39;t create
<br>another task with the same name (wdServer). But my watchdog seems to be created in<br>kernel space because I can see it in /proc/xenomai/registry/vxworks/watchdog.<br><br>Is it a mistake? If not, what is the reason for this behaviour?
<br><br>I have modified the user space library to create a task of name wdserver&lt;WDOG_ID&gt;,<br>and it seems to work fine. Is it correct?<br><br>I think a better solution would be to have only one task to manage all the wathdog but I don&#39;t
<br>have a lot of time to implement it. Maybe in a few weeks.<br><br>Thanks for your help.<br clear="all"><br>-- <br>Guillaume Gaudonville<br><br>

------=_Part_15753_31045249.1190125761369--

