Message-ID: <4052104E.8020308@domain.hid>
Date: Fri, 12 Mar 2004 11:32:30 -0800
From: Paolo Mantegazza <mantegazza@domain.hid>
MIME-Version: 1.0
Subject: Re: [Adeos-main] 260 uSec latency and no idea why
References: <200403120744.i2C7iI725496@domain.hid>
In-Reply-To: <200403120744.i2C7iI725496@domain.hid>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: adeos-main-admin@domain.hid
Errors-To: adeos-main-admin@domain.hid
List-Help: <mailto:adeos-main-request@domain.hid>
List-Post: <mailto:adeos-main@gna.org>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: <https://mail.gna.org/public/adeos-main/>
To: Der Herr Hofrat <der.herr@domain.hid>
Cc: Dirk Roloff <roloff@domain.hid>, adeos-main@gna.org

Der Herr Hofrat wrote:

> 
> It is a software layer - no hardware prhibiting this - so if
> you have a X-server doing cli/sti in the driver or a binary driver that
> does somthing like that - they adeos can't stop it.
> 

This is true also. But it is really annoying to verify it. In suspicion 
of such an event I tried to disassamble a few drivers and then look for 
cli/sti. It turned out there were in asm but then they where not there 
in . In fact it was the disassambler that misunderstood FA/FB in 
disassembling a switch table. Then I concluded that it is not a simple 
matter of objdumping and seeing so gave up.

A further example: I've a nice new ATHLON machine that in alpha mode 
shows very low latencies under high Linux load, but as I'm in X they 
skyrockets to msecs, and that happens with both RTAI on ADEOS and on its 
old legacy RTHAL.

Yours is the first case I step on such a problem with Celerons.

Paolo.


