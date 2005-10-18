Message-ID: <435521BA.4020605@domain.hid>
Date: Tue, 18 Oct 2005 18:24:26 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Xenomai and gdbserver
References: <001701c5d3f8$388d4660$0600a8c0@domain.hid>
In-Reply-To: <001701c5d3f8$388d4660$0600a8c0@domain.hid>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Marco Cavallini <rtai@domain.hid>
Cc: xenomai@xenomai.org

Marco Cavallini wrote:
> Hi
> I wonder if someone has been able to perform a remote debug with 
> xenomai/fusion.
> I have problems debugging fusion-0.9.1 programs with kernel-2.6.12.2 and 
> Fedora Core 2
> gdb-6.0
> 
> When i run GDB chain and step into rt_task_create(...), GDB prompts 
> "[1]+ Stopped         gdb chain" and
> terminates. I can

I'm tracking an issue like that, causing the debuggee to run into a SIGBUS, due 
to the program counter being messed up somehow. AFAICT, this sometimes happens 
when stepping over code that migrates between primary and secondary modes (and 
rt_task_create does). I need to log this one on the bug tracker. It's pretty 
PITA to chase, but it's 100% reproductible here, so there's hope.

> call "gdbserver ipnum:port chain". then connect to it from a remote machine
> using gdb and "target remote..."
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core
> 


-- 

Philippe.

