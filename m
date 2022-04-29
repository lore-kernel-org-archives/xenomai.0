From: Giulio Moro <giulio@bela.io>
Subject: Thread's CPU time
Message-ID: <6a50f4cf-4f2a-542a-c332-4d98975e36a6@bela.io>
Date: Fri, 29 Apr 2022 17:20:02 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai Mailing list <xenomai@xenomai.org>

Hi everyone,
 From /proc/xenomai/sched/stat I infer there must be an internal struct somewhere keeping track of how much CPU time is actually used by each thread. Is there any way to access this kind of statistics from a running Xenomai user space program without leaving primary mode and without attempting to read this file? I am implementing an infrastructure to measure the CPU time of a given block of code. Currently I am using Cobalt's clock_gettime(), but this only works reliably if the task does not get preempted or otherwise rescheduled between the two calls.

I have run this kind of tests offline before and that's all nice and good, but I am looking for a lightweight and non invasive way of benchmarking particular sections of large-ish programs with minimal modifications.

Thanks,
Giulio

