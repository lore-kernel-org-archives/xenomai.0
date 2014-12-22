MIME-Version: 1.0
Sender: justinhartubc@gmail.com
In-Reply-To: <20141220162937.GA12315@daedalus.click-hack.org>
References: <CAFgu5KXBDRLxt4q3PUw9he+4Z97RV0=Q96Y+or7FzEwT3CVZRA@mail.gmail.com>
 <20141220153337.GD24110@csclub.uwaterloo.ca> <20141220160408.GB3961@daedalus>
 <20141220162139.GF24110@csclub.uwaterloo.ca>
 <20141220162937.GA12315@daedalus.click-hack.org>
From: Justin Hart <justin.hart@mech.ubc.ca>
Date: Mon, 22 Dec 2014 11:57:50 -0800
Message-ID: <CAFgu5KVAKhXC+Tzds-b2P5o6+u+xBwZz_tL5-j2GL6sjbkme4g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] Kernel Configuration Woes
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Sorry for the delayed reply!  I was a bit under the weather this weekend.
I think that you folks have hit on my alternate hypothesis: that I am doing
something in my program in the real-time thread that is causing problems.
It's a little weird, because I am linking against libbarrett.  I wrote a
wrapper to the arm code that gives me a simple simulated arm or the real
arm, based on how the program is invoked.  When it's not the real arm,
however, nothing that interacts with xenomai is launched.  I'm going to do
some testing today and see if I can narrow in on the problem.  I might have
some more questions.  Thanks for the help so far, though!

On Sat, Dec 20, 2014 at 8:29 AM, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:

> On Sat, Dec 20, 2014 at 11:21:39AM -0500, Lennart Sorensen wrote:
> > On Sat, Dec 20, 2014 at 05:04:08PM +0100, Gilles Chanteperdrix wrote:
> > > To make it simple: from Linux point of view, Xenomai behaves just as
> > > an SMI.
> >
> > Certainly true, but that's the software you control so you can make it
> > behave itself.
>
> Well, the only way to make it behave itself is to not run it at all,
> because as soon as Xenomai run its threads, it "steals" time to
> Linux. So, the workaround is to get it to run not too long, but it
> is not guaranteed to be sufficient to avoid detection, and the other
> workaround is to disable Linux detection mechanisms.
>
> --
>                                             Gilles.
>
