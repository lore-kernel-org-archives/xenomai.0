MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18391.3867.521099.955604@domain.hid>
Date: Wed, 12 Mar 2008 00:00:43 +0100
In-Reply-To: <47D6DD05.2040007@domain.hid>
References: <47D6CD29.4020700@domain.hid>
	<2ff1a98a0803111127p7868350axa976c68714cf4f05@domain.hid>
	<47D6DD05.2040007@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-help] What have I misunderstood about condition
	variables
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Anders Blomdell <anders.blomdell@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

Anders Blomdell wrote:
 > Gilles Chanteperdrix wrote:
 > > On Tue, Mar 11, 2008 at 7:19 PM, Anders Blomdell
 > >>  To me the symptoms indicate that the high priority producer gets the mutex and
 > >>  signals it before the consumer has properly started to wait on the condition.
 > > 
 > > I have not read your program in detail, but what may be your problem
 > > is that condition variables are not semaphores: if you signal a
 > > condition variable when nobody is waiting the signal is lost. 
 > I know this, but the problem is that the program loses signals when it is
 > waiting. In the consumer:

Sorry for the noise (and thanks for the patch).

-- 


					    Gilles Chanteperdrix.

