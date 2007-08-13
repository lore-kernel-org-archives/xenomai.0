Message-ID: <46C0AE52.1020007@domain.hid>
Date: Mon, 13 Aug 2007 21:17:38 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
From: Roland Tollenaar <rwatollenaar@domain.hid>
Subject: [Xenomai-help] rtcan sockets not closing
Reply-To: rolandtollenaar@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Xenomai-help@domain.hid

Hi

On the problem of the overflow warnings that seem to be coming out of 
nowhere. (Earlier insight showed that I have resident sockets which are 
not being closed when my application closes, but I have also found that 
even with one socket only I get buffer overflows which cannot be explained)

Sorry to bother with this, but should

rt_dev_close(can_fd,etc)

not close the socket such that it no longer shows in

/proc/rtcan/sockets ?

I am calling it but it is not fail safe. Sometimes the socket is neatly 
taken out, othertimes not.

Any suggestions?

Regards,

Roland

