Message-ID: <4B15B246.3070007@domain.hid>
Date: Wed, 02 Dec 2009 01:18:14 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4B15AFC0.6020805@domain.hid>
In-Reply-To: <4B15AFC0.6020805@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [pull request] Signals support.
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Xenomai core <Xenomai-core@domain.hid>

Gilles Chanteperdrix wrote:
> Hi,
> 
> here come the pull request for user-space signals support. The simple 
> solution; handling signals upon system call return, has been implemented
> since the other solution (handling signals upon any return to 
> user-space) required to change the I-pipe patch, and so made the 
> upcoming 2.5 only compatible with newer patches.
> 
> We pass to kernel-space a sixth argument which is a pointer where 
> information about received signals is stored by kernel.
> 
> The only architecture for which the implementation is peculiar is 
> x86_32, because the register used as sixth argument is ebp, also used 
> for the libc backtrace function implementation, so I tried to find a 
> solution which makes backtracing still possible (otherwise we would have
> said bye-bye to involuntary mode changes chasing with SIGXCPU) without 
> breaking too many things.
> 
> A new test, creatively called sigtest allows to unit-test the signal
> support.
> 
> The following changes since commit 5a29ba38d7563097b73f53615fb3fcb7a7e5a6a5:
>   Philippe Gerum (1):
>         nucleus: initialize heap->stat_link holder
> 
> are available in the git repository at:
> 
>   git+ssh://git.xenomai.org/xenomai-gch.git for-head
> 
> Gilles Chanteperdrix (12):
>       bind: Replace bind.h with a convenience library.
>       skins: add per-skin user-space signal handler, and dispatch function.
>       arm: implement signals handling
>       powerpc: implement signals handling

This commit was credited to the wrong author, should be fixed now.

-- 
					    Gilles.

