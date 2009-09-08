Message-ID: <4AA6AF80.5090902@domain.hid>
Date: Tue, 08 Sep 2009 21:24:48 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <793108.19562.qm@domain.hid>
	<89DE9B44-67FD-4DFE-BFE6-7445851AABCD@su.sabanciuniv.edu>
In-Reply-To: <89DE9B44-67FD-4DFE-BFE6-7445851AABCD@su.sabanciuniv.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] RT Task RPC over a POSIX/Native Queue
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Alphan Ulusoy <alphan@domain.hid>
Cc: xenomai@xenomai.org

Alphan Ulusoy wrote:
> You can always use the Xenomai's _wonderful_ pipe functionality (and  
> other task communication services as well) to communicate data back  
> and forth between RT (Xenomai user -or- kernel space tasks) and non-RT  
> (dedicated linux executables) tasks. This also ensures that your RT  
> and non-RT domains are clearly separated by design, which is a good  
> thing IMHO.

Waiting for the non real-time task to post an answer through rt-pipes is
as dangerous for the real-time task determinism as with message queues
of any kind.

Besides, a task with low priority which oscillates between first and
secondary modes does not threaten a primary mode only task determinism
any more than a non real-time tasks. However, it can communicates with
the primary mode only task with a lot more IPCs and synchronization
mechanisms.

And there is no difference in design between an application separated
between real-time and non real-time tasks on the one hand, and an
application separated between real-time and oscillating tasks on the
other hand. The real gain in design happens when you can split driver
code from application code.

-- 
					    Gilles.

