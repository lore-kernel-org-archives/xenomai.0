Message-ID: <501FBC80.4060305@xenomai.org>
Date: Mon, 06 Aug 2012 14:45:52 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAKKWdtegDdaZ67qykwXacz5XqCRbSGVw3f_pqqRt432XaJJqGA@mail.gmail.com>
	<501FB8A5.50804@xenomai.org>
In-Reply-To: <501FB8A5.50804@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] question: scheduling3
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai@xenomai.org

On 08/06/2012 02:29 PM, Philippe Gerum wrote:
> On 08/06/2012 02:13 PM, ali hagigat wrote:
>> It seems there are some scheduling policies like RT, TP, IDLE and
>> SPORADIC inside Xenomai code. Is there any document to explain them?
>> For kernel, man page of sched_setscheduler() explains every thing
>> about the scheduling policies, can you add some comments to clarify
>> the functionality of those?
> 
> No, because FIFO, SPORADIC, round-robin and Time Partitioning are common 
> in the real-time space. If you want more doc to appear in the scheduler 
> documentation, just send it there for review.

As a matter of fact SCHED_FIFO, SCHED_SPORADIC, SCHED_RR are normalized
by POSIX, so, you may find all the documentation you need on the Open
Group website.

-- 
					    Gilles.

