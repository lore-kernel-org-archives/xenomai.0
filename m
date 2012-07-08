Message-ID: <4FF9709E.9090703@xenomai.org>
Date: Sun, 08 Jul 2012 13:35:58 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAKKWdteYpbU5y65GXtS6j6aHQ_ESDk0C41B-MjC93cVzfW8mvg@mail.gmail.com>
In-Reply-To: <CAKKWdteYpbU5y65GXtS6j6aHQ_ESDk0C41B-MjC93cVzfW8mvg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] questions: Linux/Xenomai domains
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: ali hagigat <hagigatali@gmail.com>
Cc: xenomai@xenomai.org

On 07/07/2012 03:06 PM, ali hagigat wrote:
> 1) Suppose an interrupt happens in a real time task. How that
> interrupt detects the execution context of that task?(Linux domain or
> Xenomai domain), is there any flag in relation with each task set by
> the user space libraries?

No, there is a "current domain". But anyway, the interrupt handler does
not need to detect which domain is current, because each domain has its
own handlers, so, which handler is executed already depends on the
current domain. In order to understand how the interrupt pipeline
interacts with xenomai, you should probably read the "Life with Adeos"
document:

http://www.xenomai.org/documentation/branches/v2.3.x/pdf/Life-with-Adeos-rev-B.pdf

> 
> 2) Is there "interrupt shield" mechanics for Xenomai, 2.6.0? (It seems
> there is no CONFIG_XENO_OPT_ISHIELD)

No, the interrupt shield no longer exists.

> 
> 3) I call a Linux service in a real time task and that service
> finishes and CPU returns to the real time task again to execute next
> instruction, is it in primary mode or secondary mode upon returning?

In secondary mode. Some xenomai services getting their caller to switch
to secondary mode, get it to switch again to primary mode when the
service has been executed in secondary mode. An example of such service
is rt_timer_set_mode.

Asking questions before starting to use xenomai is fine, but you should
really consider installing it and starting to write applications,
because it is only then that the real problems and questions will arise.

-- 
                                                                Gilles.

