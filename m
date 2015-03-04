Date: Wed, 4 Mar 2015 18:42:52 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150304174252.GF30672@hermes.click-hack.org>
References: <CA+C+_XTfx6fAC3UvATJULBqogpvAOozwNkop=6Vj+jPYondj9Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+C+_XTfx6fAC3UvATJULBqogpvAOozwNkop=6Vj+jPYondj9Q@mail.gmail.com>
Subject: Re: [Xenomai] Debugger and secondary mode question
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Mathew Benson <mathew.benson@gmail.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Wed, Mar 04, 2015 at 11:33:46AM -0600, Mathew Benson wrote:
> I fixed all my toolchain problems and am finally back to debugging my
> code.  Thanks for the help earlier.
> 
> It looks like gdbserver causes suspended threads to drop back down to
> secondary mode, 

Yes, that is expected/

> causing my rt_... calls to return ENOSYS.

What rt_ calls ? If you are talking about rtdm calls, returning
ENOSYS should cause xenomai to switch again to primary mode, so is
not an issue. Are you sure you do not mean EINTR ? Because yes, some
calls can return EINTR when interrupted by a signal (which is what
happens when running gdb), and if this is not handled by the call
itself (for instance pthread_mutex_lock does not expose EINTR, it is
handled in the user-space function itself), then your application
should handle it.

>  Is there
> anything I can do to prevent this?  I expect its unavoidable.

There is no way to run gdb without signals.

> 
> If I can't stop it, does anybody have any recommendations of how to make
> code resilient to this? 

Test EINTR,and try again when it happens.

> I'm mostly just using mutexes and semaphores in my
> main loop.  Can I mix real time and non-realtime functions with the same
> handle?  In other words, what happens to a rt semaphore when the thread
> transitions back to secondary mode?  Does the handle refer to a non rt
> version now, or is it just inaccessible?

Xenomai will switch back to primary mode as soon as needed. An rt
semaphore or mutex is rt-only, it has no secondary mode counterpart.

-- 
					    Gilles.

