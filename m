Sender: chensong_2000@189.cn
Subject: Re: a question about atomic_cmpxchg in xnsynch_acquire
References: <a7b2af0b-dd76-444f-3e8d-33b6d40c7f74@189.cn>
From: "chensong_2000@189.cn" <chensong_2000@189.cn>
Message-ID: <2ec374e9-1755-4183-70a3-c0d46411413b@189.cn>
Date: Mon, 24 May 2021 17:52:12 +0800
MIME-Version: 1.0
In-Reply-To: <a7b2af0b-dd76-444f-3e8d-33b6d40c7f74@189.cn>
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
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

i initiated mutex in the main thread and acquire at the same context, is 
it wrong?

Should i lock it in the main thread and acquire it in another thread 
with a timeout?

i will try.

/Song

在 2021/5/24 下午5:20, chensong_2000--- via Xenomai 写道:
> hi,
> 
> i'm working on mutex_timedlock64, the call stack roughly is supposed to be:
> 
> CoBaLt_mutex_timedlock64 -- __cobalt_mutex_timedlock_break -- 
> xnsynch_acquire -- xnthread_suspend
> 
> however, it doesn't go to xnthread_suspend as expected, turns out it 
> returns from here:
> 
> h = atomic_cmpxchg(lockp, XN_NO_HANDLE,
>                 get_owner_handle(currh, synch));
> 
>      if (likely(h == XN_NO_HANDLE)) {
>          set_current_owner(synch, curr);
>          xnthread_get_resource(curr);
>          return 0;
>      }
> 
> atomic_cmpxchg returns 0.
> 
> i printed some information by
> printk("%s, 1, curr handle: 0x%x, status: 0x%x, lockp: 0x%x\n", 
> __FUNCTION__, currh, synch->status, lockp);
> printk("curr: 0x%x, name:%s, owner: 0x%x\n ", curr, curr->name, 
> synch->owner);
> 
> got these:
> xnsynch_acquire, 1, curr handle: 0x20, status: 0xb, lockp: 0xb810e40
> curr: 0x6c4408, name:lt-smokey, owner: 0x0
> 
> 
> As far as my understanding, atomic_cmpxchg is supposed to assign curr 
> handle (0x20) to lockp->v, is my unserstanding correct and is there 
> anything i can do to dig into atomic_cmpxchg?
> 
> Any tips would be appreciated, many thanks.
> 
> BR
> 
> Song
> 
> 
> 

