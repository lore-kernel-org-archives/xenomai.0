Message-ID: <4C095876.3060605@domain.hid>
Date: Fri, 04 Jun 2010 21:48:06 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <E1OKZdD-0003ml-45@domain.hid>
In-Reply-To: <E1OKZdD-0003ml-45@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [Xenomai-git] Jan Kiszka : native: Rework
 handling of pthread carrier thread
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

GIT version control wrote:
> Module: xenomai-jki
> Branch: for-upstream
> Commit: 0352b068600bd4ef3172c8a42416badbcdad32ca
> URL:    http://git.xenomai.org/?p=xenomai-jki.git;a=commit;h=0352b068600bd4ef3172c8a42416badbcdad32ca
> 
> Author: Jan Kiszka <jan.kiszka@domain.hid>
> Date:   Wed Apr 28 15:08:11 2010 +0200
> 
> native: Rework handling of pthread carrier thread
> 
> This patch improves two pitfalls of libnative's interaction with
> underlying pthreads:
> 
> First, it tries to detect double deletions (cancellations or joinings)
> of pthreads and report them via an error code. This reduces the risk to
> trigger a SIGSEGV accessing meanwhile released pthread objects. And
> second, it properly detaches joinable pthreads when they are deleted
> instead. This properly releases the pthread resources.

I really do not understand that. What is the point of creating a
joinable thread if you do not want to join it once it has been canceled?

-- 
					    Gilles.

