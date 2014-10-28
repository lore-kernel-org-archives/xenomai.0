Date: Tue, 28 Oct 2014 16:34:40 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141028153440.GA11779@sisyphus.hd.free.fr>
References: <CABaOOZ2YOda_cUS-tskNxDZ6sNekMqnPnbu6p8Qp4kvjRzDMyA@mail.gmail.com>
 <543E9BAE.2010808@xenomai.org> <543E9CF5.6080400@xenomai.org>
 <CABaOOZ1Hb5YYBXt2jtyTZWVnA03EGohaVChzEJ0X9=od2=SeNw@mail.gmail.com>
 <543F8974.4070400@xenomai.org>
 <CABaOOZ0aEf8F3EzW=w4R1OgK0SGzE9VnDAJHV+swmSc3EF9O-w@mail.gmail.com>
 <543F900D.3050500@xenomai.org>
 <CABaOOZ0gmn2XnoF+pzPVWEU0Fh7WfafJduk5qUnknp5pk8V2bQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABaOOZ0gmn2XnoF+pzPVWEU0Fh7WfafJduk5qUnknp5pk8V2bQ@mail.gmail.com>
Subject: Re: [Xenomai] Manual context switch from userspace
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Stratiyenko Roman <picoworm@gmail.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Fri, Oct 17, 2014 at 12:04:35PM +0300, Stratiyenko Roman wrote:
> Thank you for helping. I replaced swapcontext with longjmp. All works good.
> No switch to secondary mode.
> 
> As about using threads, I do not fully understand how scheduler works.
> Maybe after I will get more experience in multithreading, I will do as you
> recommend.

Well, this comes late, but I have found a library libtask:
http://swtch.com/libtask/

which does a bit what you want to do, exposing a thread-like API.
What may be interesting for you is that they provide replacements of
makecontext and setcontext for OSes which have no native support for
it, and this does not rely on any system call as far as I can tell,
it will not switch to secondary mode. So you can probably use it on
Linux and bypass the glibc versions. Note however that their context
switching code does not switch the FPU registers, this may be a
performance advantage if you do not use the FPU, but it means it
will not work if you want to switch context in the middle of a
computation using FPU registers.

-- 
					    Gilles.

