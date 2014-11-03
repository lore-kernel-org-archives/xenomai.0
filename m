Date: Mon, 3 Nov 2014 18:02:20 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141103170220.GH9327@sisyphus.hd.free.fr>
References: <20141103122602.GB7705@sisyphus.hd.free.fr>
 <314E5ECDAA86314791309FA670550F89C67627E4@SINTEFEXMBX05.sintef.no>
 <20141103153617.GD9327@sisyphus.hd.free.fr>
 <314E5ECDAA86314791309FA670550F89C6762872@SINTEFEXMBX05.sintef.no>
 <20141103160223.GE9327@sisyphus.hd.free.fr>
 <314E5ECDAA86314791309FA670550F89C6762910@SINTEFEXMBX05.sintef.no>
 <20141103162457.GF9327@sisyphus.hd.free.fr>
 <314E5ECDAA86314791309FA670550F89C676297E@SINTEFEXMBX05.sintef.no>
 <20141103164433.GG9327@sisyphus.hd.free.fr>
 <314E5ECDAA86314791309FA670550F89C67629F0@SINTEFEXMBX05.sintef.no>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <314E5ECDAA86314791309FA670550F89C67629F0@SINTEFEXMBX05.sintef.no>
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

On Mon, Nov 03, 2014 at 04:58:52PM +0000, Terje Frøysa wrote:
> Thanks!
> 
> Here is the complete Makefile:

Please remove the include directive for kernel-space headers. I
think it should fix the issue.

-- 
					    Gilles.

