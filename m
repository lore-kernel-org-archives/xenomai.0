Date: Tue, 18 Oct 2005 08:47:06 -0700
Subject: Re: [Xenomai-core] Xenomai and gdbserver
From: Steven Seeger <steve@domain.hid>
Message-ID: <BF7A670A.18EE%steve@domain.hid>
In-Reply-To: <001701c5d3f8$388d4660$0600a8c0@domain.hid>
Mime-version: 1.0
Content-type: text/plain;
	charset="US-ASCII"
Content-transfer-encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Marco Cavallini <rtai@domain.hid>, xenomai@xenomai.org

I use remote debug with fusion/2.6.13, but I am using fusion from svn.

Also, there are bugs. One I have found recently is that if a task is created
with T_SUSP and then you start stepping through the code, the task seems to
start up on its own somehow. Weird.

Older verisons of fusion had issues with not every task in the application
halting on breakpoint.

On 10/18/05 8:10 AM, "Marco Cavallini" <rtai@domain.hid> wrote:

> Hi
> I wonder if someone has been able to perform a remote debug with
> xenomai/fusion.
> I have problems debugging fusion-0.9.1 programs with kernel-2.6.12.2 and
> Fedora Core 2
> gdb-6.0
> 
> When i run GDB chain and step into rt_task_create(...), GDB prompts "[1]+
> Stopped         gdb chain" and
> terminates. I can
> call "gdbserver ipnum:port chain". then connect to it from a remote machine
> using gdb and "target remote..."
> 
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core


