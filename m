MIME-Version: 1.0
In-Reply-To: <55C326C5.4070608@xenomai.org>
References: <CAHoW4hFHAmGqFOdDp3QHXK-6w0NQEw8XBxOc8kJkVUQAvEfT_w@mail.gmail.com>
 <55C22EED.4040704@xenomai.org>
 <CAHoW4hHS2QS1td6mUiWid-unDrMDZaQMo3vkYsDynNze5YsaSw@mail.gmail.com>
 <55C326C5.4070608@xenomai.org>
Date: Thu, 6 Aug 2015 11:00:24 -0400
Message-ID: <CAHoW4hHityc2RSznYrqr4BHnTNSwjgYH7265jyqrjawmbXZKQQ@mail.gmail.com>
From: Charles Kiorpes <ckiorpes@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] Segfaults and ENOMEM during rt_event_create()
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, xenomai@xenomai.org

> Could you --enable-debug, and have gdb determine the offending
> instruction? TIA,

The gdb output is as follows:

Program received signal SIGSEGV, Segmentation fault.
get_free_range (heap=heap@entry=0x6dc07000, bsize=bsize@entry=256, log2size=8)
    at ../../../xenomai-3.0-rc6/lib/copperplate/heapobj-pshared.c:242
242                                           freepage =
__shref_check(heap, *((memoff_t *)freepage));

Thanks,
- Charles

