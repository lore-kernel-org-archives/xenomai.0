References: <CAGTNcBuw2Wm6J1XZ2NKesomYojKZg_jxjDjw0QBncyfHDRjwNA@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <469e1d96-6f47-53cc-3750-77ae8479da23@xenomai.org>
Date: Sun, 5 Mar 2017 12:43:24 +0100
MIME-Version: 1.0
In-Reply-To: <CAGTNcBuw2Wm6J1XZ2NKesomYojKZg_jxjDjw0QBncyfHDRjwNA@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] heap corruption with multiple,
 differently-sized calls to rt_queue_alloc()
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Josh Bowman <jbowman@facts-inc.com>, xenomai@xenomai.org

On 03/04/2017 03:30 AM, Josh Bowman wrote:
> Hi,
> 
> I'm having a problem when trying to allocate multiple blocks using
> rt_queue_alloc(). When my client code is building a message to send to
> queue, it sometimes finds that it needs a bigger block. So it creates a new
> block via rt_queue_alloc(); copies the data from the previous block into
> the new block; and then calls rt_queue_free() on the old block.
> 
> The code included here is a simplified version of this process. It
> allocates a buffer; puts some data in it; allocates a new buffer; and then
> checks to make sure the previous buffer is intact. Then it frees the
> previous buffer and loops.
> 
> When I run this code, it prints:
> 
> ERROR: at 7, 2: after rt_queue_alloc, checkMessage failed at loc 480
> 
> This means the buffer previously returned by rt_queue_alloc() is damaged by
> the next call to rt_queue_alloc().  I set a watch in the debugger, and it
> looks like the damage is done at line 376 of lib/alchemy/queue.c; this
> seems to indicate the heapobj_alloc() is returning a region that overlaps
> the one previously allocated.
> 
> I'm running Xenomai/mercury from stable-3.0.x on x86_64, with config:
> "--with-core=mercury --enable-smp --enable-pshared --enable-registry
> --enable-debug"
> 
> I build the test program with:
> 
> g++ queue-2.cpp -o queue-2 -g -fno-default-inline -fno-omit-frame-pointer
> `xeno-config --skin=alchemy --cflags --no-auto-init --ldflags`
> 
> Changing the realloc_count parameter causes the code to fail at different
> iterations; passing realloc_count = 3 moves the failure to the
> rt_queue_send() call. (The code runs to completion with realloc_count set
> to 1 or 2.)
> 
> I've also found that if I don't call rt_queue_free() the code runs to
> completion.
> 
> Let me know if there's anything I can do to help.
> 

Your test code perfectly reproduces the issue here, thanks. There is a
severe bitmap breakage, I'm on it.

-- 
Philippe.

