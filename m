Resent-Message-ID: <18187.11689.796009.250597@domain.hid>
Resent-To: xenomai@xenomai.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18186.42065.560821.557825@domain.hid>
Errors-To: linux-arm-bounces+gilles.chanteperdrix=gmail.com+gilles.chanteperdrix=gmail.com@domain.hid
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <305035a40709140817q452ca77dude2af88ce6fc3dd9@domain.hid>
References: <515338.44993.qm@domain.hid>
	<80b317760709110456k2ef95162t19d833da7c5781de@domain.hid>
	<46E699C6.80609@domain.hid>
	<305035a40709140817q452ca77dude2af88ce6fc3dd9@domain.hid>
Date: Tue, 09 Oct 2007 00:28:46 -0700 (PDT)
Subject: Re: [Xenomai-core] RTOS porting on ARM
Reply-To: xenomai@xenomai.org
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
Cc: linux-arm@domain.hid, xenomai@xenomai.org

gclement00 at gmail.com (Gregory CLEMENT) wrote:
 > 2007/9/11, Bill Gatliff <bgat@domain.hid>:
 > > Richard Genoud wrote:
 > > >>   For an industrial control application, i need to port an RTOS pn ARM9 specifically, cirrus logic based ARM. Can anyone suggest me the chances of porting RT Linux on this ARM core. if not any other RTOS please.
 > > >>
 > > >
 > > > Hi !
 > > >
 > > > we've started to port xenomai and RTAI to arm9 (AT91RM9200 & AT91SAM926x)
 > > >
 > > > you can download the patches here :
 > > > http://www.adeneo.adetelgroup.com/srt/adeneoen/flb/show?location.id:=1452
 > > >
 > > > Richard.
 > > >
 > >
 > > Xenomai already supports the AT91RM9200.
 > 
 > Indeed and now Xenomai supports also AT91SAM9260,  AT91SAM9261 and
 > AT91SAM9263 as our patches are now in adeos.

Hi,

I have found this mail by chance with Google, and could not leave it
unanswered.

First, let me clarify the situation of Xenomai ARM port. It is a
collective work which was started more that two years ago, long before
you (Adeneo) got some interest about it. What you did was merely to
copy/paste the AT91RM9200 port I did to get it to run on
AT91SAM926x. So, please do not let people believe that you are the
authors of this port. And, by the way, ARM ports of RTAI existed for
even more time.

 > 
 > For RTAI we have now a working systeme with have better max latency
 > than Xenomai ( 50us instead of around 100us for Xenomai). I plan to
 > update the patches on our site with this new version and communicate
 > on it on RTAI list as soon as I have some free time.

A good place for discussing about these figures would have been Xenomai
mailing list, a place where we could have answered you immediately. Are
you sure you are not comparing Xenomai user-space scheduling latency
with RTAI kernel-space scheduling latency ?

Please follow up on xenomai@xenomai.org

 > 
 > And to answer to first question there is a porting guide for
 > adeos/xenomai for arm which explain what you have to do for porting
 > adeos/Xenomai for a new ARM based SOC.
 > And in a near futur I hope ther will be the same kinf of documentation for RTAI.
 > 
 > -- 
 > Gregory CLEMENT
 > Adeneo
 > 2, chemin du Ruisseau - BP21
 > 69136 Ecully Cedex
 > France
 > Tel : +33-4 72 18 08 40


-- 


					    Gilles Chanteperdrix.

-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php

