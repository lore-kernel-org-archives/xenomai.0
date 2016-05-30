Date: Mon, 30 May 2016 17:20:43 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20160530152043.GE17483@hermes.click-hack.org>
References: <E1b7OM2-0000oL-Q7@sd-51317.xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1b7OM2-0000oL-Q7@sd-51317.xenomai.org>
Subject: Re: [Xenomai] [Xenomai-git] Jan Kiszka : lib/cobalt: Provide
	RT-capable usleep
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

On Mon, May 30, 2016 at 04:39:42PM +0200, git repository hosting wrote:
> Module: xenomai-jki
> Branch: for-forge
> Commit: ec9a8c81944d4a3e3f50af314fa58ade68dd28c2
> URL:    http://git.xenomai.org/?p=xenomai-jki.git;a=commit;h=ec9a8c81944d4a3e3f50af314fa58ade68dd28c2
> 
> Author: Jan Kiszka <jan.kiszka@siemens.com>
> Date:   Mon May 30 14:58:07 2016 +0200
> 
> lib/cobalt: Provide RT-capable usleep
> 
> User may expect this (probably last) sleeping service to be available
> under Cobalt just like sleep, nanosleep & Co.

CONFORMING TO
       4.3BSD,  POSIX.1-2001.   POSIX.1-2001  declares this function obsolete;
       use nanosleep(2) instead.  POSIX.1-2008 removes  the  specification  of
       usleep().

-- 
					    Gilles.
https://click-hack.org

