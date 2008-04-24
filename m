Message-ID: <2ff1a98a0804240037x3d1146e1k31ef39f5c7260d8@domain.hid>
Date: Thu, 24 Apr 2008 09:37:51 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <48103245.4010202@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <18448.9649.956656.531081@domain.hid>
	<48103245.4010202@domain.hid>
Subject: Re: [Xenomai-core] [0/9] Posix skin user-space mutexes
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

On Thu, Apr 24, 2008 at 9:09 AM, Jan Kiszka <jan.kiszka@domain.hid> wrote:
> Gilles Chanteperdrix wrote:
>  > Hi,
>  >
>  > the patch series to come for review adds support for user-space mutexes to the
>  > posix skin. Since I wanted this support to be available on my AT91RM9200, the
>  > patch series start with patches which are mainly for the ARM architecture, to
>  > end with reimplementation of the kernel-space and user-space mutex services for
>  > the posix skin.
>
>  Cool stuff!
>
>
>  >
>  > Some patches brought some questions when making them, questions which will be
>  > discussed in the mail accompanying the patch.
>  >
>  > Since I do not use quilt, some patches will inevitably mix several
>  > modifications, especially the patch to ksrc/skins/posix/syscall.c. I promise,
>  > next time I will use quilt.
>  >
>  > The result has only be tested in the fast (no syscall) case, to evaluate its
>  > performance, I will start tests trying to cover the syscall case now, and keep
>  > you informed.
>
>  Central question (IMHO): Do you ensure that the kernel-side atomic op on
>   the mutex state can _never_ raise an exception? Or do you have some
>  atomic mechanism that can handle faults?

The atomic op takes place on memory allocated on a shared xnheap. So,
it is basically vmalloc or kmalloced memory in kernel-space and is
hence garanteed to not fault. In user-space, the kernel helper
(kuser_cmpxchg) used for handling atomic_cmpxchg on ARM pre v6 has
builtin support for handling exceptions (basically, the operation is
restarted upon exception). I do not know if it will be the case for
ARM v6 or other arches, but since we are using a mapped heap, I would
expect mlockall to save us.

-- 
 Gilles

