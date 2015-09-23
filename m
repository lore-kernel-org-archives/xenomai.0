References: <5601A1A1.2020506@siemens.com> <560263A0.4080208@sigmatek.at>
 <56026810.8040300@sigmatek.at>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <56028093.6050805@siemens.com>
Date: Wed, 23 Sep 2015 12:36:03 +0200
MIME-Version: 1.0
In-Reply-To: <56026810.8040300@sigmatek.at>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] Fwd: Re: Problem that the Linux scheduler is not
 called for some ms
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: harald.fessl@sigmatek.at, xenomai@xenomai.org

On 2015-09-23 10:51, Harald Feßl wrote:
> Hi
> 
> The linux tasks are not blocked (not all).
> I think the problem is , that the linux scheduler function in the kernel
> is not called for some ms.
> I have also traced the calls to the scheduler function
> "static int __sched __schedule(void)"
> and sometimes when the decribed problem occur this function is not
> called while no linux task are running.

If no task is runnable, there is also no reason to invoke schedule.

Please post a ftrace log of your system, covering both a working and a
non-working cycle, including cobalt* and at least sched and irq events.

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux

