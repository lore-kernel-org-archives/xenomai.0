References: <CAO0fa7Y7gYg_xP3WtJiYXed_RRnEpbazLMuz5riFK0EsTiJKMQ@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: Running Xenomai2 binaries on Xenomai3
In-reply-to: <CAO0fa7Y7gYg_xP3WtJiYXed_RRnEpbazLMuz5riFK0EsTiJKMQ@mail.gmail.com>
Date: Sun, 20 Dec 2020 19:47:01 +0100
Message-ID: <877dpcwc0q.fsf@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Drew <pythondrew@gmail.com>
Cc: xenomai@xenomai.org


Drew via Xenomai <xenomai@xenomai.org> writes:

> We have a Xenomai2 based project that is being shifted to Xenomai3. It used
> the native skin. (Beaglebone black, crusty 3.8.13-xenomai kernel)
>
> I created a tiny libnative.so file that allows me to run my unmodified
> xenomai2 binary images on xenomai3.. I also added a symlink called
> libxenomai.so.0 that seems to work if pointed at any used xenomai shared
> object. (those are the two shared libraries the old binaries look for.)
> I put them in /usr/lib where our old binaries look for them. My libnative
> looks for the other libs in their new location by building using --rpath.
>
> I just built the library to load in alchemy, cobalt, copperplate, and
> modechk when I linked my library. Our binaries find the needed methods via
> this libnative, and seem to be running fine.
>
> Well, they find *most* of the calls. Four of them were "static inline" in
> .h files, so I just called the inline functions, wrapped with a different
> name to avoid a redefinition at compile time. Then I used objcopy to rename
> the exported functions so they are the same as the static inline function
> names that disappeared in the new API.

As a result, I just kicked out the few inlines from libevl so that
interposing on these API calls should be made easier.

>
> Why would I want to do this? I have software in the field that will
> download and try to run the xenomai2 binaries. I don't want that to break..
> I do want it to work transparently. My question, I guess, is.. well.. pick
> one or more response, or write your own.
>
> * Good lord, that's a terrible idea because <awful thing> will happen!
> * Good lord, that's a brilliant idea! why didn't we do that in Xenomai3? Ok
> if we use it? <why sure!>
> * I'm glad it seems to work for you, but we really couldn't do that in
> general because <totally valid reason why.>
> * This is already supported in Xenomai3. you haven't read the docs, have
> you? To do this you only needed to <link to doc I didn't see>.
> * This idea isn't new. You haven't been up to date on the mailing list,
> have you? <link to someone else already doing/trying/having issues with
> this.>

It's a brilliant although terrible idea which I'm glad works for you
because this has never been meant to be supported by Xenomai 3.

This said, ABI compat is a must for some deployments, this is why there
is a general consensus that we should try hard to guarantee it.

>
> My main worry *was* that Xenomai2 defined structures of one size (which the
> old binaries allocate) but the new xenomai made those structures bigger and
> now memory is being trashed. (not badly enough to cause trouble
> immediately, though.)
>
> I took a closer look at the sizeof the structs we used, just to make sure
> the sizes aren't a problem. What I found was one (the mutex) was reduced in
> size from 2->3..(was:12 bytes. is now: 4 bytes) The other things (cond,
> pipe, rtime, task) used the same amount of memory in 2 and 3.. so, it seems
> there is no issue there.
>

Alternatively, in order to avoid any issue of that kind, there might be
the option to allocate a complete shadow Xenomai 3/alchemy descriptor
for each object, referencing it from the space defined by the Xenomai
2/native ABI for holding their counterparts. There are a couple of
invariants you should be able to rely on for this:

- xnhandle_t is of long type, so a pointer would fit there.

- in x3, all object creation and deletion calls are deemed secondary
  mode operations, so there cannot be any real-time constraints on these
  (e.g. you might even call malloc()/free() there). You could
  alternatively use the real-time memory allocator libcopperplate
  provides under the hood (xnmalloc(), xnfree() see below).

e.g. Somewhere in the Xenomai 3 side of the universe:

typedef union {
      xnhandle_t x2_opaque;
      struct RT_COND *x3_object;
} RT_COND_SHIM;

#include <copperplate/heapobj.h>
#include <alchemy/cond.h>

int rt_cond_create_shim(RT_COND_SHIM *cond, ...)
{
        cond->x3_object = xnmalloc(sizeof(*RT_COND));
        return rt_cond_create(cond->x3_object, ...);
}

int rt_cond_delete_shim(RT_COND_SHIM *cond, ...)
{
        rt_cond_delete(cond->x3_object);
        xnfree(sizeof(cond->x3_object));
}

> Happy holidays! Stay safe!
>

Cheers,

-- 
Philippe.

