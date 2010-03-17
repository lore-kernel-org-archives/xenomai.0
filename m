Date: Wed, 17 Mar 2010 22:07:57 +0800 (CST)
From: robert165 <robert165@domain.hid>
Message-ID: <132c37c.bd80.1276c73c215.Coremail.robert165@domain.hid>
In-Reply-To: <4C2CF9F5.7000408@domain.hid>
References: <4C2CF9F5.7000408@domain.hid>
	<bcc5a9cc1002071243i27ed36a9k38152e5d29034ad4@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_126294_14459823.1268834877973"
Subject: [Xenomai-help] Sleep in rtdm driver
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai-help <xenomai@xenomai.org>

------=_Part_126294_14459823.1268834877973
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit

Hi everyone!

I'm writing a gpio driver in RTDM. I start it with the demo "Hard real time RTDM driver skeleton v1.1" of Jan Kiszka.
If I used rtdm_task_sleep in rt_ioctrl  function,  it return that "Xenomai: assertion failed at kernel/xenomai/skins/rtdm/drvlib.c:372 (!xnpod_unblockable_p())"  when running.
It is said that rtdm_task_sleep can be called from Kernel-based task. Why I can't use it in my driver. Optionally, I can do this in user-space by periodic calling the driver, but it seems slower than in kernel space.
 
Thank you very much!
 
Best regards
 
Luo
 

------=_Part_126294_14459823.1268834877973
Content-Type: text/html; charset=gbk
Content-Transfer-Encoding: 7bit

<DIV>Hi&nbsp;everyone!</DIV>
<DIV><BR>I'm writing a gpio driver&nbsp;in RTDM. I start it with the demo "Hard real time RTDM driver skeleton v1.1" of Jan Kiszka.</DIV>
<DIV>If I used rtdm_task_sleep in rt_ioctrl&nbsp; function,&nbsp; it return that "Xenomai: assertion failed at kernel/xenomai/skins/rtdm/drvlib.c:372 (!xnpod_unblockable_p())"&nbsp; when running.</DIV>
<DIV>It is said that rtdm_task_sleep can be called from Kernel-based task. Why&nbsp;I can't use it in my driver. Optionally, I can do this in user-space by periodic calling the driver, but it seems&nbsp;slower than&nbsp;in kernel space.</DIV>
<DIV>&nbsp;</DIV>
<DIV>Thank you very much!</DIV>
<DIV>&nbsp;</DIV>
<DIV>Best regards</DIV>
<DIV>&nbsp;</DIV>
<DIV>Luo</DIV>
<DIV>&nbsp;<BR></DIV><br><br><span title="neteasefooter"/></span>
------=_Part_126294_14459823.1268834877973--


