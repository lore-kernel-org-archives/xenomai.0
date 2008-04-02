Message-ID: <2ff1a98a0804020804r2e254151oe00c7669566a256@domain.hid>
Date: Wed, 2 Apr 2008 17:04:24 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <0B45E93C5FF65740AEAE690BF3848B7AD381F8@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <0B45E93C5FF65740AEAE690BF3848B7AD381F8@domain.hid>
Subject: Re: [Xenomai-core] [PATCH] glibcism in src/skins/posix/thread.c
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Fillod Stephane <stephane.fillod@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

On Wed, Apr 2, 2008 at 4:56 PM, Fillod Stephane
<stephane.fillod@domain.hid> wrote:
> Hi,
>
>  Here's attached a patch working around a glibcism. It is necessary
>  for uClib environment. The patch is against Xenomai 2.4.3.

Already fixed in trunk, forgot to apply the patch to the v2.4.x
branch. Note that your patch is slightly incorrect:
- it runs strstr in an uninitialized string;
- the result on platforms without _CS_GNU_LIBPTHREAD_VERSION is
linuxthreads == 0 whereas we really want linuxthreads == 1.



-- 
 Gilles

