Message-ID: <3D35BD91.264AEE03@domain.hid>
Date: Wed, 17 Jul 2002 14:55:13 -0400
From: Karim Yaghmour <karim@domain.hid>
Reply-To: karim@domain.hid
MIME-Version: 1.0
Subject: Re: [Adeos-main] RT nanokernel working with ADEOS
References: <1026904679.653.3.camel@domain.hid>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: adeos-main-admin@domain.hid
Errors-To: adeos-main-admin@domain.hid
List-Help: <mailto:adeos-main-request@domain.hid>
List-Post: <mailto:adeos-main@gna.org>
List-Subscribe: <http://mail.freesoftware.fsf.org/mailman/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Id: <adeos-main.mail.freesoftware.fsf.org>
List-Unsubscribe: <http://mail.freesoftware.fsf.org/mailman/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: <http://mail.freesoftware.fsf.org/pipermail/adeos-main/>
To: Jerome Poichet <jerome.poichet@domain.hid>
Cc: adeos-main@gna.org

Jerome Poichet wrote:
> We managed to get a proprietary (sorry nobody's perfect) RT nanokernel
> working with ADEOS. Thus we have two different OSes working at the same
> time on the same computer thanks to ADEOS.

This is great news. This is further proof of the viability of the idea.

I had started looking into getting RTEMS to run on Adeos, but I ran out
of time. Whoever actually knows RTEMS' internals well enough should
actually be able to do such a port relatively easily. I've looked at
porting uCos too, but the licensing of the OS requires that you purchase
a copy of the book to get the sources. An RTEMS port is likely to be
more useful to the masses since it's licensed under the GPL. There's
also eCos, but its license isn't approved by the Open Source Initiative.
Though, it would be a great way for RedHat to revive its dying OS.

> Now we're working on ways to communicate between the two.

Have a look at some of the papers we used to create Adeos. Many of the
mechanisms required to have 2 OSes communicate with each other on
top of a nanokernel are fairly well documented.

Cheers,

Karim

===================================================
                 Karim Yaghmour
               karim@domain.hid
      Embedded and Real-Time Linux Expert
===================================================

