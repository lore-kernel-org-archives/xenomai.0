Message-ID: <439995C0.6030006@domain.hid>
Date: Fri, 09 Dec 2005 15:33:36 +0100
From: Paolo Gai <pj@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------020001050801080902070109"
Subject: [Xenomai-help] Xenomai 2.0.1 - Posix Skin - realtime priorities -
 what I'm doing wrong?
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

This is a multi-part message in MIME format.
--------------020001050801080902070109
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Dear all,

First of all, I would like to thank Philippe for the long and exaustive 
reply to my previous post about the scheduling example.

I'm now trying the POSIX skin to write a very simple example using 
real-time priorities, RR and FIFO scheduling.

The idea is that a high priority task creates two medium priority tasks 
(that just prints something using printf) and a low priority task (that 
prints a message).  The example is run twice, in one case the medium 
priority tasks have SCHED_FIFO, in another case they have SCHED_RR.

I would expect that in both cases the two medium priority tasks would 
run printing their characters (either in a FIFO order or mixed when 
using RR), and at their end the low priority task would have run 
printing its message.

Instead, both with and without Xenomai, I obtain an output similar to 
the following one.

----------------------------------------------------------
[root@domain.hid xenomai-demos]# ./ex_rr
#####LOW priority thread!!!
...........###########...........############...........###########...........###########............###########...........###########...........############..........########........########........########........########...........##########............############...........###########...........###########...........###########............####################........................########################.........................########################........................#########################.........................########################......................############..#LOW 
priority thread!!!
.......########........########.........#########.......########........########.........#########.......#######........########........#########........########........########.........#########........#######........########.........#########........########.......########.........########........########........########.........#########........................#########################.........................########################.......................######################.................................############################################.......................############[root@domain.hid 
xenomai-demos]#
----------------------------------------------------------

I attach the source code of the example...

Does the behavior I obtain is normal? What I'm doing wrong?

bye

Paolo


--------------020001050801080902070109
Content-Type: application/octet-stream;
 name="example.tbz2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="example.tbz2"

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
gkf8XckU4UJAdpbSMA==
--------------020001050801080902070109--

