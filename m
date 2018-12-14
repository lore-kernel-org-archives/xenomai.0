Subject: Re: Question about synchronization object
References: <4c930380-38d1-ccc2-8d6e-bc422d4f97b9@linx-info.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <72323c84-a5eb-23a4-d26f-ee0eac8615f3@siemens.com>
Date: Fri, 14 Dec 2018 13:07:17 +0100
MIME-Version: 1.0
In-Reply-To: <4c930380-38d1-ccc2-8d6e-bc422d4f97b9@linx-info.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: duanwujie <wjduan@linx-info.com>, Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>, =?UTF-8?B?5b2t5b+X6Iiq?= <zhpeng@linx-info.com>

On 14.12.18 10:14, duanwujie wrote:
> Hi, Phi and Jan:
> 
> I have question about  synchronization object.Consider under condition.
> 
> *
> *
> 
> *Thread A*
> 
>      mutex_lock(lock)  //O1
> 
>      ...
> 
>      ...
> 
>      mutex_unlock(lock)//O2
> 
> *Thread B*
> 
>      mutex_lock(lock) //O3
> 
>      ....
> 
>      ....
> 
>      mutex_unlock(lock);
> 
> 
> O1:  become xnsynch's owner.
> 
> O3:  blocked to wait thread A unlock mutex.
> 
> O2:  this will call sc_cobalt_mutex_unlock syscall then transfer owner to thread B.
> 
>         But in the xnsynch_release's  "likely condition" seems that  
> transfer_ownership will  not be called. Therefore, how to resume thread B ?
> 
>        Is there something i misunderstood  for xnsynch_fast_release ?
> 
> 
> struct xnthread *xnsynch_release(struct xnsynch *synch,
>                   struct xnthread *thread)
> {
>     /* .................................. */
>      if (likely(xnsynch_fast_release(lockp, threadh)))//This condition
>          return NULL;

xnsynch_fast_release() is just a double-check - before going into the slow path 
with the leaving owner - if there is still a waiter for the lock. If there is 
(the fastlock word does *not* only contain the handler of the current owner, 
also has XNSYNCH_FLCLAIM set), we will branch into transfer_ownership.

BTW, to understand the real flow, you can try turning on the function graph 
tracer of the Linux kernel and catch the call graph of an interesting syscall. 
Or you use the gdb stub of QEMU[/KVM] running a Xenomai kernel for symbolic 
kernel debugging (stepping through the source code).

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

