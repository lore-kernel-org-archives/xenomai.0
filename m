Message-ID: <4F17487C.8080508@domain.hid>
Date: Wed, 18 Jan 2012 23:32:28 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <28CCC3D1EEE841E184D8E5663EBDCCBE@TerryHP>
	<4F171C09.8010908@domain.hid>
	<E80344556EFF403586E4B8CAE727382F@TerryHP>
In-Reply-To: <E80344556EFF403586E4B8CAE727382F@TerryHP>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Compile error
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Terry Fryar <terry.fryar@domain.hid>
Cc: xenomai@xenomai.org

On 01/18/2012 10:44 PM, Terry Fryar wrote:
> I knew I wouldn't get enough...but I have other projects in between those
> timing requirements and I wanted to see how little latency I could get.
> Using an RTDM driver we wrote, I am measuring about 2us (not 20us) by
> triggering an irq off a gpio and pulsing another gpio line and measuring the
> difference between the irq edge and the pulsed edge using a logic analyzer.

That is probably because you are not measuring latency under load. So,
you do not see the worst case.

> I have a board that runs a suhdol linux sbc that is somehow handling gpio
> interactions within nanosecond ranges, and I have no idea how that is being
> done.  Even flipping a gpio pin with direct register access inside a KLM is
> around 62ns.  I just don't know how they are managing to detect a gpio pin
> state change and respond to several things all within a couple hundred ns??
> 
> I've looked at their app files and it's just a gpio driver and what appears
> to be a single userspace app.  A mystery I guess.....

I am talking about worst case here, not about average case.

-- 
                                                                Gilles.

