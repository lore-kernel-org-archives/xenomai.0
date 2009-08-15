Date: Sat, 15 Aug 2009 15:14:35 +0200 (CEST)
From: "Waschk,Kolja" <xenoka09@domain.hid>
In-Reply-To: <1250262328.2933.0.camel@domain.hid>
Message-ID: <alpine.DEB.2.00.0908151512440.7626@domain.hid>
References: <Pine.LNX.4.62.0908141030170.14595@domain.hid>
	<4A853707.10509@domain.hid>
	<Pine.LNX.4.62.0908141206480.14595@domain.hid>
	<1250244831.3019.17.camel@domain.hid>
	<Pine.LNX.4.62.0908141226340.14595@domain.hid>
	<1250262328.2933.0.camel@domain.hid>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Subject: Re: [Xenomai-help] T_WARNSW ignored?
Reply-To: xenoka09@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

Hi,

well my guess was correct, the quickly increasing MSW without SIGXCPU was just
due to a forced mode switch with rt_task_set_mode... how silly, sorry for
bothering!

Kolja



