Date: Mon, 22 Feb 2016 18:44:21 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20160222174421.GD7398@hermes.click-hack.org>
References: <E1aXuTj-0000rZ-UQ@sd-51317.xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1aXuTj-0000rZ-UQ@sd-51317.xenomai.org>
Subject: Re: [Xenomai] [Xenomai-git] Jan Kiszka : boilerplate: Allow for
 enabling Xenomai only in shared libs
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org
Cc: xenomai-git@xenomai.org

On Mon, Feb 22, 2016 at 06:40:59PM +0100, git repository hosting wrote:
> Module: xenomai-jki
> Branch: for-forge
> Commit: 4601286f7fedb8267ea314584fc68d2b35b818a4
> URL:    http://git.xenomai.org/?p=xenomai-jki.git;a=commit;h=4601286f7fedb8267ea314584fc68d2b35b818a4
> 
> Author: Jan Kiszka <jan.kiszka@siemens.com>
> Date:   Fri Feb  5 17:33:18 2016 +0100
> 
> boilerplate: Allow for enabling Xenomai only in shared libs
> 
> Normally, one builds shared libraries with Xenomai awareness by adding
> --no-auto-init to xeno-config. This drops bootstrap.o from the linking
> steps because - normally - the main application performs the
> initialization.
> 
> However, if the main application is Xenomai-free and only dlopen() would
> pull in Xenomai services via a shared library, we face two problems:
> 
> - bootstrap.o is not built with position-independence support
> 
> - libboilerplate contains __real_main that expects the main symbol which
>   cannot be found from a shared library

Does not the library find the program symbols if RTLD_GLOBAL is
passed to dlopen?

-- 
					    Gilles.
https://click-hack.org

