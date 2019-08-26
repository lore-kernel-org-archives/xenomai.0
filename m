From: LOCHE Daniel <dloche@laas.fr>
Subject: Fork + Exec and unwanted rescheduling
Message-ID: <e273805c-bfed-c1e2-d7b0-fc49c19f21a6@laas.fr>
Date: Mon, 26 Aug 2019 14:58:18 +0200
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello all,

I am doing some experiments with Xenomai 3.0.5 (Linux 4.9.38) on a NUC 
(i5-8250U).

What I am trying to do :
- run a Xenomai Manager process that launches tasks with FIFO scheduling 
and same fixed priority (Alchemy API used here).
Every task is executed on the same core, changing core affinity to only 
CPU 1.
- every task is designed to do periodically : *
1)* read timer (start of task)
*2)* fork+exec to run a binary (from an external benchmark, tasks not 
designed with Xenomai API)
*3)* read timer again (end of task execution)
I do this to monitor the execution of every task as you may have guessed.

The issue is that it looks like every time a task reaches step 2) 
("fork" step), my child task goes back to the end of scheduling queue. 
Consequently, I basically see this in my logs :
- Every task starts and goes till the Fork step.
- Then every task executes their binary... don't know how this is 
scheduled exactly... feels like CFS basic linux scheduling.
- Every task ends more or less at the same timestamp
... and again and again at every period... What I expected to see it 
every task running right one after the other with no forced (i.e. 
systematic) discontinuity between steps 1), 2) and 3) (as I am doing 
FIFO) due to other tasks preemption !

=> When I fork a Xenomai task, does it (child process) completely looses 
its Xenomai properties and falls back into Linux domain..?
If so... Am I condemned with such architecture to break my scheduling 
policy due to the forks ?

I tried raising up the priority level of a task right before the fork 
(step 1)) so that child process inherits highest priority level and 
start running directly, but the results are not convincing : tasks are 
still running 2 by 2 (i.e. 1 task is still preempting the forked child 
process). (I put the priority level back to normal at step 3).
Not sure to understand what's happening there...

I can give you some .csv extracts of my timestamp logs, with and without 
priority up-scaling.

Thanks for your help,
Daniel

