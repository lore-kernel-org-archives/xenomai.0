Message-ID: <4B97AC19.9020004@domain.hid>
Date: Wed, 10 Mar 2010 15:26:33 +0100
From: Daniele Nicolodi <daniele@domain.hid>
MIME-Version: 1.0
References: <4B968538.7030204@domain.hid>
	<4B968BAC.5090205@domain.hid>		<4B977F1F.8030304@domain.hid>	<1268220794.27899.50.camel@domain.hid>
	<4B978653.9020608@domain.hid> <4B97A8B9.7070702@domain.hid>
In-Reply-To: <4B97A8B9.7070702@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] COMEDI vs Analogy
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Gilles Chanteperdrix wrote:

> You have read the mail, but apparently missed two points: Comedy is soon
> to be no longer portable on RTAI. Out-of-tree Comedy will soon be
> unmaintained, and Linux in-tree Comedy will no longer have the wrappers
> which made it portable over RTAI.
> 
> So, Comedy over RTAI is a dead-end.

I understood this. But Comedi over RTAI works today (haven't tried that
myself, but I have seen some projects using this combination). It will
not work tomorrow, but I need a solution yesterday :-)

> The second point is that Xenomai defined a skin for writing drivers:
> RTDM, and Comedy obviously predates that skin, so the only acceptable
> way of porting Comedy over Xenomai would be to port Comedy over RTDM,
> which exactly is what Alex started, and resulted in Analogy.
> 
> So, there is no other choice than Analogy, for using Comedy over Xenomai.

I understood this too. But to me it was looking like there has been a
functional Comedi port to RTDM in the past, and that Analogy is more an
effort to clean up the Comedi implementation. I misunderstood this
second part.

PS: I'm sorry if some of my email sounded a bit harsh, but I'm a little
bit frustrated by the situation. I'm new to this kind of applications,
I'm a physicist more than a programmer. Xenomai works great, Comedi has
some rough edges, but finally I made it to work as I need. It is
disappointing to find out that those two do not work together and that I
have to rethink my application.

Thanks for the clarifications. Cheers,
-- 
Daniele


