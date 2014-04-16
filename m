Message-ID: <534E4885.3060400@xenomai.org>
Date: Wed, 16 Apr 2014 11:08:21 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <20140415144247.9126D1A5@centrum.cz>
In-Reply-To: <20140415144247.9126D1A5@centrum.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] non-blocking rt_task_suspend(NULL)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Petr Cervenka <grugh@centrum.cz>
Cc: Xenomai <xenomai@xenomai.org>

On 04/15/2014 02:42 PM, Petr Cervenka wrote:
> Hello I have a problem with the rt_task_suspend(NULL) call. I'm using
> it for synchronization of two (producer / consumer like) tasks. 1)
> When the consumer task has no work to do, it stops itself by calling
> of the rt_task_suspend(NULL). 2) When the producer creates new work
> for consumer, it wakes it up by calling of
> rt_task_resume(&consumerTask). The problem is, that consumer seldom
> switches to a state, that it sleeps by rt_task_suspend no more. And
> the task then takes all the CPU time. The return code is 0. But I
> already have seen couple of -4 (-EINTR) values in the past also.
> Consumer task status was 00300380 before and 00300184 (if there is
> small safety sleep present). I can use for example RT_EVENT variable
> instead, but I'm curious if you by chance don't know, what is
> happening? Xenomai 2.6.3, Linux 3.5.7

Could you post the example of code you are using to get this issue?

-- 
					    Gilles.

