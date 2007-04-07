From: Paul <paul_c@domain.hid>
Date: Sun, 8 Apr 2007 00:00:12 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200704080000.12934.paul_c@domain.hid>
Subject: [Xenomai-help] rt_heap return codes
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


During the course of debugging a simple xeno-native app, I notice some of the 
return codes for heap functions are at odds with the documentation.. For 
example rt_heap_bind() when used with TM_NONBLOCK returns -EAGAIN where as 
the docs would suggest -EWOULDBLOCK should be returned.

Also noted that rt_heap_delete() returns -EBUSY if another task holds a valid 
heap descriptor - Undocumented, but well worth having as it can be used to 
prevent the RT_HEAP memory from disappearing (either by a module unloading, 
or user space app terminating).

Are these return codes likely to change in the forseeable future ? 


Regards, Paul.

