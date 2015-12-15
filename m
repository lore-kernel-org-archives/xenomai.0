Date: Tue, 15 Dec 2015 07:21:35 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20151215062135.GJ16627@hermes.click-hack.org>
References: <tencent_7C005566224FD6F01071277C@qq.com>
 <20151214223505.GD16627@hermes.click-hack.org>
 <tencent_1F2D495201DDAD5A77A043F3@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <tencent_1F2D495201DDAD5A77A043F3@qq.com>
Subject: Re: [Xenomai]
 =?utf-8?b?5Zue5aSN77yaICBRdWVzdGlvbiBhYm91dCBzeW5jaHJv?=
 =?utf-8?q?nisation_between_xenomai_taskand_linux_task?=
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?utf-8?B?44OL44Oj44Oz5pif5Lq6?= <1173264124@qq.com>
Cc: xenomai <xenomai@xenomai.org>

On Tue, Dec 15, 2015 at 11:42:44AM +0800, ニャン星人 wrote:
> So you mean there is not simple and complete solution way apply by
> xenomai to figure out the synchronization problem between xenomai
> thread and linux thread? When I meet synchronization problem
> between xenomai thread and linux thread, do I have to handle it
> like xddp and pipe?

The solution which strictly does what you want is xddp. (rt_pipe is
deprecated, and linux pipes will cause both ends to switch to
secondary mode).

But you may consider using a Xenomai only synchronization primitive
(such as semaphores, message queues, etc...), and have the non
real-time thread be a Xenomai thread oscillating between primary and
secondary mode. Using the SCHED_OTHER or SCHED_WEAK policy for such
a thread should help.

-- 
					    Gilles.
https://click-hack.org

