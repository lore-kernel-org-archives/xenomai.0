Date: Sun, 20 Mar 2016 08:59:38 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20160320075938.GG3345@hermes.click-hack.org>
References: <DB5PR06MB1109ECFBDA54A3B1A11457608F8E0@DB5PR06MB1109.eurprd06.prod.outlook.com>
 <20160320072520.GF3345@hermes.click-hack.org>
 <DB5PR06MB110995B3101666B866BB93C28F8E0@DB5PR06MB1109.eurprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB5PR06MB110995B3101666B866BB93C28F8E0@DB5PR06MB1109.eurprd06.prod.outlook.com>
Subject: Re: [Xenomai] Suggested approach to schedule N-RT work in kernel on
 a specific CPU core
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Alex Plits <alex_plits@radwin.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Sun, Mar 20, 2016 at 07:49:16AM +0000, Alex Plits wrote:
> 
> 
> > -----Original Message-----
> > From: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org]
> > If the Linux kernel provides a function to do this, we could implement a
> > function mirroring that function in the RTDM API. Looks simple. Am I missing
> > something ?
> > 
> 
> [Alex Plits] The Linux provides an option to configure the workQ
> on specific CPU's on it's initialization stage of the WorkQ. I'm
> unsure Of how/whether it actually schedules it's execution when
> schedule_work is called from a different CPU core that it was
> configured up-on.

I doubt very much this does not work. Have you tried it and observed
that it does not work?



> I'm guessing that if it were trivial the same
> mechanism would also be used in the current API for N-RT or
> xenomai printk mechanism (both use dedicated workQs which are
> different than Linux WorkQs awaken via VIRQs).

There is no xenomai printk mechanism. printk is implemented by the
I-pipe patch, a layer below Xenomai, so can not use an RTDM service.
Besides, the I-pipe patch printk implementation predates
ipipe_post_work_root.

The way RTDM work works is with the ipipe_post_work_root service,
so it does not use virqs, and since the schedule_work gets invoked
in a plain linux context, anything which works with schedule_work
(like triggering a work queue on a different cpu) should work with
the RTDM service.

So, again, have you tried running the RTDM service with a work queue
pinned on a different cpu and observed that it did not work?

-- 
					    Gilles.
https://click-hack.org

