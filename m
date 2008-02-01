From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18338.46934.267322.303918@domain.hid>
Date: Fri, 1 Feb 2008 07:08:22 +0100
In-Reply-To: <18338.15747.218667.236566@domain.hid>
References: <18338.15747.218667.236566@domain.hid>
Subject: Re: [Xenomai-core] [Patch] bre^H^H^H^H reworking self deletion,
	take 3.
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>, xenomai@xenomai.org

Gilles Chanteperdrix wrote:
 > 
 > Hi Philippe,
 > 
 > here comes a new patch on the theme "reworking self deletion". This
 > time, execution of nkpod delete hooks is made before the context switch
 > whereas finalizing the thread takes place after the context
 > switch. Special care has been taken to call xnfreesync before we run the
 > hooks, in order to avoid freeing the thread control block before the
 > finalization, and xnheap_t::idleq was made a per-cpu thing for the same
 > purpose.
 > 
 > I made a simple watchdog test with all debugs enabled, and
 > xnshadow_unmap did not complain.
 > 
 > If you are OK with this patch, I will rebase the unlocked context switch
 > patch on it.

Thinking a bit more about the unlocked context switch case: do we
tolerate that an ISR may delete a thread that is not current ? Because
if an ISR deleted a non current thread, we would not run the hooks over
the deleted thread context, so we would be again in the case where
xnshadow_unmap is not run by current. Besides, at first sight, it seems
to simplify greatly the case of the unlocked context switch.

-- 


					    Gilles Chanteperdrix.

