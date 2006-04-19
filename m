Message-Id: <1145411899.5895.259379343@domain.hid>
From: "Saul" <xeno@domain.hid>
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="ISO-8859-1"
MIME-Version: 1.0
References: <1145337376.31480.259295744@domain.hid>
	<44453E0B.8030509@domain.hid>
Subject: Re: [Xenomai-help] PC suggestions for visual control
In-Reply-To: <44453E0B.8030509@domain.hid>
Date: Wed, 19 Apr 2006 11:58:19 +1000
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Jim Cromie wrote:
> Saul wrote:
> > Hi,
> >
> > I would be interested in hearing from people about the PC's that you
> > use that are known to work well with Xenomai. I'd be looking for a
> > fast new desktop PC for image processing and aircraft control tasks.
> > Is AMD a better bet?
> >
> > Any suggestions much appreciated.
> >
> > Saul.
>
>
> Can you describe the workload a bit more fully ?
>
> images - size, bpp, FPS, processing tasks ( FFTs, blurring,
> convolving, smoothing, etc) ? control tasks - latency reqs, control-
> loop frequency,

All of the above :) The images are usually 8-bit greyscale 640x480 at up
to 50Hz. Among other things we are using image motion and stereo for
obstacle avoidance/terrain following and image segmentation for attitude
stabilization. During initial development we like to have a fast desktop
PC in the loop (on the ground) to perform video capture/processing,
control loops and to send servo positions.

In the past we ran an RTAI kernel module on low-res images at 50Hz, but
I like the idea of running in Xenomai user-mode. I purchased a new Intel
P4 3.0GHz on 915G (ICH6 Family) and it has caused no end of trouble with
enormous intermittent delays during processing, while the latency test
works perfectly perhaps ruling out SMI as the cause.

> I recall hearing that RTAI can run at audio rates (44 khz), but its
> unclear what the workload is (small FIRs IIRs ??) RTAI plays some
> 'tricks' that are counter to xenomai's goals of clean, tight
> integration with linux, so it may not get the same khz numbers.
>
> since you said FAST, you should look at a dual-core - this gives you
> some room to assign your workloads to the cores, thus better
> controlling context switching.  This could be important for your image
> processing task thruput, and for latency too, since the rt tasks wont
> have to reclaim the cpu just to resume their work.

Yeah, dual core could be very handy. I would just like to hear from
someone with a setup they have tried such that they can say "this works,
no problem, I love Xenomai", not necessarily with image processing.
Xenomai seems very promising but I can't afford any more weeks trying to
fix the problem with my existing hardware - perhaps later.

> BTW - I cant help but observe: Id be leery of recommending any PC
> architecture for autopilot duties on an Airbus A-380. Maybe its just
> the MS legacy dragging down the ole  PC-XT reputation ;-) Ctrl-Alt-
> Delete is not an option :-D

Agreed :) Luckily it's only for algorithm testing.

Thanks in advance,

Saul.

