References: <DB6PR0701MB2456EA2D393F1395D0CA6A21B57D0@DB6PR0701MB2456.eurprd07.prod.outlook.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <4c13fe61-e903-08cb-5a8b-0bc8c24e9e32@xenomai.org>
Date: Mon, 2 Oct 2017 12:06:30 +0200
MIME-Version: 1.0
In-Reply-To: <DB6PR0701MB2456EA2D393F1395D0CA6A21B57D0@DB6PR0701MB2456.eurprd07.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] Posix replacement for rt_task_suspend(),
 rt_task_resume() and rt_task_delete()
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Giulio Moro <g.moro@qmul.ac.uk>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 10/02/2017 03:38 AM, Giulio Moro wrote:
> Hello,
> I am porting a Xenomai 3 application from Alchemy to the Posix API*. Under Alchemy, I was using rt_task_suspend(NULL) to suspend a task and rt_task_resume(&task) to resume the task from a separate thread. What is the best / recommended way of porting this to the Posix API?
> Are there any drop-in replacements? Otherwise, I was thinking of using a condition variable.

That would definitely work, being much safer than using asynchronous
suspend calls (who knows where in the code the target thread is going to
suspend, maybe while it holds a lock?...).

If you really have to suspend other threads than the running one, then
Cobalt defines the special SIGSUSP/SIGRESM signals, which are recognized
by libcobalt's pthread_kill() and kill() implementations. I would not
recommend to use them though, only if you have no other choice and are
willing to risk suspending threads in the middle of nowhere.

> 
> What about rt_task_delete() ? The Xenomai documentation does not list pthread_cancel (though I see it is being used by copperplate in the rt_task_delete() call). Is it ok to use pthread_cancel() on a xenomai task?
> 

Yes, this is the way to terminate POSIX threads with Cobalt as well.

-- 
Philippe.

