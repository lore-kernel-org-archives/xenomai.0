Date: Thu, 6 Aug 2015 09:49:39 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150806074939.GA20331@hermes.click-hack.org>
References: <CAHoW4hFHAmGqFOdDp3QHXK-6w0NQEw8XBxOc8kJkVUQAvEfT_w@mail.gmail.com>
 <55C22EED.4040704@xenomai.org>
 <20150805172427.GA21690@hermes.click-hack.org>
 <55C30F85.1090505@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <55C30F85.1090505@xenomai.org>
Subject: Re: [Xenomai] Segfaults and ENOMEM during rt_event_create()
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Charles Kiorpes <ckiorpes@gmail.com>, xenomai@xenomai.org

On Thu, Aug 06, 2015 at 09:40:53AM +0200, Philippe Gerum wrote:
> On 08/05/2015 07:24 PM, Gilles Chanteperdrix wrote:
> > On Wed, Aug 05, 2015 at 05:42:37PM +0200, Philippe Gerum wrote:
> >> On 05/08/2015 15:09, Charles Kiorpes wrote:
> >>> Hello,
> >>>
> >>> I am trying to port a fairly large application from Xenomai 2.6.4 to
> >>> Xenomai 3.0-rc6
> >>>
> >>> Most of the port has been decently painless, but there is one issue I
> >>> can't seem to get past.
> >>>
> >>> I am consistently getting ENOMEM errors and segfaults in
> >>> libcopperplate.so during rt_event_create(), and always at the same
> >>> spot in my application.
> >>>
> >>> If a segfault occurrs, the dmesg output from the segfault looks like =
this:
> >>> [   235.422300] PortProcess[1502]: segfault at f1b3ebeb ip b76c14b7 sp
> >>> bfeae498 error 5 in libcopperplate.so.0.0.0[b76b7000+14000]
> >>>
> >>> The application uses a large number of named event flag groups.  At
> >>> the time that the error occurs, it is looping to create 32 new named
> >>> event groups.
> >>>
> >>> I have increased these values in my kernel config:
> >>> CONFIG_XENO_OPT_REGISTRY_NRSLOTS=3D4096
> >>> CONFIG_XENO_OPT_SYS_HEAPSZ=3D512
> >>> CONFIG_XENO_OPT_PRIVATE_HEAPSZ=3D128
> >>> CONFIG_XENO_OPT_SHARED_HEAPSZ=3D128
> >>>
> >>> When I dig through the /proc/xenomai filesystem, I see that:
> >>> - I am only using 383/4096 registry slots
> >>> - My system heap is about half full (284160KB free of 524288KB)
> >>> - My shared and private heaps are basically empty
> >>>
> >>> My application is launched with --mem-pool-size=3D400000.  The main h=
eap
> >>> (in /registry/user/session/system) has about 220KB used at the point
> >>> that the error occurs.
> >>> Increasing the mem-pool-size does not change the behavior.  I have
> >>> also tried further increasing the values of my system (1024), private
> >>> (256), and shared (256) heapsizes, with no effect.
> >>>
> >>> Obviously I've missed something, but I can't figure out where the
> >>> error is occurring.
> >>>
> >>> System details:
> >>> OS: Debian Jessie 32-bit
> >>> Kernel: 3.18.12 - patched using Xenomai 3.0-rc6
> >>> System: Intel Xeon W3503 (x86 architecture)
> >>> I-Pipe version 1
> >>>
> >>
> >> Any improvement with this patch in?
> >>
> >> commit 574c8e2edb99ff523e765cdb8749dd5259784627
> >> Author: Philippe Gerum <rpm@xenomai.org>
> >> Date:   Wed Aug 5 16:08:23 2015 +0200
> >>
> >>     lib/cobalt: fix private event state accessor
> >>
> >> diff --git a/lib/cobalt/internal.c b/lib/cobalt/internal.c
> >> index 348ca14..62ecb4a 100644
> >> --- a/lib/cobalt/internal.c
> >> +++ b/lib/cobalt/internal.c
> >> @@ -426,7 +426,7 @@ struct cobalt_event_state
> >> *get_event_state(cobalt_event_t *event)
> >>  {
> >>  	return event->flags & COBALT_EVENT_SHARED ?
> >=20
> > I would put parens here.
> >=20
>=20
> I'm trying hard, but I don't see why. The standard is pretty clear about
> the ternary conditional (=A76.5.15): its precedence is right above the
> assignment operators and below anything else, expr0 is evaluated first
> and followed by a sequence point.

I had trouble with if (a & b && c), so am now putting parens around
(a & b) by principle, even if not needed.

--=20
					    Gilles.
https://click-hack.org

