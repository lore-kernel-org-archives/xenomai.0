Message-Id: <s56d88c0.099@domain.hid>
Date: Wed, 29 Nov 2006 13:19:00 +0100
From: "Nicolas BLANCHARD" <n.blanchard@domain.hid>
Subject: =?ISO-8859-1?Q?Re:=20R=E9p.=20:=20Re:=20[Xenomai-help]=20=20Swit?=
	=?ISO-8859-1?Q?ch=20mode=20with=20x86?=
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org, jan.kiszka@domain.hid

>>>> "Nicolas BLANCHARD" <n.blanchard@domain.hid> 29.11 11:25 >>>
>Hello,
>
>I've tested wiith Xenomai 2.3-rc2 (adeos 1.5-02)
>and change the config : 
>                                        - CONFIG_M586
>                                        - disable CONFIG_INPUT_PCSPKR
(it was on module)
>                                        - disable prio boosting (check
CONFIG_XENO_OPT_RPDISALBLE)
>
>and it seems to work better, one hour without blocking, it's a record
>for me.
>
>So, i will investigate to find which modification improve my problem.

After somes tests (kernel compil), it seems that prio boost is
responsable of my
problem. When it's disable (kernel option checked) my program run
correctly.

I'm not sure to understand how the prio boost work.
Can someone explain ?

thanks
blanchard nicolas

