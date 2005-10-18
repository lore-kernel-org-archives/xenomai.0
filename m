Message-ID: <001701c5d3f8$388d4660$0600a8c0@domain.hid>
From: "Marco Cavallini" <rtai@domain.hid>
Date: Tue, 18 Oct 2005 17:10:27 +0200
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="Windows-1252";
	reply-type=original
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Xenomai and gdbserver
Reply-To: Marco Cavallini <rtai@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

Hi
I wonder if someone has been able to perform a remote debug with 
xenomai/fusion.
I have problems debugging fusion-0.9.1 programs with kernel-2.6.12.2 and 
Fedora Core 2
gdb-6.0

When i run GDB chain and step into rt_task_create(...), GDB prompts "[1]+ 
Stopped         gdb chain" and
terminates. I can
call "gdbserver ipnum:port chain". then connect to it from a remote machine
using gdb and "target remote..." 


