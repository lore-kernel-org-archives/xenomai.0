Message-ID: <46261AC8.5080803@domain.hid>
Date: Wed, 18 Apr 2007 15:19:04 +0200
From: Jean-Luc Pamart <jlpamart@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] version of __ipipe_restore_pipeline_head
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

Hello

The rtdm heartbeat example is working fine.
I try now to run a more complete example :
"Hard Real Time Driver Example Tutorial with MMAP using the RTDM (Real 
Time Driver Model)"
(http://www.captain.at/xenomai-real-time-driver-example.php)

After building, it give a dmesg when loading :
realtimedriver: disagrees about version of symbol 
__ipipe_restore_pipeline_head
realtimedriver: Unknown symbol __ipipe_restore_pipeline_head

My configuration :
xeno 2.3
hal 1.6-03
My linux version is 2.6.19


We have __ipipe_restore_pipeline_head symbol in
the kernel :

c013f7b0 T __ipipe_restore_pipeline_head
c013f7b0 U __ipipe_restore_pipeline_head    [xeno_native]
c013f7b0 U __ipipe_restore_pipeline_head    [xeno_nucleus]
c013f7b0 U __ipipe_restore_pipeline_head    [xeno_rtdm]
c013f7b0 U __ipipe_restore_pipeline_head    [xeno_posix]

but the module realtimedriver I want to insmod has
been builded with the same sources.


So what may I do ?



