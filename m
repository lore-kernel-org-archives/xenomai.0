MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18386.63663.282453.578916@domain.hid>
Date: Sat, 8 Mar 2008 21:35:59 +0100
In-Reply-To: <e39c9190803081026s88acfe1h7dbef2f26ec7acc5@domain.hid>
References: <e39c9190803080255s7020537co8ea96ab71ed6ecc2@domain.hid>
	<47D27C0A.2010507@domain.hid>
	<e39c9190803080624sf49293bwff20317788ad28f7@domain.hid>
	<e39c9190803080942k302e66a6m75ed94dccd55aaac@domain.hid>
	<47D2D537.7020106@domain.hid>
	<e39c9190803081026s88acfe1h7dbef2f26ec7acc5@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-help] Posix skin and message queues operation mode
	misunderstanding
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: juanba romance <juanba.romance@domain.hid>
Cc: xenomai@xenomai.org

juanba romance wrote:
 > On Sat, Mar 8, 2008 at 7:04 PM, Philippe Gerum <rpm@xenomai.org> wrote:
 > 
 > > Yes it does. Maybe contributing the needed support for SIGEV_THREAD to the
 > > Xenomai library would spare you way more invasive changes to your code
 > > base.
 > > After all, honoring SIGEV_THREAD seems to me a matter of running a server
 > > thread
 > > in the background to poll for notifications, which is what we do in a
 > > number of
 > > occasions for other skins. Additionally, we don't actually care if this
 > > support
 > > is only available to userland programs, and not to kernel-based modules.
 > >
 > > Philippe.
 > >
 > 
 > I see, well, imho its a performance issue for our concerns, we developed our
 > APIs, in general terms, based on threads dispatching instead of signal
 > delivering due to the "historic" limited bandwidth in the signal mechanisms
 > under Unix/Linux..whatever.
 > 
 > Right now, we dont have a clear idea about it..  so we move on in a first
 > approach with software re-usage issues in mind cause we have already passed
 > a validation proccess. Anyway the required modifications seems not to be too
 > hard(right now), so before deep inside we will check our application
 > prototypes following your current capabilities..
 > 
 > Best regards.

Xenomai posix skin signals cause the target thread to switch to
secondary mode, so, it may not be a good idea to use them.

-- 


					    Gilles Chanteperdrix.

