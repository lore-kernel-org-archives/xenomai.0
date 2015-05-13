Date: Wed, 13 May 2015 20:06:13 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150513180613.GE3759@hermes.click-hack.org>
References: <CAKC9m6cqL6vFttH3QJM9Z64YqHscF1QGCeP6dq5w=XepGDXgeQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKC9m6cqL6vFttH3QJM9Z64YqHscF1QGCeP6dq5w=XepGDXgeQ@mail.gmail.com>
Subject: Re: [Xenomai]
 =?utf-8?b?SVJRIGZsb3cgaGFuZGxlcjog4oCcaGFuZGxlX2VkZ2Vf?=
 =?utf-8?b?aXJx4oCdIHZzIOKAnGhhbmRsZV9sZXZlbF9pcnHigJ0=?=
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Hongfei Cheng <hongfei@mperpetuo.com>
Cc: xenomai@xenomai.org

On Wed, May 13, 2015 at 12:55:46AM -0700, Hongfei Cheng wrote:
> Hi All,
> 
> In the document of "Porting Xenomai dual kernel to a new ARM SoC",
> section "flow handler" states: If the flow handler is
> “handle_edge_irq”, and the system locks up when the first interrupt
> happens, try replacing “handle_edge_irq” with “handle_level_irq”.
> 
> Could anyone explain why “handle_edge_irq” can cause system to hang
> while “handle_level_irq” doesn't? I searched the archives but failed
> to find any discussion on this topic.

level irqs are acked and masked at interrupt controller level on
entry, whereas edge interrupts are only acked. The Adeos patch
unmasks the irqs at processor level after this initial ack and mask
or ack. So, if the interrupt controller keeps the interrupt asserted
at the processor level when the level stays the same (IOW, if the
interrupt controller only supports the "level" behaviour), unmasking
the interrupt line will cause the interrupt to trigger again, being
ack again, etc... without any chance for the handler to ack the
interrupt at device level. The fix is to use handle_level_irq so
that the irq is masked at interrupt controller level before irqs are
unmasked at processor level.

This does not happen with an unpatched kernel, because irqs are not
unmasked at processor level until the handler has had a chance to
execute and ack the interrupt at device level.

-- 
					    Gilles.

