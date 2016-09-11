References: <tencent_7EFF3BC22CBB53AA568408E6@qq.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <0fe39a24-b767-dff2-230d-18fa0b3766dd@xenomai.org>
Date: Sun, 11 Sep 2016 15:48:43 +0200
MIME-Version: 1.0
In-Reply-To: <tencent_7EFF3BC22CBB53AA568408E6@qq.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] "Ctrl + C" makes system crashed when exitting from
 "cross-link"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jack Lee <jacklee11@foxmail.com>, xenomai <xenomai@xenomai.org>

On 09/11/2016 01:12 PM, Jack Lee wrote:
> Hello, everyone!
>   My computer is Advantech MIO-5251, (the J1900 version, 
> http://www.advantech.com/products/bc6786b7-b69b-4fdd-9b63-79180dbd5dcb/mio-5251/mod_ff8534cc-e858-40ba-9bc2-386f19bfee4a)
>  linux kernel version is 4.1.18, xenomai version is 3.0.2, system is lubuntu 16.04.
> I remove the original UART drivers and modprobe the xeno_16550A driver. cross-link demo
> works fine, but when I type in "Ctrl + C" to exit from it, the terminal outputs these and the system
> just dies.
> ...
> main: /dev/rtdm/rtser1 (read) -> closed
> main: /dev/rtdm/rtser0 (write) -> closed
> main: delete write_task
> write_task: error on rt_task_wait_period, Interrupted system call
> write_task: exit
> main: delete read_task
> ---
> 
> Sometimes, it outputs these:
> ...
> main: exit
> ---
> The system does not die, but the cross-link does not exit actually.
> I run "cat /proc/xenomai/sched/thread" to get the pid and kill it,
> the terminal just outputs "main: exit" repeatedly.
> 
> What's wrong, and  how can I solve it? Thanks!
> 

The reader task may be hanging around although it should have received a
deletion signal, causing the main thread to wait for all its children
indefinitely. This said, issuing rt_task_delete() and friends over a
signal handler is not legit, so the demo code has a problem anyway.

You could run the cross-link application over gdb, then check the stack
backtrace of the reader task at exit (or any task that appears to be
stuck), to find out where that task is stuck (^C, then switch to the
reader task context using gdb's "thread" command, then "bt").

-- 
Philippe.

