Date: Sat, 6 Dec 2014 15:25:12 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141206142512.GI10014@hermes.click-hack.org>
References: <471986235a5c47e395ece6b3d18830bd@EX132MBOX1A.de2.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <471986235a5c47e395ece6b3d18830bd@EX132MBOX1A.de2.local>
Subject: Re: [Xenomai] Sleeping function called from invalid context
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Stoidner, Christoph" <c.stoidner@arvero.de>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Sat, Dec 06, 2014 at 02:19:27PM +0000, Stoidner, Christoph wrote:
> 
> Hi at all,
> 
> I am using linux 3.10.18 and ipipe-core-3.10.18-arm-1 on a Freescale i.MX28. I have also merged PREEMPT RT rt14 into the kernel. FCSE is disabled.

If you have lockdep enabled, you should disable it, as it currently
does not work with xenomai on arm.

-- 
					    Gilles.

