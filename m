Message-Id: <4A2CDA69.3E52.00F8.0@domain.hid>
Date: Mon, 08 Jun 2009 09:31:13 +0200
From: "Karl Tyss" <tyss.k@domain.hid>
References: <4A28F029020000F80002DB14@domain.hid>
	<4A28FAD4020000F80002DB27@domain.hid>
	<4A28FAD7.3E52.00F8.0@domain.hid>
	<d6c8ef150906050513n444b7a9eo9bb1be1676dd8c4e@domain.hid>
In-Reply-To: <d6c8ef150906050513n444b7a9eo9bb1be1676dd8c4e@domain.hid>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Subject: Re: [Xenomai-help] IRQ-Latency when in idle State on ARM
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Bosko Radivojevic <bosko.radivojevic@domain.hid>
Cc: xenomai@xenomai.org

Hi Bosko,

'nohlt' works. The problem with disabling cache in idle mode is gone
when using 'nohlt' option.

Thanks,
Karl Tyss 
 

Mit Freundlichen Grüßen,
Karl Tyss



>>> Bosko Radivojevic <bosko.radivojevic@domain.hid> 06/05/09 2:13 PM
>>> 
Karl,

you can try to boot the kernel with 'nohlt' option.

I had a similar problem - like CPU wasn't running on the same clock
rate. My ISR had two different duration times ~500 and ~800 us, always
with the same code execution path.

The similar behavior I couldn't detect on the vanilla kernel.

Thanks to Gilles, 'nohlt' kernel option helped.

Sincerely,
Bosko



---------------------------------------------------------------------------------------
This email including its attachments is intended for the person or
entity only to which it is addressed. It may contain confidential and/or
privileged material. Any review, forwarding, dissemination, other use
of, or taking of any action in reliance upon this information by persons
or entities other than the intended recipient is prohibited.
If you received this email in error, please contact the sender and 
delete the material from any computer system. 
---------------------------------------------------------------------------------------

Eppendorf AG, Hamburg, Barkhausenweg 1, 22339 Hamburg,
Amtsgericht Hamburg HRB 76249
Vors. des Aufsichtsrats: Dipl.-Ing. Adrian Déteindre
Vorstand: Klaus Fink (Vorsitzender), Detmar Ammermann,
Dr. Heinz G. Koehn, Dr. Michael Schroeder

Eppendorf Instrumente GmbH, Hamburg, Amtsgericht Hamburg, HRB 69077
Geschäftsführer: Rainer Treptow

Eppendorf Biochip Systems GmbH, Hamburg, Amtsgericht Hamburg, HRB 96641
Geschäftsführer: Dr. Sven Buelow

Eppendorf Liquid Handling GmbH, Hamburg, Amtsgericht Hamburg, HRB 92250
Geschäftsführer: Boris von Beichmann

