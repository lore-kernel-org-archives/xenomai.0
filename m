Message-ID: <4D5039AD.2070205@domain.hid>
Date: Mon, 07 Feb 2011 19:27:57 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTinvryUHtzDWQa9j=Z83jNe1FbJtRYaqMHNORfvp@domain.hid>
In-Reply-To: <AANLkTinvryUHtzDWQa9j=Z83jNe1FbJtRYaqMHNORfvp@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Exception handlers in primary domain /
 user-space signals
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Henri Roosen <henriroosen@domain.hid>
Cc: xenomai@xenomai.org

Henri Roosen wrote:
> We are using signal handlers for catching exceptions which our
> application is allowed to make and which we know how to handle.
> 
> The current Xenomai implementation is to switch to the secondary
> domain and call the handlers from there.
> Unfortunately this takes too much time for our application and we
> would like to handle the exception without the switch to the secondary
> domain, in primary domain.
> 
> Can anyone give some advice how to implement that?
> Will "user-space signals" which was planned for Xenomai 2.6 fulfill this need?
> Is there already code available for user-space signals?

In the 2.5 series, we added some code to support signals. The signals
are multiplexed per-skin in kernel-space, and demultiplexed in
user-space, upon exit of system calls. We implemented a unit test of
this functionality with the "sigtest" skin and user-space test, but they
only work upon return from system calls.

Then we added support for the "mayday" page, which made us realize, that
maybe implementing signals handling at any time, not only when returning
from system calls, was possible. But then came the realization that in
order to implement that, we would have to fiddle with the FPU, which is
an area where we have a certain tradition for not getting the things
right at the first attempt. So, we kind of stopped here.

So, if you want some ad-hoc signals upon return from system call, the
task is pretty easy. If you want the full posix signals interface, then
things are going to be a bit harder.

-- 
                                                                Gilles.

