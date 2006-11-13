Message-ID: <822467320611130839q7f21cc78m3618199e0e04ba94@domain.hid>
Date: Mon, 13 Nov 2006 09:39:05 -0700
From: "Terry Laurenzo" <tlaurenzo@domain.hid>
Subject: Re: Re: [Xenomai-core] Undefined reference to
	___wrap_pthread_mutex_lock and friends on Blackfin
In-Reply-To: <4558339F.5070500@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <822467320611121613u2cbcd224nc3afedd43d4b4463@domain.hid>
	<4558339F.5070500@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On 11/13/06, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote:
> Terry Laurenzo wrote:
> > Hello.  I'm new to this list and new to Xenomai.  I am getting the
> > following when trying to build Xenomai 2.2.3:
> >
> > -------------
> > cyclictest.elf2flt(.text+0x4946): In function `_pthread_key_delete':
> > : undefined reference to `___wrap_pthread_mutex_lock'
> > cyclictest.elf2flt(.text+0x4970): In function `_pthread_key_delete':
> > : undefined reference to `___wrap_pthread_mutex_unlock'
> > cyclictest.elf2flt(.text+0x49c8): In function `_pthread_key_delete':
> > : undefined reference to `___wrap_pthread_mutex_unlock'
> > cyclictest.elf2flt(.text+0x49e8): In function `_pthread_key_create':
> > : undefined reference to `___wrap_pthread_mutex_lock'
> > cyclictest.elf2flt(.text+0x4a10): In function `_pthread_key_create':
> > : undefined reference to `___wrap_pthread_mutex_unlock'
> > cyclictest.elf2flt(.text+0x4a2e): In function `_pthread_key_create':
> > : undefined reference to `___wrap_pthread_mutex_unlock'
> > collect2: ld returned 1 exit status
> > -------------
> >
> > The problem seems to be that the version of libpthread.a that I am
> > using makes reference to the pthread_mutex_lock and
> > pthread_mutex_unlock functions from a couple of places including
> > pthread_key_create and pthread_key_delete.
>
> The problem is that pthread_key_create and pthread_key_delete should use
> the libpthread.a versions of pthread_mutex_lock and pthread_mutex_unlock
> not xenomai versions. In order to avoid this, you have to do the
> link-edit in two stages: first do a partial link with libpthread_rt.a
> with the --wrap options, second a final link with libpthread.a without
> the --wrap options.

Since this is an issue in the main build of xenomai, any suggestions
on what the proper fix is?  Should libpthread be linked with
libpthread_rt during the main library build or just for the individual
(testsuite) programs that use it?  Does anyone have an example of some
additions to the Automake rules to carry out this two step process?

> > Applying the patch makes it build but the testsuites for the Posix
> > skin don't seem to work.  For example, here is what I get when trying
> > to run cyclictest:
> >  root:/usr/xenomai/testsuite/cyclic> ./cyclictest
> >  Xenomai Posix skin init: pthread_atfork: Unknown error -1
>
> Maybe pthread_atfork is not working at all on uclibc ?

uclibc does not have a working fork, so I can't imagine that this
behavior is required.  I think that the problem, however, is in the
way that I "solved" the build problem.  Now, since libpthread is
linking against the libpthread_rt wrapped version of mutex_lock and
mutex_unlock, it is potentially causing problems since the internals
of libpthread were supposed to link against the unwrapped versions.
This will probably fix itself if the link-edit step is inserted
correctly.

Thanks for the replies.
Terry

