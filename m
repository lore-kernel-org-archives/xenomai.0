Subject: Re: Kernel 5.4 xenomai 3.1 -stable, e1000e, NIC crash on ifup
References: <a5d49a09-0317-9f58-03ff-f1a1ef109b99@freyder.net>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <e981039b-1309-8f18-d561-0c6491a81624@siemens.com>
Date: Tue, 16 Mar 2021 13:08:26 +0100
MIME-Version: 1.0
In-Reply-To: <a5d49a09-0317-9f58-03ff-f1a1ef109b99@freyder.net>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: steve freyder <steve@freyder.net>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 15.03.21 18:19, steve freyder via Xenomai wrote:
> Greetings Xenomai list,
> 
> 
> We are seeing the following stack trace when we 'ifup' the e1000e
> adapter.  4.19 exhibits same failure, 4.14.96 also fails but with a
> different stack trace.  Last working version is 4.14.85.
> 
> Thanks in advance for any assist,
> 
> Steve
> 
> ------------------------------------------------------------------------
> 
> [   47.635779] ------------[ cut here ]------------
> [   47.637083] ip (658) used greatest stack depth: 3960 bytes left
> [   47.640416] WARNING: CPU: 0 PID: 0 at kernel/ipipe/core.c:1968
> __ipipe_spin_unlock_debug+0x50/0x5c

        /*
         * We catch a nasty issue where spin_unlock_irqrestore() on a
         * regular kernel spinlock is about to re-enable hw interrupts
         * in a section entered with hw irqs off. This is clearly the
         * sign of a massive breakage coming. Usual suspect is a
         * regular spinlock which was overlooked, used within a
         * section which must run with hw irqs disabled.
         */

Something is broken in the rtnet driver, possibly due to changes in
kernel code being called by it while holding an RT lock. Are you already
running with all I-pipe and Xenomai debugging features enabled? Maybe
they could tell you more and earlier.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

