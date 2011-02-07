MIME-Version: 1.0
Date: Mon, 7 Feb 2011 18:35:31 +0100
Message-ID: <AANLkTinvryUHtzDWQa9j=Z83jNe1FbJtRYaqMHNORfvp@domain.hid>
From: Henri Roosen <henriroosen@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Xenomai-help] Exception handlers in primary domain / user-space
	signals
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

We are using signal handlers for catching exceptions which our
application is allowed to make and which we know how to handle.

The current Xenomai implementation is to switch to the secondary
domain and call the handlers from there.
Unfortunately this takes too much time for our application and we
would like to handle the exception without the switch to the secondary
domain, in primary domain.

Can anyone give some advice how to implement that?
Will "user-space signals" which was planned for Xenomai 2.6 fulfill this need?
Is there already code available for user-space signals?

Thanks,
Henri.

Xenomai: 2.5.5.2
Linux-kernel: 2.6.32.15
Platform: x86

