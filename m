Date: Mon, 3 Nov 2014 13:26:02 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141103122602.GB7705@sisyphus.hd.free.fr>
References: <314E5ECDAA86314791309FA670550F89C6762243@SINTEFEXMBX05.sintef.no>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <314E5ECDAA86314791309FA670550F89C6762243@SINTEFEXMBX05.sintef.no>
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

On Mon, Nov 03, 2014 at 11:44:47AM +0000, Terje Frøysa wrote:
> Dear forum,
> 
> The file xenomai/posix/stdio.h
> includes a file named xeno_config.h
> 
> This file does not exist in my newly installed 2.6.4 Xenomai environment.
> 
> Listing from make:
> 
> debian@beaglebone:~/rtdm_dht11-app$ make
> gcc -Wall -g -I/lib/modules/3.8.13-bone67/source/include/xenomai -I/lib/modules/3.8.13-bone67/source/include/xenomai/posix -I/lib/modules/3.8.13-bone67/source/arch/arm/mach-omap2 -c rtdm_dht11-app.c  -o rtdm_dht11-app.o
> 
> In file included from rtdm_dht11-app.c:46:0:
> /lib/modules/3.8.13-bone67/source/include/xenomai/posix/stdio.h:30:25: fatal error: xeno_config.h: No such file or directory
> compilation terminated.

Your compilation flags are obviously incorrect, to obtain the
correct ones, see:

http://xenomai.org/2014/08/porting-a-linux-application-to-xenomai-dual-kernel/#Compilation_flags

Regards.

-- 
					    Gilles.

