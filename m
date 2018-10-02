Date: Tue, 2 Oct 2018 17:58:38 +0200
From: Henning Schild <henning.schild@siemens.com>
Message-ID: <20181002175838.1e9ad8f0@md1pvb1c.ad001.siemens.net>
In-Reply-To: <1544c287-5653-6117-cba0-eb355b936887@xenomai.org>
References: <1544c287-5653-6117-cba0-eb355b936887@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PULL] A couple of fixes to the split series for x86
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: "Kiszka, Jan" <jan.kiszka@siemens.com>, "Xenomai@xenomai.org" <Xenomai@xenomai.org>

Applied to https://git.xenomai.org/ipipe-x86.git wip/4.14-split

Thanks!
Henning


Am Mon, 1 Oct 2018 15:28:06 +0200
schrieb Philippe Gerum <rpm@xenomai.org>:

> The following changes since commit
> be45333e3af13c3b7cb12ecd200cb9be7a8fb439:
> 
>   x86: ipipe: do not panic on unexpected IRQ trap (2018-09-27
> 09:09:52 +0200)
> 
> are available in the Git repository at:
> 
>   https://lab.xenomai.org/ipipe-rpm.git x86/4.14.71
> 
> for you to fetch changes up to
> c5540da918650be520d8f5331ec1944ccfcf6c53:
> 
>   sched/core: ipipe: do not panic on failed migration to the head
> stage (2018-10-01 15:10:59 +0200)
> 
> ----------------------------------------------------------------
> Philippe Gerum (2):
>       ipipe: timer: prevent double-ack if host timer is not grabbed
>       sched/core: ipipe: do not panic on failed migration to the head
> stage
> 
>  kernel/ipipe/timer.c | 11 +++++++----
>  kernel/sched/core.c  |  2 --
>  2 files changed, 7 insertions(+), 6 deletions(-)
> 


