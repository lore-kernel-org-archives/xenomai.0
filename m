Message-ID: <435EFAB8.2050501@domain.hid>
Date: Wed, 26 Oct 2005 05:40:40 +0200
From: Hannes Mayer <h.mayer@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] RTDM & serial port
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

Hi Jan et al.!

I've noticed your thread on the RTAI list "Driver Model for RTAI" in June.
Now as I try to port some RTAI serial port stuff to Xenomai in order to
put up some howto page on my website, I'm clueless.

None of the RTAI functions rt_spopen, rt_spread_timed, rt_spwrite are
available - I see that there is some rt_dev_open, rt_dev_write available,
but only rt_dev_read - what about some timed-read ?

I see that rt_spopen opens /dev/rtser[X] but /dev/rtser[X] is not on my
system, nor can I find any creation-script in the xenomai source.

Sorry if I'm overlooking some stuff... 5:40am here.

I'd be very glad for any hints/examples/code-snippets!

Thanks a lot & best regards,
Hannes.

