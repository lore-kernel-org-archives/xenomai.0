Date: Thu, 13 Nov 2014 09:22:31 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141113082231.GC4656@sisyphus.hd.free.fr>
References: <314E5ECDAA86314791309FA670550F89C676EB35@SINTEFEXMBX05.sintef.no>
 <20141112145117.GV17476@sisyphus.hd.free.fr>
 <314E5ECDAA86314791309FA670550F89C676EBE1@SINTEFEXMBX05.sintef.no>
 <20141112151305.GW17476@sisyphus.hd.free.fr>
 <314E5ECDAA86314791309FA670550F89C676FC45@SINTEFEXMBX05.sintef.no>
 <20141113072118.GL17476@sisyphus.hd.free.fr>
 <314E5ECDAA86314791309FA670550F89C676FCFC@SINTEFEXMBX05.sintef.no>
 <20141113075616.GA4656@sisyphus.hd.free.fr>
 <20141113080229.GB4656@sisyphus.hd.free.fr>
 <314E5ECDAA86314791309FA670550F89C676FDC4@SINTEFEXMBX05.sintef.no>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <314E5ECDAA86314791309FA670550F89C676FDC4@SINTEFEXMBX05.sintef.no>
Subject: Re: [Xenomai] xeno_16550A driver install problems.
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Terje =?utf-8?Q?Fr=C3=B8ysa?= <Terje.Froysa@sintef.no>
Cc: "Xenomai@xenomai.org" <Xenomai@xenomai.org>

On Thu, Nov 13, 2014 at 08:20:16AM +0000, Terje Frøysa wrote:
> Ok Gilles,
> 
> Worked until enabled xeno_16550A by kernel parameters.
> Can you see anything wrong here?

You need to pass regshift and regwidth parameter, regshift=2 and
regwidth=2 

-- 
					    Gilles.

