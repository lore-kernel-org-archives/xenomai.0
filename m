Date: Mon, 3 Nov 2014 18:27:46 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141103172746.GK9327@sisyphus.hd.free.fr>
References: <20141103160223.GE9327@sisyphus.hd.free.fr>
 <314E5ECDAA86314791309FA670550F89C6762910@SINTEFEXMBX05.sintef.no>
 <20141103162457.GF9327@sisyphus.hd.free.fr>
 <314E5ECDAA86314791309FA670550F89C676297E@SINTEFEXMBX05.sintef.no>
 <20141103164433.GG9327@sisyphus.hd.free.fr>
 <314E5ECDAA86314791309FA670550F89C67629F0@SINTEFEXMBX05.sintef.no>
 <20141103170220.GH9327@sisyphus.hd.free.fr>
 <314E5ECDAA86314791309FA670550F89C6762A5E@SINTEFEXMBX05.sintef.no>
 <20141103171338.GI9327@sisyphus.hd.free.fr>
 <314E5ECDAA86314791309FA670550F89C6762AC3@SINTEFEXMBX05.sintef.no>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <314E5ECDAA86314791309FA670550F89C6762AC3@SINTEFEXMBX05.sintef.no>
Subject: Re: [Xenomai] Xenoma 2.6.4 missing posix/xeno_config.h ?
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

On Mon, Nov 03, 2014 at 05:25:52PM +0000, Terje Frøysa wrote:
> Thanks Gilles,
> I am truly grateful for your patience.
> 
> The kernel headers as well as the -l (that I overlooked) is now taken away.
> However, I guess I still am missing a library path as I now end up with three undefined references.

That is because you are using the native API, not the posix API, so
you should pass --skin=native to xeno-config. If you are using both
the posix and native skins, you need to add flags for both.

-- 
					    Gilles.

