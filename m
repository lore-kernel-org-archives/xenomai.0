Date: Mon, 26 Jan 2015 20:54:09 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150126195409.GA1491@hermes.click-hack.org>
References: <20150126190241.GA10160@bugfree>
 <20150126190911.GN12812@hermes.click-hack.org>
 <20150126195219.GA10959@bugfree>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150126195219.GA10959@bugfree>
Subject: Re: [Xenomai] Porting Xenomai on Odroid-U3
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Arnaud Degroote <arnaud.degroote@isae.fr>
Cc: xenomai@xenomai.org

On Mon, Jan 26, 2015 at 08:52:19PM +0100, Arnaud Degroote wrote:
> On 26/Jan - 20:09, Gilles Chanteperdrix wrote:
> > On Mon, Jan 26, 2015 at 08:02:41PM +0100, Arnaud Degroote wrote:
> > > Hi list,
> > > 
> > > I'm trying to port Xenomai on Odroid-U3. I read on the list that there
> > > is a first try by GP Orcullo, so I start from its work.
> > > 
> > > I'm working on a 3.17.8 kernel on which I ported the Ipipe / Xenomai
> > > patch. I validated it on two omaps platform where I don't see regression
> > > against previous version of the patch, so I'm fairly confident that the
> > > core part is correct. In a second time, I ported the previous effort of
> > > GP Orcullo. The current state of the effort is available on 
> > > 
> > > https://github.com/adegroote/linux/tree/linux-stable-xenomai-odroid-3.17.y
> > > 
> > > I tested without IPIPE, and with IPIPE. Troubles start with the XENOMAI
> > > option. Basically, the kernel seems to hangs when I load any "skin" (I
> > > compiled them in modules to be sure). For example, 
> > > 
> > > modprobe xeno-native
> > > 
> > > prints
> > > 
> > > Xenomai: starting native API services.	
> > > 
> > > but I cannot get back the shell prompt.
> > > 
> > > From the Troubleshooting part, I suppose something is wrong with the
> > > ipipe_timer, but I don't have much idea where to look for. 
> > > 
> > > Can someone give me some inputs about how to trace / debug this issue
> > > or/and quickly check if I miss something obvious in my patch.
> > > 
> > > https://github.com/adegroote/linux/commit/81c6ebeb3127efdceb3e31f9d3f1f400ecbb579f.patch
> > 
> > Well, you should put some printks in the timer code to see what is
> > the last action done. Is the ->ack function called, does it really
> > acknowledge the timer interrupt at timer level (because if it does
> > not, the interrupt will trigger again at the end of the current
> > interrupt).
> 
> Thanks Gilles,
> I will try tomorrow morning, when I will be back to work.
> > 
> > Could you post a link to the patched file handling the timer ?
> 
> The timer used is exynos-mct, available here
> 
> https://github.com/adegroote/linux/blob/linux-stable-xenomai-odroid-3.17.y/drivers/clocksource/exynos_mct.c

The ISR is wrong. The acknowledge should be skipped when the timer is
stolen, not the event handler.

-- 
					    Gilles.

