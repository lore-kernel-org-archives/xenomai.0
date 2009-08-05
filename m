From: Andreas Glatz <andreasglatz@domain.hid>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 05 Aug 2009 17:51:03 -0400
Message-Id: <1249509063.4762.84.camel@domain.hid>
Mime-Version: 1.0
Subject: [Xenomai-help] Alignment exception on powerpc
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Xenomai help <xenomai@xenomai.org>

Hi,

I'm running xenomai-2.4.8, Linux-2.6.26 on a MPC8360 PowerPC.

I enabled nucleus debugging and found out that tasks sometimes
switch to secondary mode due to data alignment exceptions (#1536 ==
0x600):

<snip>
Xenomai: Switching bgndT30_3 to secondary mode after exception #1536
from user-space at 0x101013f4 (pid 3191)
Xenomai: Switching bgndT30_3 to secondary mode after exception #1536
from user-space at 0x101013f4 (pid 3191)
...
</snip>

I know that we get those exceptions because we pass the -fpack-struct
option to gcc and some data in structures are misaligned. It would
be quite a lot of work to go through the code to change it so that 
we don't have to pass the -fpack-struct option.

Is there a way to execute the exception handler from primary mode 
to prevent the tasks to switch to secondary mode?

Best regards,
Andreas


