From: Steve Freyder <steve@freyder.net>
Message-ID: <5B5F75DA.7050201@freyder.net>
Date: Mon, 30 Jul 2018 15:32:26 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] tcb alloc fail in main_overlay
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

With 3.0.7, it seems that I'm still doing something bad to the pshared
heap.  I haven't gotten to a trimmed-down test case yet, but
I'm seeing this:

    0"033.613| BUG in main_overlay(): [main] failed to allocate main tcb

Is there any kind of pshared heap analyzer I can use to check for
corruption?

I don't see any status display that shows utilization for
the pshared heap (like /proc/xenomai/heap does for other kinds of heaps),
is there some debug I need to enable?

Best regards,
Steve


