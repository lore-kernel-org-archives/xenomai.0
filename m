Date: Mon, 3 Nov 2014 17:24:57 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141103162457.GF9327@sisyphus.hd.free.fr>
References: <314E5ECDAA86314791309FA670550F89C6762243@SINTEFEXMBX05.sintef.no>
 <20141103122602.GB7705@sisyphus.hd.free.fr>
 <314E5ECDAA86314791309FA670550F89C67627E4@SINTEFEXMBX05.sintef.no>
 <20141103153617.GD9327@sisyphus.hd.free.fr>
 <314E5ECDAA86314791309FA670550F89C6762872@SINTEFEXMBX05.sintef.no>
 <20141103160223.GE9327@sisyphus.hd.free.fr>
 <314E5ECDAA86314791309FA670550F89C6762910@SINTEFEXMBX05.sintef.no>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <314E5ECDAA86314791309FA670550F89C6762910@SINTEFEXMBX05.sintef.no>
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

On Mon, Nov 03, 2014 at 04:21:53PM +0000, Terje Frøysa wrote:
> Thanks again for your quick replies :-)
> 
> Yes, I have the files in question in the /usr/include directory.
> 
> debian@beaglebone:/usr/include$ ls -l st*
> :
> -rw-r--r-- 1 root root  8536 Oct 17 02:40 stdint.h
> -rw-r--r-- 1 root root 31525 Oct 17 02:41 stdio.h
> -rw-r--r-- 1 root root  2873 Oct 17 02:40 stdio_ext.h
> -rw-r--r-- 1 root root 34254 Oct 17 02:40 stdlib.h
> -rw-r--r-- 1 root root 22612 Oct 17 02:41 string.h
> :
> 
> The time.h refers the clockid_t, but no file in the /usr/include (and subdirectories) holds a definition.
> 
> The types.h file defines the __clockid_t, but I can't find the 'clockid_t' defined anywhere:
> 
> /* Clock ID used in clock and timer functions.  */
> __STD_TYPE __CLOCKID_T_TYPE __clockid_t;

This is normally defined in /usr/include/time.h

#if !defined __clockid_t_defined && \
   ((defined _TIME_H && defined __USE_POSIX199309) || defined __need_clockid_t)
# define __clockid_t_defined    1

# include <bits/types.h>

/* Clock ID used in clock and timer functions.  */
typedef __clockid_t clockid_t;

#endif /* clockid_t not defined and <time.h> or need clockid_t.  */
#undef  __clockid_time_t

And xenomai's time.h does #include_next <time.h> which should
include that file and get the definition.

-- 
					    Gilles.

