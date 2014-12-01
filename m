Date: Mon, 1 Dec 2014 08:34:33 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141201073433.GR2964@hermes>
References: <314E5ECDAA86314791309FA670550F89C9C4FD8A@SINTEFEXMBX05.sintef.no>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <314E5ECDAA86314791309FA670550F89C9C4FD8A@SINTEFEXMBX05.sintef.no>
Subject: Re: [Xenomai] WARNING: at arch/arm/kernel/ipipe.c:157
 ipipe_set_irq_affinity+0x47/0x70()
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

On Mon, Dec 01, 2014 at 05:54:36AM +0000, Terje Frøysa wrote:
> Dear Forum,
> 
> Occasionally I get the warning listed below on my Beaglebone Black
> console. I am running Debian 3.8.13-bone67 with Xenomai 2.6.4
> 
> I am running four RTDM modules handling interrupts from GPIO pins.
> 
> As far as I have found, this kind of warnings can be associated
> with inappropriate calls from user space. But I cannot find such
> calls in my code. The irq is requested by a RTDM kernel module
> when issuing a device open call from user space.

Yes, there are several such issues in Xenomai 2.x. Note however that
the Beaglebone is uniprocessor, whereas ipip_set_irq_affinity is
called when CONFIG_SMP was enabled. Enabling CONFIG_SMP for an
uniprocessor is not recommended with Xenomai 2.x, as it gives
slightly worst performances.

-- 
					    Gilles.

