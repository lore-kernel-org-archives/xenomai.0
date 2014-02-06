Message-ID: <52F35B2F.7000303@xenomai.org>
Date: Thu, 06 Feb 2014 10:51:43 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <1391373420.28930.YahooMailNeo@web171604.mail.ir2.yahoo.com>
 <52EF7772.2000008@xenomai.org>
 <1391541132.31887.YahooMailNeo@web171604.mail.ir2.yahoo.com>
In-Reply-To: <1391541132.31887.YahooMailNeo@web171604.mail.ir2.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] race condition when creating and deleting VxWorks
 tasks in xenomai-forge
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Matthias Schneider <ma30002000@yahoo.de>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 02/04/2014 08:12 PM, Matthias Schneider wrote:
> the patch seems to address the original problem. Should this patch be merged
> into the repository?
>

It is on its way to 'master', currently pending in 'next'.

> However, I seem to stumble into a different problem. If I understand correctly,
> CANCEL_DEFER() should prevent the thread/task from being cancelled.

...asynchronously. This is the important missing part.

I have verified
> that pthread_setcanceltype() is being entered and the CONFIG_XENO_ASYNC_CANCEL
> macro has thus been set correctly. Nevertheless, putting a printf after CANCEL_DEFER
> and before CANCEL_RESTORE shows that when rapidly creating and destroying tasks
> the CANCEL_RESTORE printf is not printed. Also, I run into a deadlock very quickly,
> due to wind_task_lock being held (consistent with the observed printf behavior).
> I am using Mercury on top on an unpatched linux kernel. Any idea how I can debug the
> apparently non-functioning pthread_setcanceltype ?
>

Per POSIX, printf() is a cancellation point, any pending cancellation 
request will be handled unconditionally when traversing it. CANCEL_DEFER 
will only postpone async cancellation requests, until a cancellation 
point is traversed or async cancellation mode is enabled back, whichever 
comes first.

http://pubs.opengroup.org/onlinepubs/009695399/functions/xsh_chap02_09.html

-- 
Philippe.

