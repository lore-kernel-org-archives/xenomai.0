Message-ID: <4B97A8B9.7070702@domain.hid>
Date: Wed, 10 Mar 2010 15:12:09 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4B968538.7030204@domain.hid>
	<4B968BAC.5090205@domain.hid>		<4B977F1F.8030304@domain.hid>	<1268220794.27899.50.camel@domain.hid>
	<4B978653.9020608@domain.hid>
In-Reply-To: <4B978653.9020608@domain.hid>
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
To: Daniele Nicolodi <daniele@domain.hid>
Cc: xenomai@xenomai.org

Daniele Nicolodi wrote:
> Philippe Gerum wrote:
> 
>>> I would like to have the possibility to use (the far from perfect but
>>> working) Comedi over RTDM while Analogy is worked out. Would it be
>>> possible to recover the early work done to port Comedi over RTDM and put
>>> it to some use? Given enough informations I can try to do it myself.
>> Beats me. Why do you assume that Comedi/RTDM provides more support
>> compared to Analogy, since it is stated that Analogy started off from
>> the Comedi/RTDM code base, months ago?
> 
> Sorry for my misunderstanding. I simply thought that, since Comedi works
> with RTAI and Xenomai offers similar interfaces, a Comedi port to
> Xenomai was quite straight forward. It must not be so.
> 
>> If you do want to help, you may want investing your time in developing
>> and testing a better code base like Analogy with other people, instead
>> of re-opening a dead development effort all alone.
> 
> Unfortunately I do not have so much time to invest into this activity.
> I'll simply check if the PREEMP_RT patch gives me low enough latencies,
> otherwise I'll switch to use Comedi on top of RTAI (sadly, because I
> prefer Xenomai and its posix api).

You have read the mail, but apparently missed two points: Comedy is soon
to be no longer portable on RTAI. Out-of-tree Comedy will soon be
unmaintained, and Linux in-tree Comedy will no longer have the wrappers
which made it portable over RTAI.

So, Comedy over RTAI is a dead-end.

The second point is that Xenomai defined a skin for writing drivers:
RTDM, and Comedy obviously predates that skin, so the only acceptable
way of porting Comedy over Xenomai would be to port Comedy over RTDM,
which exactly is what Alex started, and resulted in Analogy.

So, there is no other choice than Analogy, for using Comedy over Xenomai.

-- 
					    Gilles.

