MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18187.11479.59369.746670@domain.hid>
Date: Tue, 9 Oct 2007 09:25:11 +0200
In-Reply-To: <305035a40710082339t16c75581sd07c7f05ed7df9c2@domain.hid>
References: <515338.44993.qm@domain.hid>
	<80b317760709110456k2ef95162t19d833da7c5781de@domain.hid>
	<46E699C6.80609@domain.hid>
	<305035a40709140817q452ca77dude2af88ce6fc3dd9@domain.hid>
	<18186.42065.560821.557825@domain.hid>
	<305035a40710082339t16c75581sd07c7f05ed7df9c2@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-core] RTOS porting on ARM
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gregory CLEMENT <gclement00@domain.hid>
Cc: xenomai@xenomai.org

Gregory CLEMENT wrote:
 > 2007/10/8, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>:
 > > gclement00 at gmail.com (Gregory CLEMENT) wrote:
 > >  > 2007/9/11, Bill Gatliff <bgat@domain.hid>:
 > >  > > Richard Genoud wrote:
 > >  > > >>   For an industrial control application, i need to port an RTOS pn ARM9 specifically, cirrus logic based ARM. Can anyone suggest me the chances of porting RT Linux on this ARM core. if not any other RTOS please.
 > >  > > >>
 > >  > > >
 > >  > > > Hi !
 > >  > > >
 > >  > > > we've started to port xenomai and RTAI to arm9 (AT91RM9200 & AT91SAM926x)
 > >  > > >
 > >  > > > you can download the patches here :
 > >  > > > http://www.adeneo.adetelgroup.com/srt/adeneoen/flb/show?location.id:=1452
 > >  > > >
 > >  > > > Richard.
 > >  > > >
 > >  > >
 > >  > > Xenomai already supports the AT91RM9200.
 > >  >
 > >  > Indeed and now Xenomai supports also AT91SAM9260,  AT91SAM9261 and
 > >  > AT91SAM9263 as our patches are now in adeos.
 > >
 > > Hi,
 > >
 > > I have found this mail by chance with Google, and could not leave it
 > > unanswered.
 > >
 > > First, let me clarify the situation of Xenomai ARM port. It is a
 > > collective work which was started more that two years ago,
 > 
 > I never said anything else.

Read the quoted text again: "we've started to port xenomai and RTAI to arm9 (AT91RM9200 & AT91SAM926x)"

 > >  > For RTAI we have now a working systeme with have better max latency
 > >  > than Xenomai ( 50us instead of around 100us for Xenomai). I plan to
 > >  > update the patches on our site with this new version and communicate
 > >  > on it on RTAI list as soon as I have some free time.
 > >
 > > A good place for discussing about these figures would have been Xenomai
 > > mailing list, a place where we could have answered you immediately. Are
 > > you sure you are not comparing Xenomai user-space scheduling latency
 > > with RTAI kernel-space scheduling latency ?
 > 
 > I thought a best place was RTAI list, as we ever communicated on
 > Xenomai latency on xenomai and adeos list. For example in
 > https://mail.gna.org/public/adeos-main/2007-05/msg00002.html .
 > Unfortunately, I have now a lot to do, and a very few extra time for
 > it :o/ I hope will be able to work on it soon.
 > 
 > 
 > Sorry if it this thread hurt you, it wasn't our intention to claim a
 > work we didn't have done. And I hope we will be able to work again on
 > the subject as there is still room for improvement.

The thing I do not appreciate is the claim about latencies. Either you
are right, and we should find what the problem is, or you are comparing
apples and oranges, and your statistics are totally irrelevant.

-- 


					    Gilles Chanteperdrix.

