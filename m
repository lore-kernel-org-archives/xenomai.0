Message-Id: <47B0371E0200000100192400@domain.hid>
Date: Mon, 11 Feb 2008 11:53:02 -0500
From: "Hubert Talbot" <Hubert.Talbot@domain.hid>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Subject: [Xenomai-help] T_RRB
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

Hi,

I'm new to Xenomai.

I am studying xenomai and I would like to kwow how to apply round-robin.

Specifically, what to do with (do I have to?):

	- the kernel configuration

		Real-time sub-system/Timing/Enable periodic timing ?

	- the timer configuration=20

		rt_timer_set_mode(rt_timer_ns2ticks(???))  ?

	- the task configuration

		rt_task_set_periodic(???)  ?
		rt_task_set_mode(0, T_RRB, 0)    ?
		rt_task_slice(???)  ?

Thanks in advanced.

Hubert




