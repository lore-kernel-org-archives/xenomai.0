References: <87mtexkcxf.fsf@xenomai.org>
 <9d47b5f3-b18e-0f75-9753-fefec5e9bdd7@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: [RFC] Rust API for evl
Date: Wed, 01 Jun 2022 10:56:51 +0200
In-reply-to: <9d47b5f3-b18e-0f75-9753-fefec5e9bdd7@siemens.com>
Message-ID: <87bkvcirgs.fsf@xenomai.org>
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
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai@xenomai.org


Jan Kiszka <jan.kiszka@siemens.com> writes:

> On 31.05.22 15:37, Philippe Gerum via Xenomai wrote:
>> 
>> I've been getting my feet wet with Rust for a few weeks now, assessing
>> the real-time latency figures I could get from an existing (C++)
>> application once fully rewritten in this language.  It turned out that
>> performance was on par with the original implementation with memory
>> safety on top, among other upsides (like having quite some fun coding in
>> Rust in the first place).
>> 
>> Having Rust as a Tier 1 language for Xenomai4/evl along with the
>> existing C interface definitely makes sense to me. The goal would be to
>> have a 'revl' interface providing the EVL services the idiomatic Rust
>> way, available as a crate on top of the FFI bindings to libevl which
>> have just landed [1].
>> 
>> Whether you are a Rustacean or not, if you are willing to discuss and
>> help with this, let me know.
>> 
>> [1] https://source.denx.de/Xenomai/xenomai4/evl-sys.git
>> 
>
> I think this is a very interesting experiment, and I'm excited to see
> that there are apparently no RT traps in the runtime.

There are in the std:: library, but since the original C++ application
was written from the ground up with dual kernel support in mind, this
was fairly easy to locate the time critical algorithms, designing a Rust
implementation for them.

A few takeaways so far from switching this non-trivial C++ real-time
application to Rust:

- this is not about 'porting' in the usual sense, this is about
  rewriting with different idioms. As far as I'm concerned, leaving
  behind the OOP playbook helped a lot. Not that we cannot or should not
  use constructs which are reminiscent of OOP with Rust, but its trait
  system and some influence from functional programming give a lot more
  than this. Besides, monomorphization is our friend performance-wise,
  so using 'trait objects' all over the map may not be the best approach
  - in fact, this might even go against expressiveness in some cases
  IMHO.

- since we are used to tread carefully between non-rt and rt contexts in
  our ecosystem, the std:: library is ok in the processing
  preparation/exit phase as usual. In addition, Rust tends to allocate
  as much as possible from the stack unlike the STL (not even mentioning
  Boost): this shows when comparing the assembly output for some code
  involving a plain vector iterator (obviously NOT with folding or any
  accumulator-based construct though). IOW, the precautions we take with
  C++ also apply in a Rust context, but shenanigans were much fewer in
  the Rust case AFAIC, and the audit process was much easier
  source-wise, navigating the standard crate implementation. Typically,
  I did not stumble on unexpected 'hidden locks' even in the standard
  library (std::io has some, but this is hardly unexpected there, and
  not an issue anyway). Maybe I've been lucky, but Rust tends to favor
  explicit over implicit in general, so there is hope.

- for the time-critical part Rust-wise, we have the 'heapless' crate
  around which gives several off-the-shelf data structures which are
  guaranteed not to rely on - well - heap-based allocation. Since the
  application involves zero-copy messaging at its heart, the 'flume'
  crate was used to exchange message envelopes locklessly with quite
  good performances. The most striking aspect of all this comes when you
  realize that you did not implement any explicit refcounting of these
  messages but delegated it to the language via the Arc construct, and
  this Just Works (TM): no leakage, no trashing, no brainer. Of course,
  there may be hidden atomic operations all over the map which do not
  come for free, but still, this did not cause any significant
  performance degradation on armv7 compared to the C++ version where all
  of this has been handcrafted.

- we can mix the Rust std and no_std environment, both coupled to libc
  in a single application. The Rust EVL interface should probably go for
  no_std with some runtime guard on the global allocator, so that any
  jack-in-the-box dynamic allocation is either impossible by design, or
  easily caught in this API.

- any language compiler should have consideration for its users like
  rustc does. Obviously, rustc has to be picky by design to honor the
  promise of memory safety including safe concurrency, but this always
  goes with helpful error messages, smart hints. Seriously, the work
  these folks did there to help newcomers is simply fascinating.

- I found using a Rust cross-toolchain targeting armv7 from a
  Yocto-generated SDK a bit bumpy in a few occasions, particularly if
  bindgen is involved the build process. Likewise, 'heapless' may need
  some fixup in its build script. This said, meta-rust which produces
  the toolchain was merged into the OE core only fairly recently (Yocto
  honister was the first Yocto release to have it IIRC), armv7 is still
  Tier 2 Rust-wise, so this will improve over time. In general,
  targeting x86 which is Tier 1 is already a no-brainer though.

> Do you have some
> example code somewhere as well?
>

Not yet. I have started working on the 'revl' crate implementing the EVL
interface for the Rust language though. There is not much of it yet
(clock services based on the 'embedded_time' crate, little
thread-related support, sema4 and basic mutex), but I'll push what is
there in a couple of days to a public repo.

-- 
Philippe.

