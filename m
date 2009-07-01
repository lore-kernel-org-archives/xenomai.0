From: Sebastian Smolorz <smolorz@domain.hid>
Date: Wed, 1 Jul 2009 12:53:17 +0200
References: <5D63919D95F87E4D9D34FF7748CE2C2A01AB8BD8@domain.hid>
In-Reply-To: <5D63919D95F87E4D9D34FF7748CE2C2A01AB8BD8@domain.hid>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200907011253.17443.smolorz@domain.hid>
Subject: Re: [Xenomai-help] Question about Interrupts
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: roderik.wildenburg@domain.hid
Cc: xenomai@xenomai.org

roderik.wildenburg@domain.hid wrote:
> Dear Gurus,
>
> I have a question of understanding regarding the priority of a interrupt
> service routine which is assigned to the linux domain and the priority
> of a Xenomai task. Which one is executed first the Linux ISR or the
> Xenomai task ?
> Background of my question is, that it seems (this is just a assumption
> !) that a Linux ISR (e.g. for serial interrupt) is delayed when the
> system is under heavy realtime load. Is this possible ?

This is the essential core of the whole I-pipe/Xenomai construct. Real-time 
tasks are executed before the Linux root domain and this includes Linux ISR 
routines, too.

-- 
Sebastian


