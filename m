Date: Mon, 14 Dec 2015 23:35:05 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20151214223505.GD16627@hermes.click-hack.org>
References: <tencent_7C005566224FD6F01071277C@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <tencent_7C005566224FD6F01071277C@qq.com>
Subject: Re: [Xenomai] Question about synchronisation between xenomai task
 and linux task
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?utf-8?B?44OL44Oj44Oz5pif5Lq6?= <1173264124@qq.com>
Cc: xenomai <xenomai@xenomai.org>

On Mon, Dec 14, 2015 at 10:56:40PM +0800, ニャン星人 wrote:
> Hello, sorry to bother you. I have some questions about synchronisation. I am very eager for your help. 
> 
> 
> I have read the source code file like rtipc.c, xddp.c, bufp.c,
> iddp.c, and pipe.c. Now I am wondering if there is a simple
> and effective way of synchronisation between xenomai task and
> linux task in user space and kernel space.
> 
> 
> I found most of synchronisation service introduced in Xenomai
> 3 Programmer¡¯s Reference Manual could be only used in xenomai
> task, linux task can not use these synchronisation service. If I
> use linux synchronisation service like mutex in xenomai task,
> xenomai task would switch to secondary mode which would cost a lot
> of time. So I want to know how to synchronize xenomai task and
> linux task in user space. o
> 
> 
> As I mentioned above, I have read the source code file like
> rtipc.c, xddp.c, bufp.c, iddp.c, I know lots of functions were
> realized in linux kernel modules as rtdm devices, both xenomai
> task and linux task could call these functions by rtdm
> interface. In kernel space, Synchronisation Services was used
> to synchronize between xenomai tasks, xnapc and
> wait_queue_head_t were used to synchronize between xenomai
> task and linux task. I am wondering if there is a simple to
> synchronize between xenomai task and linux task directly in
> kernel space.
> 
> 
> I'am a rookie of xenomai. It might be simple questions in your
> opinion. I would appreciate it if you could help.

The xddp sockets allow exchanging message between Xenomai and Linux
threads. Synchronizing per-se is complicated because the two types
of threads are scheduled by different schedulers.

> _______________________________________________ Xenomai mailing
> list Xenomai@xenomai.org
> http://xenomai.org/mailman/listinfo/xenomai

-- 
					    Gilles.
https://click-hack.org

