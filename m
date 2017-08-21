Date: Mon, 21 Aug 2017 13:12:53 +0200
From: Henning Schild <henning.schild@siemens.com>
Message-ID: <20170821131253.4852c71b@md1em3qc>
In-Reply-To: <bf9689d1-3373-ad65-97df-a67fa639c6c3@xenomai.org>
References: <20170808112357.0063d74d@md1em3qc>
 <a676257d-9e88-1b81-15e6-adfffc1c7716@xenomai.org>
 <20170808134801.59ae5de6@md1em3qc>
 <86562178-3b5a-55fc-8652-dc15f228e541@xenomai.org>
 <20170808212758.550caab0@md1em3qc>
 <bf9689d1-3373-ad65-97df-a67fa639c6c3@xenomai.org>
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

Am Wed, 16 Aug 2017 20:13:34 +0200
schrieb Philippe Gerum <rpm@xenomai.org>:

> On 08/08/2017 09:27 PM, Henning Schild wrote:
> >   
> >> Could you sketch the requirements of the app with respect to
> >> option parsing (namespace left aside)? Is there some main
> >> non-Xenomai executable dlopening a Xenomai-based solib defining a
> >> set of rt-specific options?  
> > 
> > Yes the application runs its own main() and later dlopen() s
> > multiple libs, some of which may be linked to xenomai. The order of
> > the dlopens seems hard to control because of static c++
> > constructors or something alike. But i suggest we discuss the
> > internals of that particular app after we have finished the
> > discussion. 
> 
> No need for this; I was not asking for details about the internals,
> only for explicit requirements about receiving parameters / options
> among the software components present in your app. Anyway, I think I
> figured it out from what you've just said.
> 
> >> It seems that you are implicitly referring to ancillaries settings
> >> such as --silent, --verbose and --quiet as being problematic. Is it
> >> correct or are you referring to other parameters?  
> > 
> > If your main comes before xenomai_init() it either has to be able to
> > ignore xenomai args or it will need to change argv/argc before
> > dlopening.
> > 
> > In the first case it has to know all valid args  
> 
> ... the application accepts. Do some (non-Xenomai) dlopened libs
> define their own option namespace the main component does not know
> about? If not, this is only a matter of excluding/ignoring the
> options which the application does not accept when parsing the
> argument vector.
> 
> xenomai_init() will do the same afterwards, ignoring the non-Xenomai
> options transparently. The point being: who should call xenomai_init()
> in the plugin.so file, and when.

That basically means that you can not build a very robust parser. The
problem i see here is a typo in an otherwise valid argument. Both
xenomai and the application will happily ignore it, creating the
impression that it was applied.

Thanks for the code examples and long explanation.

Henning

>  and the second one
> > does not sound very nice. And for the second one i am not sure
> > there is always a time window in the face of static ctors launching
> > threads and dlopening.  
> 
> That is not an issue if Xenomai setup descriptors are used properly.
> The "tuning" phase which may override parameters always precedes the
> "init" phase which considers them when allocating and bootstrapping
> the resources.
> 
> Practically: say you have plugin.so, explicitly set dependent on
> libcobalt.so at link time, you will nevertheless have all ->tune()
> handlers run first, before the first ->init() handler is invoked. And
> this will happen only when xenomai_init() is called; all despite the
> fact that solibs are initialized in reverse dependency order (i.e.
> from the least dependent lib to the most dependent one).
> 
> So, the way that should work with your app would be to load a proxy
> solib which was made dependent on libcobalt.so at build time. That
> proxy shared lib would define a setup descriptor, whose ->tune()
> handler could pull values from the environment for setting whatever
> runtime/config Xenomai tunable that one sees fit. That process is
> guaranteed to happen _before_ the Xenomai core is initialized. The
> proxy solib would include a Xenomai bootstrap module, calling
> xenomai_init().
> 
> The entire process would then look like:
> 
> - main() entered
> -- application parses argv[], no Xenomai arg in the way
> ...
> -- dlopen(plugin.so)
> --- libcobalt.so dependency is loaded, all setup descriptors
> registered --- libplugin.so is loaded, setup descriptor registered
> --- libplugin's bootstrap module calls xenomai_init_dso()
> ---- plugin->tune() is called, pulls args from the environment
> ---- Xenomai ->init() handlers run (using arg settings)
> -- back to main()
> 
> With all Xenomai base parameters exclusively pulled from the
> environment, you could omit any Xenomai-specific option switch from
> the command line when spawning the app, reserving the entire option
> namespace to the application.
> 
> I have demoed this in the attached code (the proxy lib is implemented
> by plugin.c). The demo code only retrieves the verbosity_level
> parameter from the environment, which is normally affected by
> --silent, --quiet and --verbose command line options, but you get the
> idea.
> 
> I understand you would like a permanent way of doing this without
> having to provide any code. Although I don't buy a second the
> argument about envvars being "more standard" than command switches,
> I'm not opposed to get this kind of feature in, but only if:
> 
> - the implementation does not reinvent the wheel of parameter parsing,
> this would be fairly silly.
> - the natural way of setting Xenomai parameters remains based on
> command line switches. Most people do NOT care a dime about deferred
> binding to libcobalt, so there is no reason to make this use case the
> preferred one.
> 
> The sanest way to provide such feature would be to implicitly turn
> every option label defined by setup descriptors into a potential
> envvar, e.g. --cpu-affinity would be unambiguously matched by a
> variable named "cpu_affinity". The core would look for such a
> variable in the environment if the command line switch is not found,
> hence giving precedence to the latter implicitly.
> 
> At least, this would limit the risk of having totally unrelated ways
> of setting core parameters, with less braindamage side-effects on
> people with unsuitable daily amount of caffeine for the job.
> 
> There is a way to do this properly, but this cannot be high on my todo
> list ATM, given the ongoing work I have on my plate. Anyway, issue
> logged.
> 


