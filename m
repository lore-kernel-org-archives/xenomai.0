Date: Wed, 19 Nov 2014 11:45:19 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141119104519.GD25848@sisyphus.hd.free.fr>
References: <314E5ECDAA86314791309FA670550F89C9C3743B@SINTEFEXMBX05.sintef.no>
 <20141119082140.GX3177@sisyphus.hd.free.fr>
 <314E5ECDAA86314791309FA670550F89C9C3972E@SINTEFEXMBX05.sintef.no>
 <20141119102352.GC25848@sisyphus.hd.free.fr>
 <314E5ECDAA86314791309FA670550F89C9C397B8@SINTEFEXMBX05.sintef.no>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <314E5ECDAA86314791309FA670550F89C9C397B8@SINTEFEXMBX05.sintef.no>
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

On Wed, Nov 19, 2014 at 10:43:30AM +0000, Terje Frøysa wrote:
> As far as I can see, the clock_gettime(CLOCK_MONOTONIC, &ts)
> delivers the "struct  timespec" which contains "only" a 32-bit (ns) time.

You wee wrong. Look better at the struct timespec.

-- 
					    Gilles.

