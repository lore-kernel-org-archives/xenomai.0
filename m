References: <5AC116C9.6040809@freyder.net>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <15a83f1d-7785-11c9-5f64-c09cb035ff10@xenomai.org>
Date: Mon, 2 Apr 2018 15:41:58 +0200
MIME-Version: 1.0
In-Reply-To: <5AC116C9.6040809@freyder.net>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] Possible Xenomai fuse filesystem/registry queue
 status files issue?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Steve Freyder <steve@freyder.net>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 04/01/2018 07:28 PM, Steve Freyder wrote:
> Greetings again.
> 
> As I understand it, for each rt_queue there's supposed to be a
> "status file" located in the fuse filesystem underneath the
> "/run/xenomai/user/session/pid/alchemy/queues" directory, with
> the file name being the queue name.  This used to contain very
> useful info about queue status, message counts, etc.  I don't know
> when it broke or whether it's something I'm doing wrong but I'm
> now getting a "memory exhausted" message on the console when I
> attempt to do a "cat" on the status file.
> 
> Here's a small C program that just creates a queue, and then does
> a pause to hold the accessor count non-zero.
> 

<snip>

> The resulting output (logged in via the system console):
> 
> # sh qtest.sh
> + sleep 1
> + ./qc --mem-pool-size=64M --session=mysession foo
> + find /run/xenomai
> /run/xenomai
> /run/xenomai/root
> /run/xenomai/root/mysession
> /run/xenomai/root/mysession/821
> /run/xenomai/root/mysession/821/alchemy
> /run/xenomai/root/mysession/821/alchemy/tasks
> /run/xenomai/root/mysession/821/alchemy/tasks/task@1[821]
> /run/xenomai/root/mysession/821/alchemy/queues
> /run/xenomai/root/mysession/821/alchemy/queues/foo
> /run/xenomai/root/mysession/system
> /run/xenomai/root/mysession/system/threads
> /run/xenomai/root/mysession/system/heaps
> /run/xenomai/root/mysession/system/version
> + qfile='/run/xenomai/*/*/*/alchemy/queues/foo'
> + cat /run/xenomai/root/mysession/821/alchemy/queues/foo
> memory exhausted
> 
> At this point, it hangs, although SIGINT usually terminates it.
> 
> I've seen some cases where SIGINT won't terminate it, and a reboot is
> required to clean things up.  I see this message appears to be logged
> in the obstack error handler.  I don't think I'm running out of memory,
> which makes me think "heap corruption".  Not much of an analysis!  I did
> try varying queue sizes and max message counts - no change.
> 

I can't reproduce this. I would suspect a rampant memory corruption too,
although running the test code over valgrind (mercury build) did not
reveal any issue.

- which Xenomai version are you using?
- cobalt / mercury ?
- do you enable the shared heap when configuring ? (--enable-pshared)

-- 
Philippe.

