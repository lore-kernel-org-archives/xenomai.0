Message-ID: <45FEBEC5.8010608@domain.hid>
Date: Mon, 19 Mar 2007 16:48:05 +0000
From: =?UTF-8?B?U3TDqXBoYW5lIEFOQ0VMT1Q=?= <sancelot@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] RT-Socket-CAN bus error handling (was CAN errors
	and real-time behaviour (IRQ raise forever and may lock system))
References: <bc4264770703030609w188a675cj618872986ff1071c@domain.hid>	<45FD238F.2050009@domain.hid>
	<45FDA81F.2080004@domain.hid> <E1HTD6v-0004qo-QI@mailer.emlix.com>
In-Reply-To: <E1HTD6v-0004qo-QI@mailer.emlix.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Sebastian Smolorz <ssm@domain.hid>
Cc: xenomai@xenomai.org, Jan Kiszka <jan.kiszka@domain.hid>

> 
> IIRC, there is no possibility to detect a "normal" bus error (acknowledge) 
> appearing during normal operation from the one occuring when the cable is 
> plugged off. The best indication is a high number of consecutive BEIs.
> 


I do not agree :
case normal :
In normal bus error condition, if error repeats the chip will go to 
busoff state (unfortunately I don't know how to simulate this...)

case unplugged (easy to simulate):
when the cable is not plugged it will not go to busoff condition. The 
can 2.0 spec says :

Start-up / Wake-up:
If during system start-up only 1 node is online, and if this node 
transmits some message, it will
get no acknowledgement, detect an error and repeat the message. It can 
become ’error passive’
but not ’bus off’ due to this reason.

