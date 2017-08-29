Date: Tue, 29 Aug 2017 14:27:26 +0200
From: Henning Schild <henning.schild@siemens.com>
Message-ID: <20170829142726.23ea20ef@md1em3qc>
In-Reply-To: <553cc0c2-2ce4-5182-b6eb-4a18ccad82b5@xenomai.org>
References: <20170808112357.0063d74d@md1em3qc>
 <a676257d-9e88-1b81-15e6-adfffc1c7716@xenomai.org>
 <20170808134801.59ae5de6@md1em3qc>
 <86562178-3b5a-55fc-8652-dc15f228e541@xenomai.org>
 <20170808212758.550caab0@md1em3qc>
 <bf9689d1-3373-ad65-97df-a67fa639c6c3@xenomai.org>
 <20170825191604.723abf24@md1em3qc>
 <553cc0c2-2ce4-5182-b6eb-4a18ccad82b5@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [RFC] Xenomai3 tuneables replaced by environment
	variables
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: "KISZKA, JAN" <jan.kiszka@siemens.com>, xenomai@xenomai.org

Am Tue, 29 Aug 2017 13:05:47 +0200
schrieb Philippe Gerum <rpm@xenomai.org>:

> On 08/25/2017 07:16 PM, Henning Schild wrote:
> > Am Wed, 16 Aug 2017 20:13:34 +0200
> > schrieb Philippe Gerum <rpm@xenomai.org>:
> >   
> >> On 08/08/2017 09:27 PM, Henning Schild wrote:  
> >>>     
> >>>> Could you sketch the requirements of the app with respect to
> >>>> option parsing (namespace left aside)? Is there some main
> >>>> non-Xenomai executable dlopening a Xenomai-based solib defining a
> >>>> set of rt-specific options?    
> >>>
> >>> Yes the application runs its own main() and later dlopen() s
> >>> multiple libs, some of which may be linked to xenomai. The order
> >>> of the dlopens seems hard to control because of static c++
> >>> constructors or something alike. But i suggest we discuss the
> >>> internals of that particular app after we have finished the
> >>> discussion.   
> >>
> >> No need for this; I was not asking for details about the internals,
> >> only for explicit requirements about receiving parameters / options
> >> among the software components present in your app. Anyway, I think
> >> I figured it out from what you've just said.
> >>  
> >>>> It seems that you are implicitly referring to ancillaries
> >>>> settings such as --silent, --verbose and --quiet as being
> >>>> problematic. Is it correct or are you referring to other
> >>>> parameters?    
> >>>
> >>> If your main comes before xenomai_init() it either has to be able
> >>> to ignore xenomai args or it will need to change argv/argc before
> >>> dlopening.
> >>>
> >>> In the first case it has to know all valid args    
> >>
> >> ... the application accepts. Do some (non-Xenomai) dlopened libs
> >> define their own option namespace the main component does not know
> >> about? If not, this is only a matter of excluding/ignoring the
> >> options which the application does not accept when parsing the
> >> argument vector.
> >>
> >> xenomai_init() will do the same afterwards, ignoring the
> >> non-Xenomai options transparently. The point being: who should
> >> call xenomai_init() in the plugin.so file, and when.
> >>
> >>  and the second one  
> >>> does not sound very nice. And for the second one i am not sure
> >>> there is always a time window in the face of static ctors
> >>> launching threads and dlopening.    
> >>
> >> That is not an issue if Xenomai setup descriptors are used
> >> properly. The "tuning" phase which may override parameters always
> >> precedes the "init" phase which considers them when allocating and
> >> bootstrapping the resources.
> >>
> >> Practically: say you have plugin.so, explicitly set dependent on
> >> libcobalt.so at link time, you will nevertheless have all ->tune()
> >> handlers run first, before the first ->init() handler is invoked.
> >> And this will happen only when xenomai_init() is called; all
> >> despite the fact that solibs are initialized in reverse dependency
> >> order (i.e. from the least dependent lib to the most dependent
> >> one).
> >>
> >> So, the way that should work with your app would be to load a proxy
> >> solib which was made dependent on libcobalt.so at build time. That
> >> proxy shared lib would define a setup descriptor, whose ->tune()
> >> handler could pull values from the environment for setting whatever
> >> runtime/config Xenomai tunable that one sees fit. That process is
> >> guaranteed to happen _before_ the Xenomai core is initialized. The
> >> proxy solib would include a Xenomai bootstrap module, calling
> >> xenomai_init().
> >>
> >> The entire process would then look like:
> >>
> >> - main() entered
> >> -- application parses argv[], no Xenomai arg in the way
> >> ...
> >> -- dlopen(plugin.so)
> >> --- libcobalt.so dependency is loaded, all setup descriptors
> >> registered --- libplugin.so is loaded, setup descriptor registered
> >> --- libplugin's bootstrap module calls xenomai_init_dso()
> >> ---- plugin->tune() is called, pulls args from the environment
> >> ---- Xenomai ->init() handlers run (using arg settings)
> >> -- back to main()
> >>
> >> With all Xenomai base parameters exclusively pulled from the
> >> environment, you could omit any Xenomai-specific option switch from
> >> the command line when spawning the app, reserving the entire option
> >> namespace to the application.
> >>
> >> I have demoed this in the attached code (the proxy lib is
> >> implemented by plugin.c). The demo code only retrieves the
> >> verbosity_level parameter from the environment, which is normally
> >> affected by --silent, --quiet and --verbose command line options,
> >> but you get the idea.  
> > 
> > I only just really looked at the example, after i asked my customer
> > to look at your response. And they kept telling me that it will not
> > work.  
> 
> This sounds like nobody tried it actually.
> 
> > 
> > Now i gave them a similar example a few months ago. Put the tuning
> > in the lib init and you are done ...
> > 
> > As far as i understand the situation:
> > We are talking about more than one "plugin" that pulls in libcobalt.
> > And the dlopens are not in main but in static ctors before main, so
> > our plugin load order is "unknown/random". So the tuning would have
> > to go into all plugins or we will need to find a way to have a
> > defined "first plugin".
> >   
> 
> This explanation is very confusing. Unlike dlmopen(), dlopen()ing
> multiple times the same shared object (and likewise its dependencies)
> only creates a single mapping at the initial opening, and only runs
> the library constructors once at that moment. This would include the
> call to xenomai_init() if the bootstrap module is present in the DSO.
>
> You could dlopen() libplugin.so directly or indirectly via the
> dependency list a hundred times, you would only get a single bootstrap
> if the bootstrap module is glued to the DSO. If not, then calling
> xenomai_init() multiple times from your app would simply lead to nop
> after the first call (with Xenomai 3.0.5).

Yes but we are not talking about the same shared object, but multiple.
Not loading libplugin.so 10 times but loading libplugin(0-9).so

So i need to find a way to load one plugin first and put the setup
descriptor in there, or i need to have the setup descriptor in every
plugin and keep them all in sync.

But enough about that example.

> > I guess we can invent libtune.so and LD_PRELOAD it. Or put that as
> > proxy into all plugins.  ... and all that vs "export XENO_foo"
> >   
> 
> I guess that your customer may want to clearly explain what they want
> to achieve by sketching their init process and the software
> components in the picture, because at this point, I could not figure
> out what their problem is. I'm not keen on continuing this discussion
> only based on guesses.
> 
> On a general note, I believe that this discussion took the wrong track
> by mentioning orthogonal and often unrelated issues such as
> constructor priority, dlopen ordering, namespace conflicts. I do
> believe that these are not the issues at stake here. The real issue
> is about understanding how dynamic inits do work with Xenomai, how
> setup descriptors can help introducing initialization order when
> there was none, and progress from there.
> 
> Whether adding support for getting parameters from envvars should be
> implemented is a separate issue. Doing so would not solve every
> problem regarding dynamic loading and static C++ constructors, and
> people dealing with that should not put away their tin foil hat, but
> this can be done elegantly, and as I said earlier, I'm not opposed to
> merge such feature.
> 
> >> I understand you would like a permanent way of doing this without
> >> having to provide any code.  
> > 
> > No, but i anticipated a discussion and decided to write code when
> > the outcome of the discussion is clear.
> >   
> >> Although I don't buy a second the argument about envvars being
> >> "more standard" than command switches,  
> > 
> > Command switches always become a problem when two or more components
> > have to share the namespace. Removing your traces and not
> > bothering  
> 
> And envvars do introduce a painful issue too: submitting parameters is
> not explicit anymore, and one may end up running with broken settings
> from a dusted set of conflicting login / setup scripts, inheriting the
> mess all way through the process hierarchy.
> 
> I do acknowledge that proper use do exist too, but let's not sell
> envvars the as perfect, simple and foolproof option: with complex
> systems developed and configured by many people over a long period of
> time, they are not. With simple applications with only a few
> user-settable parameters, they are just inconvenient compared to plain
> command switches.
> 
> Besides, a real-time Xenomai application acting as a server forking
> other applications is not quite the common case. the app could also
> achieve that export by running setenv() on any set of parameters
> received on the command line it would want to pass to the forkees.
> Your point is that you would like the Xenomai libs to consider envvars
> directly, which is fair enough from your standpoint, but this is
> definitely not most people's requirement and as such this will never
> become a default.
> 
> > the other/imposing on the other only works if the order is known. In
> > Xenomai the order depends on how people link  
>
> This affirmation seems wrong when considering the way setup
> descriptors are dealt with internally, actually they have been
> designed precisely not to depend on the link order, and also to allow
> unrelated components to initialize in proper sequence.
> 
> So I can only assume that your remark on the link order is about
> static dependency vs dlopen. In that case, I still fail to see what
> Xenomai libs impose which any other random library does not, when it
> comes to using dlopen().

This section was about command line parameters. With ld.so xenomai_init
comes before main, with dlopen it might come before or after main. So
the order is undefined.

> Again, could you be specific and illustrate your concern with a simple
> code example that would not work with the current Xenomai
> implementation?

In the case where dlopen comes after main, main needs to be modified to
ignore args for xenomai, or args can not be used.
And "void usage()" needs to be modified to print xenomai --help as well
before exiting.

> > so we can not know it for
> > the general case.  
> > > I would not want to be the poor guy writing main() for an app
> > > where  
> > multiple libs think that argv is for them to use, especially with
> > tricks to access it before main(). Just the fact that xenomai is
> > stealing this out of /proc/self/cmdline should suggest how
> > non-standard that is.
> >   
> 
> I can see the rant above, but I don't get the reasoning.
> 
> First, your original mail mentioned name clashes as a reason to drop
> command line options or to prefix them with --xeno, followed by a
> suggestion to drop setup descriptors in favor of a generalized use of
> environment variables.

That is the case where dlopen comes after main and main needs to ignore
the args you want to pass to xenomai. There has been not been any
filtering out yet, the application will have to do it. 
 
> If your customer's application wants to exclusively use environment
> variables for its own parameters, then there is no way such variables
> could conflict with any existing Xenomai command line switch.
> Conversely, there is nothing in Xenomai that will prevent any piece of
> application code to read the environment.
> 
> So you must be referring to the general case instead, where "some"
> application - i.e. not your customer's - with requirements to use
> command line switches, would clash with existing ones defined by the
> Xenomai libraries.
> 
> To answer this point, I will repeat that only a handful of Xenomai
> command switches have generic names (e.g. --verbose, --quiet,
> --silent, --help). The rest is either prefixed, or specific enough to
> prevent any confusion regarding their meaning, leaving a lot of space
> for variants.
> 
> So maybe the time has come to be more specific about the namespace
> clash issue too: which existing Xenomai option are your referring to,
> which would create a conflict with your application namespace _today_?

'--help' in dlopen() vs. static/dynamic

> > Env variables are just there to look at, if you are not interested
> > nobody will tell you to look at argc more of them. They survive a
> > fork() if your main script needs to launch multiple xenomai apps
> > with the same tuning.
> >   
> 
> Reading /proc/self/cmdline is exclusively part of the auto-bootstrap
> feature of a Xenomai application, and the latter is NOT required. You
> can disable it at will at build time by not including the bootstrap
> module in the DSO or main executable, and receive the unfiltered set
> of command line switches into main() for the latter.
> 
> The auto-bootstrap is there because most applications are getting
> benefit from not having to care for calling xenomai_init() explicitly,
> and are just fine with receiving only the command line switches they
> want to process in their main() routine, expunged from all Xenomai
> switches.

The problem was never xenomai removing args from argv before main can
see them.

> The only requirement in this case would be that at some point, the
> application calls xenomai_init() explicitly, before calling into
> Xenomai services. If your application knows when it should dlopen()
> libcobalt, it therefore knows when to call xenomai_init() too.
> 
> You could argue that enabling auto-bootstrap should not be a
> default setting of the build switches returned by xeno-config,
> preferring manual init of the real-time services by default, but that
> is pretty much all of the extent of the issue.
> 
> >> I'm not opposed to get this kind of feature in, but only if:
> >>
> >> - the implementation does not reinvent the wheel of parameter
> >> parsing, this would be fairly silly.
> >> - the natural way of setting Xenomai parameters remains based on
> >> command line switches. Most people do NOT care a dime about
> >> deferred binding to libcobalt, so there is no reason to make this
> >> use case the preferred one.  
> > 
> > If we can not agree to drop at least the tunables, introducing
> > another way would be insane.
> >  
> 
> We can't agree because this is a misconception. Tunables are entirely
> orthogonal to command line switches and environment variable.
> Functionally speaking, you can't replace tunables with envvars.
> 
> Each setting of a Xenomai application - whether it is defined by the
> real-time libs or the user code makes no difference - can get its init
> value as follows, by increasing level of precedence:
> 
> level 1- core default, this is a sane value set by the base
> implementation. Usually only appropriate for simple, small apps. For
> instance, the default memory pool size is 1Mb, not much for an hungry
> app, but enough for most simple apps.
> 
> level 2- tunable, this is a _factory setting_ aimed at the application
> developer. Quite often, only the application developer really knows
> how to determine the proper value of such setting because it depends
> on intimate knowledge of the innards, like the appropriate amount of
> memory a given user-defined configuration would require. Such a value
> should be determined by the tuning handler of a setup descriptor.
> Providing a factory setting via a tunable allows you to deliver a
> binary executable that will always allocate a sane amount of
> resources, without requiring the end user to figure out. Unlike the
> core default, this one is dynamic, it can adapt to runtime
> configuration bits. Whether those bits are obtained from command line
> switches, envvars, config file, pigeon post or telepathy is not
> relevant. At all.
> 
> level 3- command line switches, which are aimed at the end user, for
> overriding any previous setting.
> 
> My proposal to automatically turn each command line defined by setup
> descriptors into an implicit envvar would insert a 4th level, between
> the tunable and the command line switch.
>
> For instance, we could ask xenomai_init() to assume that since
> "--mem-pool-size" was defined (in libcopperplate's setup descriptor),
> there might an envvar called "XENO_MEM_POOL_SIZE" with the exact same
> semantics, pulling it if present.

We already have 3 layers adding another one is imho not a good idea.
People will have to understand the precedence.

Again it would be nice if there was just one way to change the values,
resulting in 2 levels.

These are the problems we so far discovered in the two ways we have
today

level 2:
 - tuning only works for the first guy to call xenomai_init
   - tuning in the second and n-th lib will fail silently, due to
     implementation, not general mechanism
 - users need a deep understanding of the linking process and make sure
   they always know/control who will be the first
   - many dlopen()s or many .so s in ldd
level 3:
 - does not play well with dlopen(), see above
 
> >> The sanest way to provide such feature would be to implicitly turn
> >> every option label defined by setup descriptors into a potential
> >> envvar, e.g. --cpu-affinity would be unambiguously matched by a
> >> variable named "cpu_affinity". The core would look for such a
> >> variable in the environment if the command line switch is not
> >> found, hence giving precedence to the latter implicitly.  
> > 
> > Yes the command line switch should still win, if they really need to
> > stay. And a prefix like XENO_ should be added.
> >   
> >> At least, this would limit the risk of having totally unrelated
> >> ways of setting core parameters, with less braindamage
> >> side-effects on people with unsuitable daily amount of caffeine
> >> for the job.
> >>
> >> There is a way to do this properly, but this cannot be high on my
> >> todo list ATM, given the ongoing work I have on my plate. Anyway,
> >> issue logged.  
> > 
> > Would you be willing to review/consider a patch that replaces the
> > tuneables with env vars?
> >   
> No, for the reason mentioned above. However I would consider a patch
> that implicitly turns options obtained from registered setup
> descriptors into envvars, with lower precedence than the former, so
> that command switches can always override tunables and envvars.

I doubt we need yet another mechanism and layer it is complex enough as
it is today.

Henning

> This said, I doubt this would fix the issue with your customer's
> application: as you described it, that one is not about command line
> vs envvar, this is about dealing in an orderly manner with the
> uncertain combination of lazy code binding and C++ runtime mechanisms.
> 


