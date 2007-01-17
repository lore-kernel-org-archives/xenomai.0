Message-ID: <45ADEDDC.5060407@domain.hid>
Date: Wed, 17 Jan 2007 10:35:24 +0100
From: Theo Veenker <Theo.Veenker@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] irq conflict
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hi all,

I need to run xenomai on a HP Compaq nc6320. I use kernel 2.6.17.14
and xenomai 2.2.5. The non-realtime kernel runs fine on this laptop,
but the xenomai pactched kernel gives several of these messages:

   IRQ routing conflict for xxxx.xx.xx.x, have irq 11, want irq 10

And some things (e.g. mouse, network) then don't work, not properly
anyway. The same kernel runs fine however on other systems.

Any clue what I can do about it?

Anyone running xenomai on a recent Compaq laptop?

Regards,

Theo





