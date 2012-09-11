Message-ID: <504F6604.2000104@xenomai.org>
Date: Tue, 11 Sep 2012 18:25:40 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAP1DbD7y_G+5tjUucgXE57gA-8K4vMCe5s_cVfOoEJV3CVF_RQ@mail.gmail.com>
In-Reply-To: <CAP1DbD7y_G+5tjUucgXE57gA-8K4vMCe5s_cVfOoEJV3CVF_RQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Children of forked process do not die upon receiving
 SIGKILL in Xenomai?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Soo-Hyun Yoo <yoos117@gmail.com>
Cc: xenomai@xenomai.org

On 09/11/2012 06:22 PM, Soo-Hyun Yoo wrote:
> Hello,
> 
> I have a certain process "A" that forks and execs a process "B". B
> spawns multiple child processes.
> 
> In the vanilla Linux kernel, I can have A send a SIGTERM or SIGKILL to
> B and thereby successfully kill B and all of its children.
> 
> Under Xenomai, however, I am noticing that the same action kills B,
> but B's children make init their new parent and continue running.
> 
> Why is this, and what can I do to kill B's children without having to
> use a script to track down each child process individually?

No idea, please send a test case allowing us to reproduce the issue.

-- 
					    Gilles.

