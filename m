References: <20150919112648.GB22852@hermes.click-hack.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <5601A396.7020605@siemens.com>
Date: Tue, 22 Sep 2015 20:53:10 +0200
MIME-Version: 1.0
In-Reply-To: <20150919112648.GB22852@hermes.click-hack.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] rtdm_lock_get
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, Xenomai <xenomai@xenomai.org>

On 2015-09-19 13:26, Gilles Chanteperdrix wrote:
> Hi,
> 
> now that rtdm_lock_get() locks the scheduler, and if moved the
> scheduler lock before the spin_lock, would not it be possible to use
> rtdm_lock_get() with irqs on ?

Conceptually, yes. People will only have to be more carefully to use the
right mechanism depending on if there are IRQ-based users or not - just
like under Linux. We avoided this trap so far.

Maybe we should ask the user to mark IRQ-free spinlocks via a special
rtdm_lock_init_noirq. Then we could validate the caller's context in a
debug version.

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux

