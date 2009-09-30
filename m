MIME-Version: 1.0
Sender: peter.soetens@domain.hid
In-Reply-To: <4AC2448B.1080500@domain.hid>
References: <4AC2448B.1080500@domain.hid>
From: Peter Soetens <peter@domain.hid>
Date: Wed, 30 Sep 2009 16:10:44 +0200
Message-ID: <634c78ce0909300710i6d30b905kafdf7d76b2b31c7c@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai-core] RFC: 2.5 todo list.
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai core <Xenomai-core@domain.hid>

On Tue, Sep 29, 2009 at 19:31, Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org> wrote:
>
> Hi guys,
>
> full of energy after this tremendous first XUM, I would like to start a
> discussion about what people would like to see in the 2.5 branch.

So if we answer positively, we'll delay the release ? I'd rather get
2.5 out, and develop any new stuff on 2.6. I would also expect that
this list (or part of ) goes to xenomai-help too.

>
> Here is a first list, please feel free to criticize it:
> - signals in primary domain (something that we almost forgot)

I refrain from using signals in my apps. They only cause disaster when
using 3rd party libraries. Only Ctrl-C (quit) and debugger signals are
used, and a switch from primary to secondary is perfectly acceptable
in these two cases.

> - xnsynch_acquire using atomic_cmpxchg unconditionally (no #ifdefs)

This is too core for me.

> - statistics of all mapped named heaps in /proc/xenomai/heap

Don't use heaps since we do all in user space (and I had the
impression that heap was for kernel<->user.)

> - unwapped access to user-space posix skin methods

I wouldn't know why I need this. Do you we link with libpthread
instead of libpthread-rt ?

> - fast semaphores in user-space

I donn't know why I wouldn't need this.

> - syscall-less select ?

Since a syscall is not per-se bad (?) I also don't see what to win here.

>
> Actually, there are already a lot of things.
> So, what do you think?

I'm uttermost concerned with stability and to a lesser extent
performance. I regard every feature change as changing those two
criteria for the worse (unless its a feature that fixes a bug).

The kernel and libc are already a moving targets which influence
Xenomai, so we already have to cope with changes more than we want to.

Peter (non-authorative, non-developer)

