Message-ID: <20021105232456.62569.qmail@domain.hid>
Date: Tue, 5 Nov 2002 15:24:56 -0800 (PST)
From: Girish Wadhwani <gwadh@domain.hid>
Subject: Re: [Adeos-main] Re: RTOS over Adeos document
In-Reply-To: <3DC69037.5A9A1577@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
To: karim@domain.hid
Cc: adeos-main@gna.org

Hello Karim,

> Of course, this involves that no two instances of
> Linux share the
> same hardware. Which is just fine for what Adeos is
> supposed to
> do. If you need to share hardware devices among OS
> instances, then
> you certainly need somethine like VMWare or plex86.
> Sharing
> hardware devices isn't part of Adeos' mandate.

Wouldn't this severly limit what Adeos could be used
for?
The hardware will have to scale with the no. of OSes
in  
use. It would be too expenive to use it for
allpications like hosting, etc. The only resources
that are  shared are the cpu and memory making it not
that beneficial to be running multiple OSes.
Clustering still works though:-)

-Girish
 
> > In this case the purpose of Adeos would be to
> > multiplex access between multiple instances, which
> > would be aware of each other and avoid stepping on
> eac
> > others toes. The upside would be that you would
> have
> > significant performance advantages over the VMM
> > method.
> 
> We don't need to do this. Since any extra Linux
> doesn't even see the
> PCI hardware it isn't supposed to use, there is no
> need to make sure
> that the various Linux don't step on each other. The
> only possible
> problem is if you have a Linux making random
> physical memory accesses,
> but if that's the case then it's a bug and it has to
> be fixed.
> 
> As for how the various Linux instances are supposed
> to communicate
> with a single Adeos instance, I first thought that
> soft ints could
> be used, but these may turn out to be expensive.
> Instead, I think
> we could reserve a MB or two in physical memory
> where we would place
> the Adeos code and data. All Linux instances would
> map this instance
> into their virtual address space and call upon it as
> they would
> any other code.
> 
> > Any thoughts on this? Or am I completely off the
> mark?
> > The information I found on the Adeos papers did
> not go
> > into much detail as to how things would be
> implemented
> 
> The papers are really meant to be "food for
> thought". For sure they
> can't explain every corner case. If that were true
> then I might have
> just as well written the thing to start with ;)
> 
> Karim
> 
> ===================================================
>                  Karim Yaghmour
>                karim@domain.hid
>       Embedded and Real-Time Linux Expert
> ===================================================
> 
> 
> _______________________________________________
> Adeos-main mailing list
> Adeos-main@domain.hid
> http://mail.nongnu.org/mailman/listinfo/adeos-main


__________________________________________________
Do you Yahoo!?
New DSL Internet Access from SBC & Yahoo!
http://sbc.yahoo.com


