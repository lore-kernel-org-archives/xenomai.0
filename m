From: Wolfgang Denk <wd@denx.de>
Subject: Re: [CXP][RFC] Pick RTDM for the common kernel interface
MIME-Version: 1.0
Content-type: text/plain; charset=UTF-8
Content-transfer-encoding: 8bit
In-reply-to: <87pn3mzxeh.fsf@xenomai.org>
References: <87pn3mzxeh.fsf@xenomai.org>
Date: Mon, 14 Dec 2020 08:29:33 +0100
Message-ID: <439019.1607930973@gemini.denx.de>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, Philippe Gerum via Xenomai <xenomai@xenomai.org>

Dear Philippe,

In message <87pn3mzxeh.fsf@xenomai.org> you wrote:
> 
> PROPOSAL: Adopt a large subset of the current RTDM specification as
> the common kernel interface defined by the CXP. The exact set of RTDM
> services which should be retained in the CXP implementation must be
> discussed further.
>
> As a consequence, Xenomai 4 would provide a RTDM layer based on the EVL
> core interface internally, which would preserve the driver taxonomy
> ("named" / "protocol") and registration model inherited from its Xenomai
> 3.x counterpart.

RTDM is a complex story.  Once upon a time it served a number of
important purposes; even providing a common driver interface for
Xenomai and PREEMPT_RT (search for Xenomai/SOLO if you cannot
remember).  It may have beennecessary, but I have to admit that I am
not 100% happy with it either.  I have seen way toomany situations
where the need to hava RTDM drivers for RT use caused a fork from
the mainline Linux drivers, resulting in bitrot and lots of
frustration becuase we had to deal with problems that were long
fixed in the upstream drivers, while theRTDM counterparts received
basically no maintenance.


Yes, I agree to adapt a subeset of RTDM as a common kernel
interface.  But it should be clear that this is mostly to allow
re-use of existing code and to easy migration.

Whenever we run into problems with that, we should not look back too
long but rather focus on a new, clean and efficient (and easy to
maintain) design.  Having RT capable drivers in mainline would be
much, much better.

So ACK.

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
"There is such a fine line between genius and stupidity."
- David St. Hubbins, "Spinal Tap"

