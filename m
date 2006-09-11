Subject: Re: [Xenomai-help] max size for pipes and rt-fifos?
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4505C732.5030507@domain.hid>
References: <44FF3A22.5060901@domain.hid> <44FFE509.3090009@domain.hid>
	<4500789C.9070804@domain.hid> <1157723967.4992.13.camel@domain.hid>
	<1157817917.5033.19.camel@domain.hid>  <4505C732.5030507@domain.hid>
Content-Type: text/plain
Date: Mon, 11 Sep 2006 23:15:00 +0200
Message-Id: <1158009300.4991.45.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jeff Webb <jeff.webb@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

On Mon, 2006-09-11 at 15:29 -0500, Jeff Webb wrote:
> Philippe Gerum wrote:
> > The following patch against stock 2.2.2 improves the RTAI fifo
> > emulation. It reduces the overhead induced by sending highly scattered
> > data over a short period of time, and basically provides a much saner
> > implementation.
> > 
> > I'd be interested to have some feedback about this; I plan to change the
> > data streaming mode of message pipes from the native API the same way.
> > TIA,
> 
> I applied this patch on my linux-2.6 and 2.4 systems.  The simple 'fifotestk.c' example I posted now works fine, with no apparent memory leaks.  I can now allocate a 128 MB RTAI FIFO, which sure beats 100 KB!  Thanks for the fix!
> 
> If I try to allocate a FIFO larger than the available vmalloc space, the rtf_create routine now fails with ENOMEM, which is much better than failing on the rtf_put call.  Unfortunately, the RT-FIFO device is now EBUSY forever.  I can switch to another device, and I can allocate space for my 128 MB FIFO once again, so that is good, at least.  Here is the printk output from my program:
> 

Mm, ok, I see: brain cell shortage on my side, hopefully temporary.
Please try the attached patch on top of the previous one.

--- ksrc/skins/rtai/fifo.c	(revision 1580)
+++ ksrc/skins/rtai/fifo.c	(working copy)
@@ -134,7 +134,7 @@
 	xnlock_get_irqsave(&nklock, s);
 
 	if (buffer == NULL) {
-		if (!err)
+		if (err >= 0)
 			/* First open, we need to disconnect upon
 			 * error. Caveat: we still hold the lock while
 			 * flushing the message pipe's input and

-- 
Philippe.



