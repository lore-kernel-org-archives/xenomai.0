From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17861.63466.119293.917982@domain.hid>
Date: Sun, 4 Feb 2007 16:12:42 +0100
Subject: Re: [Xenomai-help] rt descriptors
In-Reply-To: <1170412112.11967.6.camel@domain.hid>
References: <1170412112.11967.6.camel@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Victor Shulyak <V.I.Shulyak@domain.hid>
Cc: xenomai <xenomai@xenomai.org>

Victor Shulyak wrote:
 > Hello
 > 
 > Can I use RT_HEAP (or others descriptors) in the following way:
 > 
 > RT_HEAP h_desc;
 > create descriptor (rt_heap_create (&h_desc,...)
 > 
 > fork
 > child process: rt_task_shadow () and rt_heap_alloc (&h_desc, ...)
 > parent process: rt_heap_alloc (&h_desc, ...)
 > 
 > Will h_desc be valid and usable in child processes?

forking in a xenomai process is not yet fully supported. You can do it,
but you will get unwanted switches to secondary mode because of page
faults. This issue is solved by the following patch:

https://mail.gna.org/public/xenomai-core/2007-01/msg00092.html

but the patch has not yet been merged with the I-pipe patch, so, if you
want to call fork in your xenomai programs, you have to apply
this patch after the I-pipe patch.

Now, about the rt descriptors, I would expect them to be usable in child
processes as well.

-- 


					    Gilles Chanteperdrix.

