Date: Fri, 20 Nov 2015 18:52:36 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20151120175236.GE2972@hermes.click-hack.org>
References: <trinity-acdda77f-4051-47ce-9404-d613a031eb17-1448033646319@3capp-webde-bap51>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <trinity-acdda77f-4051-47ce-9404-d613a031eb17-1448033646319@3capp-webde-bap51>
Subject: Re: [Xenomai] rtdm_lock_get_irqsave question
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: JK.Behnke@web.de
Cc: xenomai@xenomai.org

On Fri, Nov 20, 2015 at 04:34:06PM +0100, JK.Behnke@web.de wrote:
>    Hello,
> 
>    my understanding of rtdm_lock_get_irqsave is, that it disables all
>    interrupts (maybe except NMI).
>    If a rtdm driver uses this function to disable interrupts for too long
>    and meanwhile some device
>    generates more than one interrupt, at least one interrupt might get
>    lost.
>    Is that true?
> 
>    I'm running xenomai on an x86 based target (Atom E660 1.3 GHz) and
>    suspect that
>    one of our rtdm drivers disables interrupts for an unneccessary long
>    time.
>    I measured max lock times of up to 290 us, which is quite a long time.
>    I know this is not easy to answer, but is there a rule of thumb on how
>    long interrupts
>    might be disabled before running into problems?

If someone disables interrupt for 290us and a task on the same cpu
runs with a 100us period, it will miss some periods. So it all
depends on the worst case latency your system needs.

-- 
					    Gilles.
https://click-hack.org

