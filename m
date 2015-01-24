From: "Leopold Palomo-Avellaneda" <leo@alaxarxa.net>
Date: Sat, 24 Jan 2015 17:43:55 +0000
References: <129277905.Ag2XebZWbK@soho> <1498823.b61P0cr1E8@indiana>
 <54C283D9.8020403@xenomai.org>
In-Reply-To: <54C283D9.8020403@xenomai.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <201501241743.55843.leo@alaxarxa.net>
Subject: Re: [Xenomai] Packaging Xenomai-3
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

A Divendres, 23 de gener de 2015, Philippe Gerum va escriure:
[...]

> >>> 1) Is it possible to have _only_ one library (binary) that uses one or
> >>> another kernel in function which is running?
> >> 
> >> No. Definitely not.
> > 
> > Ok, it's too difficult to have it? Same lib that in runtime select the
> > interface to use? So, then someone could provide a binary, that depends
> > on the kernel will work with cobalt or mercury. The packagers would have
> > the life better.
> 
> Sure, but the maintainers would go nuts, which would not help the
> packagers in the end. Not to speak of the crappy performances on low-end
> hardware, due to the extra levels of encapsulation/indirection required.
> I don't see any reasonable way to implement this sanely and efficiently.
> We are chasing micro-second level optimization in some cases in the
> code, for running on CPUs with not-that-fast caches. In this user vs
> packager/maintainer trade-off, user must prevail.
>
> >>> 2) If not, as we must recompile the library, all the programs linked
> >>> against must be recompiled or if it's binary compatible?
> >> 
> >> Can't have the same ABI. Two separate builds are required.
> >> 
> > :-( it makes sense if they have different names? -c vc -m or whatever?
> 
> The same way we don't have /lib/libc64.so but /lib64/libc.so, I would
> rather suggest to use a different install root.


So, the situation is that we must have two libraries, that are compiled with 
two main differences (mercury, cobalt).

To have it in different directories is not an easy task if we want to put in 
the main distros. Also, ldd should find it, and for it, it should be int the 
standard ldd paths.

I think that it could be a good idea to add some kind of suffix/prefix to the 
libraries. So, simply looking the files one can know if they are working with 
Mercury or Cobalt.

As, they are not binary compatible, and the programs must to be recompile, you 
can solve it with pkg-config.

The main idea is that we could package xenomai-3, thinking that we could have 
the two main versions (cobalt, mercury) installed in the same machine.

Are they same the same includes? is it protected with ifdef?
 
If yes, then the scripts, includes, could go to a common package and we could 
have some kind of libxenomai-cobalt (libxenomai-c) and libxenomai-
mercury(libxenomai-m) for example.

> > 
> > Ok, so please use another name so that will no confusion.
> 
> Why that? It is still the one and only VxWorks emulator shipped with
> Xenomai.

but xenomai-3. We could add libvxworks-c ...

It's just a propouse...

Best regadrs,

Leopold

