MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18349.51607.459245.139367@domain.hid>
Date: Sat, 9 Feb 2008 16:41:11 +0100
In-Reply-To: <47A63D49.4050700@domain.hid>
References: <18340.31233.591834.293535@domain.hid>
	<47A63D49.4050700@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-core] [PATCH 0/5] Support for select v2.
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

Jan Kiszka wrote:
 > Gilles Chanteperdrix wrote:
 > > Hi,
 > > 
 > > after some tests, bug fixes and optimizations, here comes a second version of 
 > > the patch-set adding select support to xenomai posix skin.
 > > 
 > 
 > Puh, a lot of code, and my brain is still full of KGDB stuff I'm trying
 > to polish for mainline since days.
 > 
 > The approach looks consistent to me. I would just suggest to make the
 > whole thing configurable, so that it doesn't add overhead to systems
 > which do not use it.

I am getting back to this select stuff. So I have a question, would you
agree if the select support was made configurable, but if when this
support was enabled, support for select was added to vanilla
rtdm_event_t and rtdm_sem_t ? This would ease maintenance, since it
would avoid a lot of code duplication, without adding to much overhead
in my opinion (an empty list test when signaling the objects).

 > 
 > Out of curiosity: Did you already have a chance to compare a
 > multi-threaded demo application with one based on these new select services?
 > 
 > I guess your current test cases are built on top of RTnet, aren't they?
 > Would be nice, also for regression testing, to have some demo for
 > /examples, e.g. exploiting the CAN stack (because it has virtual CAN,
 > thus it is usable without hardware).

Ok, I had a look at the CAN stack, if I understand correctly when
receiving, the recv_sem defined in rcan_socket.h is used, and when
sending, the tx_sem defined in rtcan_dev.h is used. Can you confirm this
? 

-- 


					    Gilles Chanteperdrix.

