Message-ID: <52029B27.70102@xenomai.org>
Date: Wed, 07 Aug 2013 21:08:23 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <0DE90633-1CDC-4BB5-837D-D9FA5409B73D@imag.fr>
	<51FF8F1D.6010002@xenomai.org>
	<08A3370B-8A54-4F6D-9076-2B41F933842C@imag.fr>
In-Reply-To: <08A3370B-8A54-4F6D-9076-2B41F933842C@imag.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] polling task and rt_task_sleep()
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Skander Bahloul <skander.bahloul@imag.fr>
Cc: xenomai@xenomai.org

On 08/07/2013 05:22 PM, Skander Bahloul wrote:
> Hi,
> 
> well, I surprised that it blocked parent process.
> 
> Is it really normal?

You should read some documentation about the SCHED_FIFO scheduling
policy, yes, the task with the highest priority runs as long as it is
runnable. Whether a task is the parent or child does not matter, only
scheduling policies and priorities matter to the scheduler.

-- 
                                                                Gilles.

