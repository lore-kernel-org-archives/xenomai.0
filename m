Message-ID: <3DC85A8A.CE119F27@domain.hid>
Date: Tue, 05 Nov 2002 18:55:54 -0500
From: Karim Yaghmour <karim@domain.hid>
Reply-To: karim@domain.hid
MIME-Version: 1.0
Subject: Re: [Adeos-main] Re: RTOS over Adeos document
References: <20021105232456.62569.qmail@domain.hid>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: adeos-main-admin@domain.hid
Errors-To: adeos-main-admin@domain.hid
List-Help: <mailto:adeos-main-request@domain.hid>
List-Post: <mailto:adeos-main@gna.org>
List-Subscribe: <http://mail.nongnu.org/mailman/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Id: <adeos-main.nongnu.org>
List-Unsubscribe: <http://mail.nongnu.org/mailman/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: <http://mail.nongnu.org/pipermail/adeos-main/>
To: Girish Wadhwani <gwadh@domain.hid>
Cc: adeos-main@gna.org

Girish Wadhwani wrote:
> Wouldn't this severly limit what Adeos could be used
> for?
> The hardware will have to scale with the no. of OSes
> in
> use. It would be too expenive to use it for
> allpications like hosting, etc.

If you need to share a machine for hosting, then your best bet is
to use Jacques Gelinas' virtual servers:
http://www.solucorp.qc.ca/miscprj/s_context.hc

This is actually already used by a few hosting companies and it
is much better adapted to this job than anything Adeos can do.

> The only resources
> that are  shared are the cpu and memory making it not
> that beneficial to be running multiple OSes.

I, for one, really like to idea of having 2 completely separate
OSes each running with their separate hardware linked using a
RAM-based virtual Ethernet. I don't like the idea of having to
make special modifications to block device drivers and I don't
like the idea of having layers of block requests (a-la VMWare).
This doesn't mean other folks can't find those things of some use.
But from my perspective, nanokernels are better off really being
"nano" ...

Karim

===================================================
                 Karim Yaghmour
               karim@domain.hid
      Embedded and Real-Time Linux Expert
===================================================


