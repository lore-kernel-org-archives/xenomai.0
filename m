Message-ID: <460BEE9D.8060400@domain.hid>
Date: Thu, 29 Mar 2007 18:51:41 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
From: Roland Tollenaar <rwatollenaar@domain.hid>
Subject: [Xenomai-help] OT but advice required if possible. CAN related
Reply-To: rolandtollenaar@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Xenomai-help@domain.hid

Hi,

This is slightly off topic but the only relevant place to post this 
question.

I have attached remote IO to my peak CAN adaptor (make WAGO) in the 
assumption that I will be able to control DI,DO and AO at a speed 
limited mainly by the bus speed. It appears that this kind of CAN 
hardware is very slow (5ms fastest update interval as opposed to the 1ms 
I require).

The bus is cetainly not the limitation as I have sensors operating on 
the same bus at 0.5ms interval with no problem.

WAGO concedes that their hardware cannot do any better than 5ms so I 
have a problem. Does anyone know of remote IO that is fast enough for 
1ms control intervals?

AFAIK Beckhoff has the same shortcoming.

Advice on this would be much appreciated.


Kind regards,

Roland Tollenaar.

