Message-ID: <550886B0.2080900@xenomai.org>
Date: Tue, 17 Mar 2015 20:55:28 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <CAKk99t1uNuO81qXKwkQuLTaHLNSydY94H1uOKdODAXsRp0Zfig@mail.gmail.com>
In-Reply-To: <CAKk99t1uNuO81qXKwkQuLTaHLNSydY94H1uOKdODAXsRp0Zfig@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Differences when compiling with g++ support in
 Mercury and Cobalt
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Helder Daniel <hdaniel@ualg.pt>, "Xenomai@xenomai.org" <xenomai@xenomai.org>

On 03/17/2015 07:35 PM, Helder Daniel wrote:
> I am compiling a small Alchemy App with C++ support, that is perfectly
> compiled in Xenomai 2.5.x.
> 
> #use c++ compiler
> CC = g++
> 
> using skin := native xeno-config reports correct flags only in Mercury.

[snip]

> 
> Using skin := alchemy both gcc and g++ can found all functions in both
> Mercury and Cobalt.
> 
> this might suggest that the native API legacy support is not fully
> operational?
> Because using the API designation of Alchemy all compiles fine.
> 

This is an issue with the transition kit it seems (aka libtrank,
include/trank), which provides compat wrappers from the native API
available with Xenomai 2.x to Cobalt's Alchemy.

Passing --skin=native or --native to xeno-config with Cobalt will
automatically enable this compat mode, whilst passing --skin=alchemy or
--alchemy won't. Some headers in include/trank are likely not C++
friendly yet.

Some simple test code would help.

> Also there is a best way to include Alchemy headers in 3.x?
> 
> #include <alchemy/task.h> ...

This is the recommended way with Xenomai headers, except for the POSIX
support which should be referred to by standard file names, given that,
well, it's a standard.

> or just:
> #include <task.h> ...
> 
> Any of these forms will be deprecated in the future?
> 

Both will remain available in the future. It's just that using
<api>/<file>.h will prevent any conflict when it comes to mixing
multiple APIs in a single application (e.g. task.h could be defined by
several APIs).

> Thanks,
> 
> PS:
> skin := native in Mercury is equal to skin := Alchemy in Cobalt (the only
> diff is macros -D__MERCURY__ and -D__COBALT__)
> 
> skin := native in Cobalt is very different. It seems to include support not
> only for legacy APIs but also for Mercury and Cobalt at the same time
> -lalchemy -lcobalt (?)
> 

No, native with Cobalt includes support for:

- libtrank (compat wrappers from the transition kit)
- libalchemy (based on libcopperplate)
- libcopperplate (built on top of libcobalt)
- libcobalt (the POSIX interface to the Cobalt core in dual kernel mode)

Native/Alchemy for Mercury includes support for:

- libalchemy (based on libcopperplate)
- libcopperplate (built on top of the glibc)

Files from include/alchemy are shared between Cobalt and Mercury setups.

-- 
Philippe.

