From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <CAMJ=MEe1Rt_uMQSW_8WX6oSBZ3ppyY=+rV20kXWRMpELQ71TQQ@mail.gmail.com>
References: <CAAXf6LVErpVae0HVcqv4Rc6p2wnJLje7He2NJC7S1aCSVnD9NQ@mail.gmail.com>
	<1316360236.2169.40.camel@domain.hid>
	<8236197CA3DA864F9EF20609D9887263B4D0@domain.hid>
	<CAMJ=MEeOS2K09fm0hnvSmxn6CBbMjHaC-uhDr03qNoZTaEbWVA@mail.gmail.com>
	<CAAXf6LX4gfVncvRo5UTyMrqWHhJ6K0ioksyTqvovAjpJyZWS3w@domain.hid>
	<4E80F2A0.9030500@domain.hid>
	<CAAXf6LXQ=Jq5E_JV_JSbqE1wgheaVLLLZQDyRn5TSmrET-PKVA@mail.gmail.com>
	<4E95A28B.3060505@domain.hid> <1318435016.2112.73.camel@domain.hid>
	<CAMJ=MEe1Rt_uMQSW_8WX6oSBZ3ppyY=+rV20kXWRMpELQ71TQQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 12 Oct 2011 23:12:32 +0200
Message-ID: <1318453952.2112.102.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] PSOS skin: mismatch in function signatures cause
 buffer overflow
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Ronny Meeus <ronny.meeus@domain.hid>
Cc: Xenomai-help@domain.hid, dietmar.schindler@domain.hid

On Wed, 2011-10-12 at 19:24 +0200, Ronny Meeus wrote:
> On Wed, Oct 12, 2011 at 5:56 PM, Philippe Gerum <rpm@xenomai.org> wrote:
> > On Wed, 2011-10-12 at 16:22 +0200, Gilles Chanteperdrix wrote:
> >> On 10/12/2011 04:03 PM, Thomas De Schampheleire wrote:
> >> > Hi,
> >> >
> >> > On Mon, Sep 26, 2011 at 11:46 PM, Gilles Chanteperdrix
> >> > <gilles.chanteperdrix@xenomai.org> wrote:
> >> >> On 09/19/2011 10:45 AM, Thomas De Schampheleire wrote:
> >> >>> Hi,
> >> >>>
> >> >>> On Mon, Sep 19, 2011 at 9:42 AM, Ronny Meeus <ronny.meeus@domain.hid> wrote:
> >> >>>> On Mon, Sep 19, 2011 at 9:25 AM,  <dietmar.schindler@domain.hid> wrote:
> >> >>>>>> From: xenomai-help-bounces@domain.hid [mailto:xenomai-help-bounces@domain.hid]
> >> >>>>>> On Behalf Of Philippe Gerum
> >> >>>>>> Sent: Sunday, September 18, 2011 5:37 PM
> >> >>>>>> ...
> >> >>>>>> Actually, we used to follow strictly the pSOS convention for this until
> >> >>>>>> 2.4.x, at which point we moved to name strings precisely because
> >> >>>>>> non-null terminated char[4] arrays would break the registry, the way you
> >> >>>>>> described. This is one of the rare situations where mimicking a useless
> >> >>>>>> limitation of the original API may be challenged by usability concerns
> >> >>>>>> in the new environment, and usability won in that case. The problem
> >> >>>>>> mostly comes from the fact that char[4] is automatically convertible to
> >> >>>>>> const char *, so we have no warning/error leading us to check the
> >> >>>>>> potentially problematic call sites.
> >> >>>>>>
> >> >>>>>> The concern about moving back to char[4] arrays - null-terminated if
> >> >>>>>> shorter - is for people who currently assign strings longer than 4
> >> >>>>>> characters to name their objects. What could be done, is providing a
> >> >>>>>> build switch to select the accepted input, like
> >> >>>>>> --disable-psos-long-names to turn on char[4] interpretation.
> >> >>>>>
> >> >>>>> While I would prefer the switch --enable-psos-long-names, this sounds okay to me, the more so as it is more than people who use the pSOS skin without obeying pSOS rules deserve.
> >> >>>>> --
> >> >>> [..]
> >> >>>>>
> >> >>>>
> >> >>>> Another option would be to introduce a run-time switch.
> >> >>>> The default behavior could be that long names are supported and if the
> >> >>>> "enable_short_names()" function is called, all names will the cut at 4
> >> >>>> characters.
> >> >>>> The advantage of this dynamic switch is that different applications
> >> >>>> using the same library can use the mode they prefer.
> >> >>>
> >> >>> I would also be in favor of a runtime setting, rather than a
> >> >>> compile-time one. One cannot assume that all PSOS applications on a
> >> >>> system follow the same rules, or that there cannot be a mix of
> >> >>> 'legacy' PSOS applications and 'xenomai-style' ones. According to me,
> >> >>> a library should support all these uses.
> >> >>
> >> >> Hi,
> >> >>
> >> >> here is a patch which truncates identifiers to four characters and
> >> >> terminates them by a '\0' character, in order to avoid the issues at
> >> >> the origin of this thread. The patch also adds a variable
> >> >> "psos_long_names", 0 by default, which may be set to a non-zero value
> >> >> to enable the old behaviour (assume the identifier strings may be
> >> >> longer than 4 characters and are already null terminated).
> >> >>
> >> >> Could someone with the issue test it?
> >> >
> >> > It seems this slipped through the cracks, my apologies. We already
> >> > implemented this ourselves similarly, we didn't actually test your
> >> > patch so far.
> >> >
> >> > Now that we're trying out xenomai-forge, I ported this patch and tested it.
> >> > There are a few problems with it (also relevant to cobalt xenomai)
> >> >
> >> > * a bug in __psos_maybe_short_name so that only 3 characters are
> >> > retained (see below)
> >> > * the call to __psos_maybe_short_name also needs to be done in the
> >> > _ident functions
> >> > * although we don't use it, I think the pt_create and pt_ident
> >> > functions also need to be adapted
> >> >
> >> > Moreover, I wonder why you have made psos_long_names an exported
> >> > global variable. Sharing variables between two different pieces of
> >> > software is not very clean. I think it would be nicer with a get/set
> >> > function.
> >>
> >> Thanks for the review. The exported global variable is the simplest
> >> possible and sufficient implementation of this feature. You risk having
> >> a hard time convincing us otherwise.
> >
> > Ack.
> >
> >>
> >> --
> >>                                           Gilles.
> >>
> >> _______________________________________________
> >> Xenomai-help mailing list
> >> Xenomai-help@domain.hid
> >> https://mail.gna.org/listinfo/xenomai-help
> >
> > --
> > Philippe.
> >
> >
> >
> > _______________________________________________
> > Xenomai-help mailing list
> > Xenomai-help@domain.hid
> > https://mail.gna.org/listinfo/xenomai-help
> >
> 
> Another simple solution would be to have a function available to set
> this mode. In that way the internal implementation can be changed
> without impact on the applications. I think it is always good to use a
> setter since this is more future safe.

That function would do nothing else than setting an internal variable
with a global scope, be it a function pointer. In that case, a setter
brings no value, but would clutter the public interface. The problem
with the cleanliness argument raised earlier is that it vastly depends
on where someone wants to put the dirt.

I don't think we should spent too much time on this anyway, I'd rather
solve the issue of handling duplicate pSOS object names. It is possible
to implement this in -forge, the last concern is about the complexity vs
usefulness ratio which I still find a bit high, so I want to try a
simpler implementation.

> 
> We also implemented the function tm_getm to get a timestamp in an
> efficient way. This function was available in the xenomai-2.5.6 (as a
> kind of extension on the psos interface) but in missing in the force
> version.

Ok.

> I hope this code will also be in the patch that Thomas will send.
> 
> Ronny

-- 
Philippe.



