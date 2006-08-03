Subject: Re: [Xenomai-help] native heap services and overloading new
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <44D0F876.8020406@domain.hid>
References: <38215.155.98.4.39.1154456700.squirrel@domain.hid>
	<44D0F876.8020406@domain.hid>
Content-Type: text/plain
Date: Thu, 03 Aug 2006 19:13:52 +0200
Message-Id: <1154625233.5010.111.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <kiszka@domain.hid>
Cc: xenomai@xenomai.org

On Wed, 2006-08-02 at 21:09 +0200, Jan Kiszka wrote:
> Brandt Erickson wrote:
> > I have some code where I'd like to be able to dynamically allocate memory
> > in realtime.  Since the code is written in C++, I was thinking of just
> > making a huge global RT_HEAP and overloading the new and delete operators
> > to use the rt_heap_alloc and rt_heap_free functions.  First off, I'm
> > wondering if there are any caveats to this sort of thing that wouldn't be
> > obvious to someone new to xenomai like myself.  Second, if I fail to call
> > rt_heap_delete before the program terminates, does the heap remain
> > registered hang potentially causing problems when I try to re-allocate the
> > heap when the program is run again?  Thanks.
> 
> For now: yes, the heap will stay, no automatic cleanup (the posix skin
> already have this). You could then run into naming conflicts and you
> lose memory, of course.
> 
> But you could install some signal handler for cleaning up. We do so in
> our native-skin-based framework (also C++, but no "evil" ;) features in
> use). We even catch SIGSEGV this way.
> 

Another simple option: the binding operation is particularly useful for
recycling/discarding lingering objects.

RT_HEAP app_heap;

void init_heap (void)
{
	RT_HEAP old_heap;

	if (rt_heap_bind(&old_heap, "foo", TM_NONBLOCK) == 0)
		rt_heap_delete(&old_heap);

	rt_heap_create(&app_heap, "foo", ...);
}

-- 
Philippe.



