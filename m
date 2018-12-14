From: duanwujie <wjduan@linx-info.com>
Subject: Question about synchronization object
Message-ID: <4c930380-38d1-ccc2-8d6e-bc422d4f97b9@linx-info.com>
Date: Fri, 14 Dec 2018 17:14:09 +0800
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, jan.kiszka@siemens.com
Cc: Xenomai <xenomai@xenomai.org>, =?UTF-8?B?5b2t5b+X6Iiq?= <zhpeng@linx-info.com>

Hi, Phi and Jan:

I have question about  synchronization object.Consider under condition.

*
*

*Thread A*

     mutex_lock(lock)  //O1

     ...

     ...

     mutex_unlock(lock)//O2

*Thread B*

     mutex_lock(lock) //O3

     ....

     ....

     mutex_unlock(lock);


O1:  become xnsynch's owner.

O3:  blocked to wait thread A unlock mutex.

O2:  this will call sc_cobalt_mutex_unlock syscall then transfer owner 
to thread B.

        But in the xnsynch_release's  "likely condition" seems that  
transfer_ownership will  not be called. Therefore, how to resume thread B ?

       Is there something i misunderstood  for xnsynch_fast_release ?


struct xnthread *xnsynch_release(struct xnsynch *synch,
                  struct xnthread *thread)
{
    /* .................................. */
     if (likely(xnsynch_fast_release(lockp, threadh)))//This condition
         return NULL;

     return transfer_ownership(synch, thread);
}


-- 
*Linx Software Corportaion Sichuan Branch
Name：wujie duan
Tel：028-65182023-6202
E-mail: wjduan@linx-info.com
*
