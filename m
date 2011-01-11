From: Peter Soetens <peter@domain.hid>
Date: Tue, 11 Jan 2011 12:23:46 +0100
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <201101111223.46697.peter@domain.hid>
Subject: Re: [Xenomai-help] Correct use of xeno_sigshadow_install()
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai-help <xenomai@xenomai.org>

On Monday 10 January 2011 21:45:24 Gilles Chanteperdrix wrote:
> Peter Soetens wrote:
> > On Monday 10 January 2011 17:50:05 Gilles Chanteperdrix wrote:
> >> Peter Soetens wrote:
> >>> On Monday 10 January 2011 17:24:28 Gilles Chanteperdrix wrote:
> >>>> Peter Soetens wrote:
> >>>>> Hi,
> >>>>> 
> >>>>> A while ago, I was advised to call xeno_sigshadow_install() after a
> >>>>> library installed a sigwinch signal handler (I believe this was
> >>>>> Xenomai 2.5.1). Could it be that this is no longer supported in
> >>>>> recent versions ? What is the correct way to avoid a segfault if an
> >>>>> application installed a sigwinch handler after Xenomai did ?
> >>>> 
> >>>> I think we already answered that at the time, but if you install your
> >>>> own sigwinch handler, you should:
> >>>> - register it with the SA_SIGINFO flag
> >>>> - call xeno_sigwinch_handler and consider that the signal is for the
> >>>> application only if this function returns 0.
> >>> 
> >>> This is indeed in the API docs, but it's not an option since it's a
> >>> third party library (readline) doing this, it doesn't depend on or
> >>> know Xenomai.
> >>> 
> >>>> If you can not do that, then redefine SIGSHADOW in
> >>>> include/asm-generic/syscall.h to a different value, and recompile both
> >>>> Xenomai user-space and kernel-space support. Note however that when
> >>>> starting applications in gdb you will then have to type:
> >>>> 
> >>>> handle <the_new_signal> pass nostop print
> >>>> 
> >>>> If you want to be able to debug Xenomai applications.
> >>> 
> >>> Hmm....
> >>> 
> >>> So defining the xeno_sigshadow_install() function ourselves (since it's
> >>> not in any Xenomai header) and calling it after the readline signal
> >>> handlers were installed is not gonna work ?
> >> 
> >> The thing is that xeno_sigshadow_installi is an internal function,
> >> particularily, it is not thread safe. The exported function is
> >> xeno_sigshadow_install_once, but it will not do anything the second time
> >> it gets called.
> >> 
> >> If you take care of this thread-safety issue, calling
> >> xeno_sigshadow_install should be OK, since it just installs
> >> xeno_sigshadow_handler as a handler for SIGSHADOW, calling
> >> xeno_sigwinch_handler, then the handler your application registered
> >> before. All this code is relatively simple, and you will find it in
> >> src/skins/common/sigshadow.c
> >> 
> >> Now, I suspect the issue you have is something else, so, could you post
> >> the faulting code, reduced to a simple self-contained test case?
> > 
> > main.cpp:
> > #include <readline/readline.h>
> > #include <readline/history.h>
> > #include <xenomai/native/task.h>
> > #include <malloc.h>
> > #include <sys/mman.h>
> > #include <stdio.h>
> > 
> > char* line_read = 0;
> > 
> > char *rl_gets ()
> > {
> > 
> >   /* If the buffer has already been allocated,
> >   
> >      return the memory to the free pool. */
> >   
> >   if (line_read)
> >   
> >     {
> >     
> >       free (line_read);
> >       line_read = 0;
> >     
> >     }
> >   
> >   if (rl_set_signals() != 0)
> >   
> >     printf("Error setting signals !\n");
> >   
> >   line_read = readline ( ">" );
> >   
> >   /* If the line has any text in it,
> >   
> >      save it on the history. */
> >   
> >   if (line_read && *line_read) {
> >   
> >     add_history (line_read);
> >   
> >   }
> >   return (line_read);
> > 
> > }
> > 
> > int main(void)
> > {
> > 
> >   mlockall(MCL_CURRENT | MCL_FUTURE);
> >   
> >   RT_TASK xenotask;
> >   rt_task_shadow( &(xenotask),0, 10, 0);
> >   rl_completion_append_character = '\0'; // avoid adding spaces
> >   
> >   if ( read_history(".history") != 0 ) {
> >   
> >     read_history("~/.history");
> >   
> >   }
> >   
> >   // Let readline intercept relevant signals
> >   if(rl_catch_signals == 0)
> >   
> >     printf("Error catching signals !\n");
> >   
> >   if (rl_set_signals() != 0)
> >   
> >     printf("Error setting signals !\n");
> >   
> >   while (1)
> >   
> >     {
> >     
> >       rl_gets();
> >     
> >     }
> >   
> >   return 0;
> > 
> > }
> > 
> > make main CXXFLAGS=-I/usr/include/xenomai LDFLAGS="-lnative -lpthread -
> > lncurses -lreadline -lxenomai"
> > 
> > ./main
> > <now resize your xterm window>
> > Segmentation fault
> 
> You can not do that, Xenomai requires that xeno_sigwinch_handler be
> called when SIGWINCH is received. To do that, you have either:
> - to arrange for Xenomai xeno_sigshadow_install_once to be called after
> the time when readline installs its handlers, that is what calling
> xeno_sigshadow_install achieved, but this was fragile
> - use another signal than SIGWINCH as internal signal used by Xenomai,
> at the expense of some additional line launching gdb.
> - define your own signal and handle correctly both Xenomai and
> libreadline signals in that handler.

So what I did to get it to work is this:

declare in my own files (a C++ program):
extern "C"
int xeno_sigwinch_handler(int sig, siginfo_t *si, void *ctxt);

-> this function is nowhere declared in a header

Then write:
void rl_sigwinch_handler(int sig, siginfo_t *si, void *ctxt) {
        if (xeno_sigwinch_handler(sig, si, ctxt) == 0)
            rl_resize_terminal();
}

And when initializing readline:

        rl_catch_sigwinch = 0;
        struct sigaction sa;
        sa.sa_sigaction = &rl_sigwinch_handler;
        sa.sa_flags = SA_SIGINFO;
        sigaction(SIGWINCH, &sa, 0);

which works. I have guarded the xenomai-specific code with #if 
CONFIG_XENO_VERSION_MAJOR == 2 && CONFIG_XENO_VERSION_MINOR >= 5
stanzas. I'm not sure at which exact version this function was introduced.

Thanks for oiling my rusty signal handling skills.

Peter

