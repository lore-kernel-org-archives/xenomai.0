Date: Tue, 7 Mar 2017 19:34:44 +0100
From: Henning Schild <henning.schild@siemens.com>
Message-ID: <20170307193444.79df74cd@md1em3qc>
In-Reply-To: <558D5FAD.3060003@siemens.com>
References: <558D5FAD.3060003@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Heads up: some race condition fixes for Xenomai 3
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>, Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

Am Fri, 26 Jun 2015 16:20:29 +0200
schrieb Jan Kiszka <jan.kiszka@siemens.com>:

> Hi,
> 
> just pushed 3 patches to git.xenomai.org/xenomai-jki.git for-forge
> that are supposed to fix race conditions while manipulating
> xnthread::state and info (both need to be nklock-protected). Please
> review if finding and fixes make sense.
> 
>       cobalt/kernel: Fix locking for xnthread info manipulations
>       cobalt/kernel: Fix locking for setting XNFPU
>       cobalt/kernel: Rework thread debugging helpers
> 
> Maybe some of the issues also exist in Xenomai 2, didn't check yet.

After looking deeper into the the mysterious -EINTR i asked about a few
days ago we now got a trace that suggests something is going wrong. Jan
remembered the race in thread flag manipulation he found in Xeno3.

I did not do a thorough code analysis yet but instead just put two
asserts into xnthread_set_info and xnthread_clear_info.
1. !xnlock_is_owner(&nklock)
2. xnpod_current_thread() != thread_to_update

Both cases do happen. The flags are manipulated without holding the
lock and the flags are manipulated from another context. I guess that
suggests that the race found in xenomai3 is also in xenomai2.

Henning


