Content-Transfer-Encoding: quoted-printable
Content-Type: text/html; charset="utf-8"
Message-Id: <20090213114426.b684eb1399accf59cf50bd4742b49228.7ef98e2e0b.wbe@domain.hid>
From: tarr@domain.hid
Date: Fri, 13 Feb 2009 11:44:26 -0700
Mime-Version: 1.0
Subject: [Xenomai-help] =?utf-8?q?Use_of_Linux_wake=5Fup=28=29_system_call?=
 =?utf-8?q?_in_Xenomai_RTDM_thread_in_kernel_mode?=
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

<html><body><span style=3D"font-family:Verdana; color:#000000; font-size:10=
pt;">Folks --<br><br>I would like to use a Linux wake_up() system call in a=
 RTDM periodic task<br>to signal a Linux driver xxx_poll() function that us=
es the poll_wait().<br><br>Is this appropriate? <br><br>If so, should I dis=
able interrupts in the xxx_poll() function around the poll_wait()<br>using =
the rtdm_lock_irqsave()?<br><br>If not, any suggestions on how to get the s=
ame functionality?<br><br>My thanks for any assistance.<br><br>Cheers --<br=
>Steve Tarr<br>tarr@domain.hid<br><br>&nbsp;<br><br></span><=
/body></html>

