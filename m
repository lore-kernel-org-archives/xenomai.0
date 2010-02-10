From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4B72F360.4050209@domain.hid>
References: <4B72F360.4050209@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 10 Feb 2010 19:31:09 +0100
Message-ID: <1265826669.2368.132.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] S_memLib_NOT_ENOUGH_MEMORY error in porting
 VxWorks application.
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Michael Buksas <mwbuksas@domain.hid>
Cc: xenomai@xenomai.org

On Wed, 2010-02-10 at 10:56 -0700, Michael Buksas wrote:
> I'm porting a VxWorks application to Xenomai/SOLO and getting 
> S_memLib_NOT_ENOUGH_MEMORY errors from taskSpawn.
> 
> I'm currently running on a desktop Linux system, so I doubt physical 
> memory is an issue. Rather, I think it's the allocation of memory for 
> tasks, and my crushing ignorance about how to do the same.
> 
> For example, does this occur when the memory needs of the task exceed 
> the stack size argument to taskSpawn? Increasing this value does not 
> appear to help.
> 
> Can anyone suggest how to further diagnose the memory problem?

Sloppy code at work in the emulator. Could you apply this patch and
check the actual return code? If -EPERM, then make sure to run your app
with root privileges, since the emulator attempts to create SCHED_FIFO
threads.

diff --git a/vxworks/taskLib.c b/vxworks/taskLib.c
index a9e12e7..4db2c66 100644
--- a/vxworks/taskLib.c
+++ b/vxworks/taskLib.c
@@ -327,7 +327,7 @@ static STATUS __taskInit(struct wind_task *task,
 	ret = pthread_create(&thid, &thattr, &task_trampoline, task);
 	pthread_attr_destroy(&thattr);
 	if (ret) {
-		errno = S_memLib_NOT_ENOUGH_MEMORY;
+		errno = ret == -EAGAIN ? S_memLib_NOT_ENOUGH_MEMORY : ret;
 		return ERROR;
 	}
 

> 
> And to address the broader question, where should a raw beginner at 
> embedded programming go for documentation on Xenomai/SOLO and guidance 
> for the porting process?
> 
> Thanks in advance,
> Mike
> 
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help


-- 
Philippe.



