Message-ID: <45C0615B.5060909@domain.hid>
Date: Wed, 31 Jan 2007 10:28:59 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: Antwort: Re: [Xenomai-core] Questions about pSOS task mode and
	task priority
References: <OF5910DE28.1586BCD6-ONC125726F.005E4D75@domain.hid>	
	<1169832375.3346.67.camel@domain.hid> <45BDF5D8.4020607@domain.hid>	
	<1170204016.21219.49.camel@domain.hid> <45C05975.3060900@domain.hid>
	<1170234649.25426.4.camel@domain.hid>
In-Reply-To: <1170234649.25426.4.camel@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rpm@xenomai.org
Cc: Markus Osterried <Markus.Osterried@domain.hid>, xenomai@xenomai.org, Thomas Necker <Thomas.Necker@domain.hid>

Philippe Gerum wrote:
>>>In short, the following patch against 2.3.0 stock fixes the issue,
>>>allowing threads to block while holding the scheduler lock. 
>>
>>Ok, but this means that the skins which use XNLOCK with the previous
>>meaning need fixing.
>>
> 
> 
> Only those which really wanted - i.e. by design - to return an error
> flag (or the board to lockup or panic) in case of a thread going to
> sleep while holding the schedlock. This change does not affect the
> schedlock semantics otherwise.
> 

I do not understand how it works, I mean, how do you know, in
xnpod_schedule, if xnpod_schedule was voluntarily called by the current
thread, or was called upon reception of an interruption ?

-- 
                                                 Gilles Chanteperdrix

