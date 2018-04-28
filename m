References: <d065542c-fe5d-ee6f-6a03-cfe26e156a3d@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <c6897d86-24d1-5463-efd5-dff4239dbf2c@xenomai.org>
Date: Sat, 28 Apr 2018 13:19:34 +0200
MIME-Version: 1.0
In-Reply-To: <d065542c-fe5d-ee6f-6a03-cfe26e156a3d@siemens.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [RFC][PATCH] cobalt/synch: Do not drop PP on
 xnsynch_release if it wasn't committed
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>, Xenomai <xenomai@xenomai.org>

On 04/26/2018 08:01 PM, Jan Kiszka wrote:
> We must not try to drop the prio ceiling in the kernel if it wasn't
> committed yet. That could easily happen when using a prio-ceiling mutex
> to wait on a cond-var.
> 
> This is not the most robust solution as it bases the decision on
> userspace controlled state which could be corrupted.
> 

The same issue applies to all *acquire() forms.

> 
> As written above, I'm wondering if we shouldn't mirror the state into
> kernel space. Or do we have it somewhere already?
> 

XNSYNCH_CEILING in this context, since ceil_owner_priority() raises it
when committing the boost.

> Also, could you have a second look at the whole PP thing Philippe. Are
> there more imbalances possible?

Unlikely in kernel space where there is a single release point. However
the tricky part is about getting that state in sync with the
syscall-less fast path in userland.

> I'll think through that again as well.
> TIA!
> 

Ok, I'll have a look when I'm back on-line in two weeks.

-- 
Philippe.

