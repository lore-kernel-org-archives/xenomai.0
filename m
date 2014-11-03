Date: Mon, 3 Nov 2014 16:36:17 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141103153617.GD9327@sisyphus.hd.free.fr>
References: <314E5ECDAA86314791309FA670550F89C6762243@SINTEFEXMBX05.sintef.no>
 <20141103122602.GB7705@sisyphus.hd.free.fr>
 <314E5ECDAA86314791309FA670550F89C67627E4@SINTEFEXMBX05.sintef.no>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <314E5ECDAA86314791309FA670550F89C67627E4@SINTEFEXMBX05.sintef.no>
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

On Mon, Nov 03, 2014 at 03:34:47PM +0000, Terje Frøysa wrote:
> Thanks for your tip!
> 
> I tried out the suggested compilation flags and now all files were found.
> 
> However I ended with many "unknown type names":
> //usr/xenomai/include/posix/time.h:114:25: error: unknown type name 'clockid_t'
> //usr/xenomai/include/posix/time.h:133:5: error: unknown type name 'timer_t'
> //usr/xenomai/include/posix/sys/select.h:32:39: error: unknown type name 'fd_set'
> //usr/xenomai/include/posix/sys/socket.h:39:27: error: unknown type name 'socklen_t'
> 
> What may cause these missing typedefs when no files are missing?

Have you installed the glibc headers? These types are defined in
glibc headers.

-- 
					    Gilles.

