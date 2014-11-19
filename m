Resent-Message-ID: <20141119121246.GD29491@sisyphus.hd.free.fr>
Resent-To: xenomai@xenomai.org
Date: Wed, 19 Nov 2014 13:08:41 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141119120841.GC29491@sisyphus.hd.free.fr>
References: <314E5ECDAA86314791309FA670550F89C9C3743B@SINTEFEXMBX05.sintef.no>
 <20141119082140.GX3177@sisyphus.hd.free.fr>
 <314E5ECDAA86314791309FA670550F89C9C3972E@SINTEFEXMBX05.sintef.no>
 <20141119102352.GC25848@sisyphus.hd.free.fr>
 <314E5ECDAA86314791309FA670550F89C9C397B8@SINTEFEXMBX05.sintef.no>
 <20141119104519.GD25848@sisyphus.hd.free.fr>
 <314E5ECDAA86314791309FA670550F89C9C39892@SINTEFEXMBX05.sintef.no>
 <20141119115136.GA29491@sisyphus.hd.free.fr>
 <314E5ECDAA86314791309FA670550F89C9C39937@SINTEFEXMBX05.sintef.no>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <314E5ECDAA86314791309FA670550F89C9C39937@SINTEFEXMBX05.sintef.no>
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

Please keep the conversation on the list. I will simply not answer
the next mail you send me privately.

On Wed, Nov 19, 2014 at 12:01:55PM +0000, Terje Frøysa wrote:
> Ok Gilles, thanks.
> 
> The glibc confirms that the tv_nsec is a long int (4-bytes in ARM)
> while the time returned by the driver is 8-byte (utint64_t).

Yes tv_nsec is 4 bytes
but tv_sec is 4 more bytes god damn it

1000000000ULL * ts->tv_sec + ts->tv_nsec

will give you an 8 bytes values

The glibc documentation says:
The struct timespec structure represents an elapsed time. It is declared in time.h and has the following members:

long int tv_sec

    This represents the number of whole seconds of elapsed time.
long int tv_nsec

    This is the rest of the elapsed time (a fraction of a second), represented as the number of nanoseconds. It is always less than one billion.

Did you even bother to read that documentation?

Are you for real? Or is this a prank?

Please keep the conversation on the list. I will simply not answer
the next mail you send me privately.

-- 
					    Gilles.

