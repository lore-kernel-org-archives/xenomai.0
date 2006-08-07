Subject: Re: [Xenomai-help] rt_pipe and rt_queue problems
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <44D74228.20103@domain.hid>
References: <200608021808.18076@domain.hid> <44D0F72E.3020406@domain.hid>
	<200608031628.31584@domain.hid> <44D26C1C.5040506@domain.hid>
	<200608041345.6449@domain.hid> <44D4CC6C.1020709@domain.hid>
	<1154799634.4330.23.camel@domain.hid>
	<b647ffbd0608070603q61008d0emc3a6555b62a40cc2@domain.hid>
	<44D74228.20103@domain.hid>
Content-Type: text/plain
Date: Mon, 07 Aug 2006 16:05:40 +0200
Message-Id: <1154959541.4322.1.camel@domain.hid>
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
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Petr Cervenka <grugh@domain.hid>, xenomai@xenomai.org

On Mon, 2006-08-07 at 15:37 +0200, Jan Kiszka wrote:
> Dmitry Adamushko wrote:
> > Hello,
> > 
> > does this patch make a difference for you?
> > 
> > I haven't followed the whole conversation closely so it's just based on
> > Jan's trace.
> > 
> > Just a bit blind copy_and_past from __rt_queue_receive() I guess.
> > 
> 
> I guess someone should have posted a note that the issue was fixed (see
> SVN).

Ok, this was not terribly explicit, but I did:
https://mail.gna.org/public/xenomai-help/2006-08/msg00086.html

>  Now it's double-fixed. :)
> 
> Jan
> 
-- 
Philippe.



