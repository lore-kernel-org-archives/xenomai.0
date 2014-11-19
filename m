Date: Wed, 19 Nov 2014 11:23:52 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141119102352.GC25848@sisyphus.hd.free.fr>
References: <314E5ECDAA86314791309FA670550F89C9C3743B@SINTEFEXMBX05.sintef.no>
 <20141119082140.GX3177@sisyphus.hd.free.fr>
 <314E5ECDAA86314791309FA670550F89C9C3972E@SINTEFEXMBX05.sintef.no>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <314E5ECDAA86314791309FA670550F89C9C3972E@SINTEFEXMBX05.sintef.no>
Subject: Re: [Xenomai] xnintr_irq_handler: IRQ135 not handled. Disabling IRQ
 line.
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Terje =?utf-8?Q?Fr=C3=B8ysa?= <Terje.Froysa@sintef.no>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Wed, Nov 19, 2014 at 10:19:57AM +0000, Terje Frøysa wrote:
> Thanks Gilles,
> 
> I will check if I have spurious interrupts..

Check your irq handler to see in which case it returns RTDM_IRQ_NONE.

> 
> 
> By the way:
> 
> I would like to use the function " rtdm_clock_read_monotonic()" from user space.
> 
> The Xenomai doxygen API states that the function can called from User-space task (RT, non-RT) but nothing else.
> I have googled it, but it is difficult to find what includefile and library is needed.

No, the doxygen documentation says that the function may be called
from the context of a user-space threads, that is a bit different,
Philippe considers this a bug in the documentation. Anyway, you can
not use the RTDM skin in user-space, the RTDM skin is for drivers
only (RTDM means "Real-Time Drivers Model"). For user-space, you have
other skins, including the native and posix ones.

With the POSIX skin, to read the monotonic clock, you would use:
clock_gettime(CLOCK_MONOTONIC, &ts);

-- 
					    Gilles.

