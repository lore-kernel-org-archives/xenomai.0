References: <CAHoW4hGmcH5kLzwi-B3LfMrioqdj3TQ_5S8rGP6MbRudcwEBDA@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <56BB9BE5.80505@xenomai.org>
Date: Wed, 10 Feb 2016 21:21:57 +0100
MIME-Version: 1.0
In-Reply-To: <CAHoW4hGmcH5kLzwi-B3LfMrioqdj3TQ_5S8rGP6MbRudcwEBDA@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Process shared rt_event_wait() never signaled on ARM
 with Mercury core
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Charles Kiorpes <ckiorpes@gmail.com>, xenomai@xenomai.org

On 02/10/2016 07:41 PM, Charles Kiorpes wrote:
> Hello,
> I am having some difficulty getting two processes to signal each other on
> an AM572x EVM.
> I have two small sample applications:
> 
> - app1 : creates an event "MYTEST" using rt_event_create(), clears the
> event, and then rt_event_wait()s for TM_INFINITE.  When the event is
> signaled, app1 rt_event_clear()s the event and then loops back to the
> rt_event_wait()
> 
> - app2 : binds to the "MYTEST" event, sleeps for one second,
> rt_event_signal()s the event, and then loops back to the one second sleep
> 
> I am using the Mercury core, built natively, configured with:
> xenomai-3.0.1/configure \
> --with-core=mercury \
> --enable-debug \
> --enable-pshared \
> --disable-registry \
> --enable-smp \
> --enable-condvar-workaround
> 
> I launch both applications in different terminals in this order:
> # sudo ./app1 --session="Test"
> # sudo ./app2 --session="Test"
> 
> The following behavior results:
> - app1 claims to have successfully created the event
> - app2 claims to have successfully bound to the event
> - app2 loops correctly, signalling the event once per second
> - app1 never wakes up from the first rt_event_wait()
> 
> I am running the 4.1.15-ti-rt kernel with full preemption.
> 
> On an x86 virtual machine with a vanilla 4.2.0-27-generic kernel, the
> applications perform as expected (app1 wakes up when app2 signals the
> event).
> 
> Any advice as to where to look for further debugging would be greatly
> appreciated.
> 

Over Mercury, the event synchronization is based on a common
mutex+condvar pair obtained from the underlying *libc basically. The
rest of the implementation for this mechanism is shared with the Cobalt
side, except the workaround for the PI breakage the glibc suffers, which
is Mercury-only.

- does omitting --enable-condvar-workaround change the behavior?
- does this issue also happen when both threads belong to the same
process (i.e. is it a session-based processing issue?)
- does the code check for each and every return code, particularly the
return status of rt_event_signal()? Attaching your self-contained test
case may help finding out where the problem stands.
- after enabling the registry (--enable-registry), is the reported event
value consistent when looking at
/var/run/xenomai/<user>/Test/alchemy/events/<event_name>?

Also, you have a test suite available for Alchemy, which can run on
either Mercury/Cobalt cores unmodified. There is a test exercising
events there.

e.g.:

$ cd lib/alchemy/testsuite
$ make XENO_CONFIG=/your/xenomai/install/bin/xeno-config test

NOTE: The "test" rule in the Makefile assumes that the current shell
user is sudoer.

-- 
Philippe.

