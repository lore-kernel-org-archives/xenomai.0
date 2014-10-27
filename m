Date: Mon, 27 Oct 2014 20:39:29 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141027193929.GC17539@sisyphus.hd.free.fr>
References: <314E5ECDAA86314791309FA670550F89C674EE64@SINTEFEXMBX05.sintef.no>
 <20141027133114.GB13005@sisyphus.hd.free.fr>
 <314E5ECDAA86314791309FA670550F89C674F1D1@SINTEFEXMBX05.sintef.no>
 <20141027184721.GA17539@sisyphus.hd.free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20141027184721.GA17539@sisyphus.hd.free.fr>
Subject: Re: [Xenomai] Compiling drivers for Xenomai 2.6.4 on Beaglebone
	Black
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

On Mon, Oct 27, 2014 at 07:47:21PM +0100, Gilles Chanteperdrix wrote:
> On Mon, Oct 27, 2014 at 04:40:02PM +0000, Terje Frøysa wrote:
> > Q1. Is the correct absolute path to the Xenomai includefiles: /usr/xenomai/include ?
> 
> It depends on the options you pass to xenomai user-space configure
> script, notably --prefix and --includedir, and of the DESTDIR
> variable you pass to the "make install" command, when
> cross-compiling.

Note that this is largely irrelevant, all you need to know is the
path to xeno-config, which will give you the flags to pass to the
compiler to include the correct files. This is also completely
irrelevant to kernel modules comilation, kernel modules are built
just like any other Linux kernel modules, they do not use the
Xenomai includefiles installed in the development environment, only
the copy present in the prepared kernel sources.

-- 
					    Gilles.

