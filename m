Date: Mon, 1 Dec 2014 09:50:28 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141201085028.GA21004@hermes>
References: <314E5ECDAA86314791309FA670550F89C9C4FD8A@SINTEFEXMBX05.sintef.no>
 <20141201073433.GR2964@hermes>
 <314E5ECDAA86314791309FA670550F89C9C5006D@SINTEFEXMBX05.sintef.no>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <314E5ECDAA86314791309FA670550F89C9C5006D@SINTEFEXMBX05.sintef.no>
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

On Mon, Dec 01, 2014 at 08:26:37AM +0000, Terje Frøysa wrote:
> Thanks Gilles,
> 
> I don't know why the debian kernel for the Sitara have SMP enabled.
> It sounds like a good idea to turn it off then...

Note that if you want to be able to recompile your kernel fast, you
should not be using a Debian kernel configuration anyway, but a
configuration with just the options you need enabled. This makes a
big difference on compilation time, a small difference on memory
footprint, and a big difference on root file system footprint.

-- 
					    Gilles.

