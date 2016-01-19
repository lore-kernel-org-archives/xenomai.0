Date: Tue, 19 Jan 2016 16:41:11 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20160119154111.GD20681@hermes.click-hack.org>
References: <CACBbF4VV6EwNub2A2R3t-xhUc5X=F9kY9MU=+f3Y3eAsHVDwuA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACBbF4VV6EwNub2A2R3t-xhUc5X=F9kY9MU=+f3Y3eAsHVDwuA@mail.gmail.com>
Subject: Re: [Xenomai] rtskbs gone missing in 3.0.x stable versions,
 breaking most of RTnet
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "LOYAU, Florian" <florian.loyau@edu.esiee.fr>
Cc: xenomai@xenomai.org

On Tue, Jan 19, 2016 at 04:00:17PM +0100, LOYAU, Florian wrote:
> (...)
> We're majorly confused regarding the state of the support of the different
> drivers at present, and what looks like compat-breaking changes between
> RTnet 1.7, Xenomai 3 RC, and Xenomai 3 stable. Can you provide us with
> some information on the state of support and pointers on what can be done
> to fix these problems ?

First, Xenomai 3 made a lot of compat-breaking changes, so much that
there is a web page documenting them:
https://xenomai.org/migrating-from-xenomai-2-x-to-3-x/

The plan with RTnet is to modernize its core, while finding a way to
reuse more easily the mainline ethernet drivers core.

To this end, RTnet was merged in 3.0 and the most obvious problems
were fixed rapidly, like some ugly infinite loops replaced with
reference counting. The changes to reference counting broke loopback
in 3.0.1, which is a special case, and was fixed by allocating a
pool for that device, and should currently be fixed (which you
failed to mention). The result of that merge was tested on a few
drivers, including loopback, igb, e1000e, macb and r8169.

FEC was disabled because it did not compile, and I would rather have
it disabled than not compiling, and would prefer trying to re-user
mainline code when RTnet has been reworked than trying to fix what
we have. But if you have some patches to fix what we have, I am
interested.

After this merge, I did not work on RTnet during almost a year, but
the work resumed recently with the addition of a testsuite, the plan
is for the "big rework" to happen in the 3.x branch, while checking
with the teststuite that we have no regression.

If you have some precise bug reports to provide, maybe we can fix
them by working together.

Regards.

-- 
					    Gilles.
https://click-hack.org

