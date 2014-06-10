Message-ID: <5396CD6D.8060806@axelsw.it>
Date: Tue, 10 Jun 2014 11:18:37 +0200
From: Marco Tessore <marco.tessore@axelsw.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] Gdb freezes when stepping through rt_task_spawn.
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello,
I have a problem, you've probably already dealt with in the past:
when I debug with gdb / gdbserver, if I execute step by step while I 
invoke the call rt_task_spawn, gdb freezes with no chance of recovery.

Since I have seen that you have already faced the problem a few years 
ago, I was wondering if you had found a solution.

kind regards
Marco Tessore


