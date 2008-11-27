Message-ID: <492EC2FC.5030808@domain.hid>
Date: Thu, 27 Nov 2008 16:55:40 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <20081127175234.163sujmgcgcgs4gk@domain.hid>
In-Reply-To: <20081127175234.163sujmgcgcgs4gk@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Zombie user tasks
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Mehmet Alphan Ulusoy <alphan@domain.hid>
Cc: xenomai@xenomai.org

Mehmet Alphan Ulusoy wrote:
> I have a problem where when I want to terminate a xenomai user space  
> task, the task becomes a zombie and I can not re-run it since some of  
> the resources (like mutexes) it uses are already there and can't be  
> created again.
> 
> The scenario is as follows:
> 
> - A process running on the computer forks to create a child.
> - The child executes the user space task using the system() call.  
> (child does not return). I suppose userTask is the child of the child  
> process now.
> - After a while it attempts to terminate the task by calling "pkill  
> -SIGTERM userTask"  using the system() call again.
> - The task, not always but sooner or later -above steps are repeated  
> for a number of times-, becomes a zombie.
> - The user space task has a signal handler for SIGTERM and SIGINT signals.
> - The signal handler is as follows:

You need to handle SIGCHLD in the father.

See http://en.wikipedia.org/wiki/Zombie_process

-- 
                                                 Gilles.

