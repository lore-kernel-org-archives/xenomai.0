From: Wolfgang Denk <wd@domain.hid>
MIME-Version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 8bit
In-reply-to: <4ACDA16B.70607@domain.hid>
References: <abbab2d60910070942l2bfbc0bboca0232fb674e1ec0@domain.hid>
	<4ACD86F4.4070407@domain.hid> <4ACD8DCC.50906@domain.hid>
	<abbab2d60910080104n67bd5ef6t9e1a85b0bbcb7ac8@domain.hid>
	<4ACDA16B.70607@domain.hid>
Date: Thu, 08 Oct 2009 15:25:01 +0200
Message-Id: <20091008132501.76A32E8B31D@gemini.denx.de>
Subject: Re: [Xenomai-help] XUM 2009 follow-up : Powerlink,
	CANopen and sockets.
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Peter Puchwein <peter.puchwein@domain.hid>
Cc: xenomai@xenomai.org

Dear Peter Puchwein,

In message <4ACDA16B.70607@domain.hid> you wrote:
> 
> So the usage of the linux-based Ethercat implementations is completely 
> free but Beckhoff want's to take care that EtherCAT products stay 

This is not correct.

OSADL had long discussions with Beckhoff about that before OSADL
buried their ready to be released EtherCAT master stack.

> compatible so they have their own license you sign if you use the 
> technology.

Right, and this additional license requirements imposed by Beckhoff
prevents the use of EtherCAT in a GPL based contaxt (like the Linux
kernel).

> With this type of license the Opensource-Community is not happy I think, 
> maybe of conflicts with the GPL.

Indeed it it is a conflict with GPL.

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@domain.hid
Single tasking: Just Say No.

