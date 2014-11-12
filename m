Date: Wed, 12 Nov 2014 21:39:22 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141112203922.GJ17476@sisyphus.hd.free.fr>
References: <314E5ECDAA86314791309FA670550F89C676CD2D@SINTEFEXMBX05.sintef.no>
 <20141111140230.GA17476@sisyphus.hd.free.fr>
 <314E5ECDAA86314791309FA670550F89C676CE2D@SINTEFEXMBX05.sintef.no>
 <314E5ECDAA86314791309FA670550F89C676E884@SINTEFEXMBX05.sintef.no>
 <20141112134531.GP17476@sisyphus.hd.free.fr>
 <314E5ECDAA86314791309FA670550F89C676EB35@SINTEFEXMBX05.sintef.no>
 <20141112145117.GV17476@sisyphus.hd.free.fr>
 <314E5ECDAA86314791309FA670550F89C676EBE1@SINTEFEXMBX05.sintef.no>
 <20141112151305.GW17476@sisyphus.hd.free.fr>
 <314E5ECDAA86314791309FA670550F89C676F428@SINTEFEXMBX05.sintef.no>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <314E5ECDAA86314791309FA670550F89C676F428@SINTEFEXMBX05.sintef.no>
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

On Wed, Nov 12, 2014 at 08:33:41PM +0000, Terje Frøysa wrote:
> Hello again Gilles,
> 
> Before patching, I just have to check:
> 
> The batch below refers to a path in the xenomai-2.6.4 directory:
>  /ksrc/drivers/serial/16550A_io.h
> 
> There also exist a corresponding source at the Linux kernel directory:
> bb-kernel/KERNEL/drivers/xenomai/serial/16550A_io.h
> 
> Since the xeno_16550A is enabled in the kernel make menuconfig or included as a loadable module in the kernel,
> I would assume that the patch is to be applied in the kernel source?
> (and then rebuild the kernel?)


If you have used prepare-kernel.sh to generate the kernel sources,
the second is a symbolic link to the first, so you just patch the
first, recompile the kernel, and try and boot it. If it is not a
symbolic link, then yes, you need to apply the patch to the kernel
sources, patch will not find the file and tell you to enter the file
name manually.

-- 
					    Gilles.

