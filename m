From: Wolfgang Denk <wd@domain.hid>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 8bit
In-reply-to: <4A67F5D2.4090708@domain.hid>
References: <4A67F5D2.4090708@domain.hid>
Date: Thu, 23 Jul 2009 10:52:03 +0200
Message-Id: <20090723085203.2782B832E416@domain.hid>
Subject: Re: [Xenomai-help] Advice for a newbie on Xenomai & USB
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: David <correupeldavid@domain.hid>
Cc: xenomai@xenomai.org

Dear David,

In message <4A67F5D2.4090708@domain.hid> you wrote:
>
> As you already know my specifications, do you think the computing system
> is suited for the needs? As the computer does not have embedded USART
> modules, I rely on USB to TTL USART converters (ttyUSBx). Are there any
> suitable drivers for Xenomai? USB4RT? With interruptions and
> configuration for SSP?

Could you use a PCI or PCIe card with standard 16550 UARTs instead?

I recommend to get USB out of the link here.


Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@domain.hid
You cannot propel yourself forward by patting yourself on the back.

