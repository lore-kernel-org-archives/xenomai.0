Message-ID: <5397644B.9060806@xenomai.org>
Date: Tue, 10 Jun 2014 22:02:19 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <5396CD6D.8060806@axelsw.it>
In-Reply-To: <5396CD6D.8060806@axelsw.it>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Gdb freezes when stepping through rt_task_spawn.
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Marco Tessore <marco.tessore@axelsw.it>, xenomai@xenomai.org

On 06/10/2014 11:18 AM, Marco Tessore wrote:
> Hello,
> I have a problem, you've probably already dealt with in the past:
> when I debug with gdb / gdbserver, if I execute step by step while I 
> invoke the call rt_task_spawn, gdb freezes with no chance of recovery.
> 
> Since I have seen that you have already faced the problem a few years 
> ago, I was wondering if you had found a solution.

Did you try xenomai 2.6 git? An issue was fixed very recently with
regard to gdb (it is actually the latest commit on this branch).


-- 
                                                                Gilles.

