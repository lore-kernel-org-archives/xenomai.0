Message-ID: <44453E0B.8030509@domain.hid>
Date: Tue, 18 Apr 2006 15:29:15 -0400
From: Jim Cromie <jim.cromie@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] PC suggestions for visual control
References: <1145337376.31480.259295744@domain.hid>
In-Reply-To: <1145337376.31480.259295744@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Saul <xeno@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Saul wrote:
> Hi,
>
> I would be interested in hearing from people about the PC's that you use
> that are known to work well with Xenomai. I'd be looking for a fast new
> desktop PC for image processing and aircraft control tasks. Is AMD a
> better bet?
>
> Any suggestions much appreciated.
>
> Saul.
>
>   


Can you describe the workload a bit more fully ?

images - size, bpp, FPS, processing tasks ( FFTs, blurring, convolving, 
smoothing, etc) ?
control tasks - latency reqs, control-loop frequency,

I recall hearing that RTAI can run at audio rates (44 khz),
but its unclear what the workload is (small FIRs IIRs ??)
RTAI plays some 'tricks' that are counter to xenomai's goals
of clean, tight integration with linux, so it may not get the same khz 
numbers.

since you said FAST, you should look at a dual-core -
this gives you some room to assign your workloads to the cores,
thus better controlling context switching.  This could be important
for your image processing task thruput, and for latency too, since
the rt tasks wont have to reclaim the cpu just to resume their work.


BTW - I cant help but observe:
Id be leery of recommending any PC architecture for autopilot duties on 
an Airbus A-380.
Maybe its just the MS legacy dragging down the ole  PC-XT reputation ;-)
Ctrl-Alt-Delete is not an option :-D

