Date: Wed, 16 Jun 2004 17:27:24 +0300 (EEST)
From: "Rus V. Brushkoff" <rus@domain.hid>
In-Reply-To: <1087395025.15584.10.camel@domain.hid>
Message-ID: <Pine.LNX.4.53.0406161712430.7079@domain.hid>
References: <Pine.LNX.4.53.0406151339110.1831@domain.hid>
 <1087395025.15584.10.camel@domain.hid>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [Adeos-main] Re: Problem with FIFO's (maybe with RTAI/Adeos) at 2.6.x branch
Sender: adeos-main-admin@domain.hid
Errors-To: adeos-main-admin@domain.hid
List-Help: <mailto:adeos-main-request@domain.hid>
List-Post: <mailto:adeos-main@gna.org>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: <https://mail.gna.org/public/adeos-main/>
To: Philippe Gerum <rpm@xenomai.org>
Cc: rtai@domain.hid, adeos-main@gna.org

On Wed, 16 Jun 2004, Philippe Gerum wrote:

:> Default Trap Handler: vector 14: Suspend RT task ef8b8720
:Uhoh... I've added this one to my check list. I don't have any clue
:right now, but anyway, thanks for reporting.

 My trace is rtf_put -> mbx_send_wp -> mbx_put -> copy_from_user()/memcpy()
Did you got the same ? I've got stable traps with large variable and
spurios from small ones. Also traps depends from kernel image size (!), if
you compile some drivers in for ex.
 It'is interesting what is the maximum allowed linux kernel module size
(nearly 2Gb as for kernel space) ?

:

		Rus

