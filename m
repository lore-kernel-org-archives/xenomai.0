From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <AANLkTinjobDAuybm7LnJTEijjY4CSTArH8TOzFpNzQcp@domain.hid>
References: <AANLkTinjobDAuybm7LnJTEijjY4CSTArH8TOzFpNzQcp@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 25 May 2010 19:00:06 +0200
Message-ID: <1274806806.2444.151.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] RT-Socket-CAN: Problem installing PMC-CAN266
 interface card
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Nape Ibrahim Lentsoane <nape.lentsoane@domain.hid>
Cc: xenomai@xenomai.org

On Tue, 2010-05-25 at 14:05 +0200, Nape Ibrahim Lentsoane wrote:
> Hi,
> 
> We have recently bought a PMC-CAN/266 from ESD and we  are currently
> experiencing some problems with it when intalling it on a Linux Ubuntu
> machine with Xenomai installed. When we plug the board into the PC
> it[PC] does not want to boot successfully, it hangs and gives error
> messages after an attempt at "Loading Module Drivers...". Just
> wondering should I install the driver that came with the card first
> and then install the hardware after?
> 
> For info: when I power up the PC without the PMC card it boots normal
> with no errors.

You may want to try reverting this patch if present in your code base:

http://git.denx.de/?p=ipipe-2.6.git;a=commit;h=ae1b39a521d535d6dbd61046666348c106d45f5e

> 
> What could I be doing wrong here? please help.
> 
> Regards,
> Nape
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help


-- 
Philippe.



