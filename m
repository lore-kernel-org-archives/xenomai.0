References: <20170808112357.0063d74d@md1em3qc>
 <a676257d-9e88-1b81-15e6-adfffc1c7716@xenomai.org>
 <20170808134801.59ae5de6@md1em3qc>
 <86562178-3b5a-55fc-8652-dc15f228e541@xenomai.org>
 <20170808212758.550caab0@md1em3qc>
 <bf9689d1-3373-ad65-97df-a67fa639c6c3@xenomai.org>
 <20170825191604.723abf24@md1em3qc>
 <553cc0c2-2ce4-5182-b6eb-4a18ccad82b5@xenomai.org>
 <20170829142726.23ea20ef@md1em3qc>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <445755f9-7406-98e9-7e2f-e30b4a6237b2@xenomai.org>
Date: Tue, 29 Aug 2017 18:10:12 +0200
MIME-Version: 1.0
In-Reply-To: <20170829142726.23ea20ef@md1em3qc>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
To: Henning Schild <henning.schild@siemens.com>
Cc: "KISZKA, JAN" <jan.kiszka@siemens.com>, xenomai@xenomai.org

On 08/29/2017 02:27 PM, Henning Schild wrote:
> Am Tue, 29 Aug 2017 13:05:47 +0200
> schrieb Philippe Gerum <rpm@xenomai.org>:

>> You could dlopen() libplugin.so directly or indirectly via the
>> dependency list a hundred times, you would only get a single bootstrap
>> if the bootstrap module is glued to the DSO. If not, then calling
>> xenomai_init() multiple times from your app would simply lead to nop
>> after the first call (with Xenomai 3.0.5).
> 
> Yes but we are not talking about the same shared object, but multiple.
> Not loading libplugin.so 10 times but loading libplugin(0-9).so
> 
> So i need to find a way to load one plugin first and put the setup
> descriptor in there, or i need to have the setup descriptor in every
> plugin and keep them all in sync.
> 

You don't have to do either, because you don't have multiple
libplugin.so the way I see it. You have multiple application DSOs you
want to dlopen() directly, all depending on a single libplugin.so, which
eventually depends on libcobalt.so.

libplugin.so is a misnomer actually, I should have called it
libcobalt-setup.so, because it only does that: i.e. tuning the Xenomai
core with settings pulled from the environment before xenomai_init_dso()
starts the former. And the latter is contained in the bootstrap module
which should be glued to libcobalt-setup.so via the auto-init-solib
mechanism.

To sum up, say you have two application DSOs, namely libfoo.so and
libbar.so, all depending on Xenomai for getting real-time services. The
chain of dependency should then be:

dlopen("libfoo.so")
          \
           > libcobalt-setup.so -> libcobalt.so
          /
dlopen("libbar.so")

libfoo.so and libbar.so should have been made dependent on
libcobalt-setup.so at build time.

At the end of the day, dlopen() ensured that libcobalt-setup.so and
libcobalt.so have been mapped only once, with their respective library
constructors executed only once. Since setup descriptors are registered
by those constructors, the unique instance of your setup descriptor has
been registered once, ready to be activated by xenomai_init_dso() -
which happens last.

Calling dlopen() from static C++ constructors does not change the
situation, it does work just like illustrated without any unexpected
trap. I have just verified it locally.

>>
>> First, your original mail mentioned name clashes as a reason to drop
>> command line options or to prefix them with --xeno, followed by a
>> suggestion to drop setup descriptors in favor of a generalized use of
>> environment variables.
> 
> That is the case where dlopen comes after main and main needs to ignore
> the args you want to pass to xenomai. There has been not been any
> filtering out yet, the application will have to do it. 
>  

Have we been talking about heavily refactoring the Xenomai setup
mechanism only because the code below would be deemed complex, ugly and
non-standard according to your customer? If so, I disagree.

#include <stdio.h>
#include <stdlib.h>
#include <getopt.h>
#include <xenomai/init.h>

static const struct option options[] = {
	{
#define help_opt	0
		.name = "help",
	},
	{
#define parm_opt	1
		.name = "parm",
		.has_arg = required_argument,
	},
	{ /* sentinel. */ }
};

int main(int argc, char *argv[])
{
	int c, lindex;

	opterr = 0;
	for (;;) {
		lindex = -1;
		c = getopt_long(argc, argv, "", options, &lindex);
		if (c == EOF)
			break;
		if (lindex == -1) { /* c == '?' */
			printf("discarding somebody else's option\n");
			continue;
		}

		printf("found application option '%s'\n", options[lindex]);

		switch (lindex) {
		case help_opt:
			application_usage();
			xenomai_usage();
			exit(0);
		case parm_opt:
			apply_application_setting(optarg);
			break;
		}
	}
	
	return 0;
}

> We already have 3 layers adding another one is imho not a good idea.
> People will have to understand the precedence.
>

That won't fly. tunables are the only sane way for application
developers to define sensible built-in factory settings in Xenomai
applications, which is aware of the boot order of software components.
Dropping them would be a net loss in the field.
> Again it would be nice if there was just one way to change the values,
> resulting in 2 levels.
> 
> These are the problems we so far discovered in the two ways we have
> today
> 
> level 2:
>  - tuning only works for the first guy to call xenomai_init
>    - tuning in the second and n-th lib will fail silently, due to
>      implementation, not general mechanism
>  - users need a deep understanding of the linking process and make sure
>    they always know/control who will be the first
>    - many dlopen()s or many .so s in ldd

There is no reason to tune the system multiple times based on the same
set of settings, for initializing the same machinery. I believe that you
only need and want a single setup descriptor in your dependency chain
down to libcobalt.so. There is no requirement for knowing the link order
either.

> level 3:
>  - does not play well with dlopen(), see above
>

The only aspect that depends on static vs dlopen is who is going to
process the argument vector first, and there are fairly simple solutions
for both ways.

> I doubt we need yet another mechanism and layer it is complex enough as
> it is today.
> 

We may agree to disagree on this. Tunables won't go away, but we can
provide a simple mechanism for removing the need to populate the command
line with Xenomai arguments, if using getopt() is really a burden for
your customer.

-- 
Philippe.

