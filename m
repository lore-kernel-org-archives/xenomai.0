MIME-Version: 1.0
In-Reply-To: <5c5ca924-e877-cd18-0bbd-cb3191e84897@xenomai.org>
References: <7223c73f876d31388593.1481802442@devws148.be.alcatel-lucent.com>
 <2755589f-ad4d-a52d-8976-72222bc2eab2@xenomai.org>
 <CAMJ=MEddhyY7s6PXHnmeww_the8VUYwb8whn4PdbVEtc+fiMEg@mail.gmail.com>
 <5c5ca924-e877-cd18-0bbd-cb3191e84897@xenomai.org>
From: Ronny Meeus <ronny.meeus@gmail.com>
Date: Fri, 16 Dec 2016 07:13:08 +0100
Message-ID: <CAMJ=MEcfPTY_wyjv67rS4LTMmSgutrL_5p65MrDTFbf01jaU3Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] [PATCH] boilerplate: do not call xenomai_init 2 times
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

On Thu, Dec 15, 2016 at 6:25 PM, Philippe Gerum <rpm@xenomai.org> wrote:
> On 12/15/2016 05:16 PM, Ronny Meeus wrote:
>> On Thu, Dec 15, 2016 at 3:47 PM, Philippe Gerum <rpm@xenomai.org> wrote:
>>> On 12/15/2016 12:47 PM, Ronny Meeus wrote:
>>>> bootstrap.o is linked to the application code.
>>>> In case the execution of the static constructors is postponed
>>>> in the applicaion and the auto-init feature is used, the
>>>> xenomai_init is called 2 times:
>>>> - once in the path of the wrap_main
>>>> - later in the context of the static constructor
>>>>
>>>
>>> Why do you keep the auto-init feature on, given that you already control
>>> the early init code by postponing the execution of the C++ ctors? I
>>> would rather expect something like:
>>>
>>> - build with no-auto-init
>>> - call xenomai_init() manually from your entry point to activate the
>>> Xenomai services when you see fit.
>>> - call the ctor init chain.
>>
>> We have a lot of applications, some of them postpone the execution of
>> the constructors while others dont.
>> We were calling the init function ourselves before, but we would like to
>> remove this code to keep the application code cleaner and to have less
>> explicit dependencies.
>>
>
> It may be cleaner for your app, but this is pushing the specifics of
> your application to the Xenomai core, making it clumsier. I mean that
> the intent, purpose and function of the bootstrap code is to init the
> system when present. Adding a hack to nullify it instead of not adding
> it to the app basically turns the logic upside down, for no obvious gain.
>
>> Using the auto-init has advantages as well, one of them being that the
>> init code of xenomai can change completely transparant for the
>> application code.
>>
>
> I genuinely don't get your point. xenomai_init() does all the inits for
> Xenomai, there is nothing in the bootstrap module beyond calling this
> routine. I still don't understand what could be the additional advantage
> of having the bootstrap module in, which calling xenomai_init() would
> not have.

Over time the required init function has change already several times:
-  copperplate_init(argc,argv);
-  copperplate_init(&argc,&argv);
-  xenomai_init(&argc,&argv);

This means that all applications need to be adapted (small effort) but
more important that there is a dependency between the application SW
and the Xenomai library. Since we build Xenomai using buildroot and
the application in a non-buildroot context this can be annoying. We
wanted to solve this by the auto-init feature but if you don't agree we will
adapt the application code and keep on using --no-auto-init.

FYI: This is how our init will look like:

#include <version.h>
#if (CONFIG_XENO_VERSION_MAJOR < 3)
#include <copperplate/init.h>
#else
#include <xenomai/init.h>
#endif

....

#if (CONFIG_XENO_VERSION_MAJOR < 3)
#ifdef USE_COPPERPLATE_INIT_VECTOR
  copperplate_init(&argc,&argv);
#else
  copperplate_init(argc,argv);
#endif /* USE_COPPERPLATE_INIT_VECTOR */
#else  /* CONFIG_XENO_VERSION_MAJOR >= 3) */
  xenomai_init(&argc,&argv);
#endif /* CONFIG_XENO_VERSION_MAJOR >= 3) */

For the above construction to work, 2 additional private patches
that we need to apply are needed:
- we add a define USE_COPPERPLATE_INIT_VECTOR to the
  copperplate/init,h file
- in xenomai-3.03 we need to add an in include path since the
  version.h has moved.

By using auto-init, all this code could be removed and this
would work with all versions of Xenomai that we use.

Ronny

> --
> Philippe.

