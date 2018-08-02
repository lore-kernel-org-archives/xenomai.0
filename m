References: <5B5F75DA.7050201@freyder.net>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <8af2ccc9-42fe-1d20-6c97-48b18edde68e@xenomai.org>
Date: Thu, 2 Aug 2018 17:18:01 +0200
MIME-Version: 1.0
In-Reply-To: <5B5F75DA.7050201@freyder.net>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] tcb alloc fail in main_overlay
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Steve Freyder <steve@freyder.net>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 07/30/2018 10:32 PM, Steve Freyder wrote:
> With 3.0.7, it seems that I'm still doing something bad to the pshared
> heap.  I haven't gotten to a trimmed-down test case yet, but
> I'm seeing this:
> 
>    0"033.613| BUG in main_overlay(): [main] failed to allocate main tcb
> 

You may want to use gdb to debug this, setting a breakpoint in the
overlay routine where the assertion trips. The first hit is ok, this
should be the main() context creating its own tcb. Any subsequent call
of the overlay routine for the same process would be wrong. Dumping the
stack backtrace at this point should point at the offender.

> Is there any kind of pshared heap analyzer I can use to check for
> corruption?
> 

Nope. But you may want to build with --enable-debug=full to enable all
internal checks (caution: this may slow execution significantly).

> I don't see any status display that shows utilization for
> the pshared heap (like /proc/xenomai/heap does for other kinds of heaps),
> is there some debug I need to enable?
> 

/proc exports the status of kernel objects created by Cobalt, the shared
heap is merely a userland beast in this respect. AFAIR, the fuse-based
registry should expose this information for your process.

-- 
Philippe.

