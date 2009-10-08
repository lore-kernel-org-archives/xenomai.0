Message-ID: <4ACDA16B.70607@domain.hid>
Date: Thu, 08 Oct 2009 10:23:07 +0200
From: Peter Puchwein <peter.puchwein@domain.hid>
MIME-Version: 1.0
References: <abbab2d60910070942l2bfbc0bboca0232fb674e1ec0@domain.hid>	
	<4ACD86F4.4070407@domain.hid> <4ACD8DCC.50906@domain.hid>
	<abbab2d60910080104n67bd5ef6t9e1a85b0bbcb7ac8@domain.hid>
In-Reply-To: <abbab2d60910080104n67bd5ef6t9e1a85b0bbcb7ac8@domain.hid>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: Re: [Xenomai-help] XUM 2009 follow-up : Powerlink,
	CANopen and 	sockets.
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Edouard TISSERANT <edouard.tisserant@domain.hid>
Cc: xenomai@xenomai.org

Edouard TISSERANT wrote:
> Hello.
> 
> I agree, it is a shame for those patent holder to behave that way.
> Sure they don't even understand the way they are killing their own
> future business. Even more incredible is the weakness of the invention
> claimed by those patents.
> 
> I also admit that Powerlink is far from being the smartest and more
> efficient real time Ethernet implementation, but it have the advantage
> to only require standard Ethernet controllers for both Masters and
> Slaves.
> 
> Please, now, let's keep those problems out of that discussion, and
> focus on the only Ethernet based fieldbus we can implement freely
> without taking risk to be censored.
> 


I've talked with Beckhoff about these issues.

I think the problem is, to have a fieldbus-technology, that always stays 
compatible. If you don't have this instance we could get a technology 
with maybe non compatible components.
So it's very hard to get the right way here.
So the usage of the linux-based Ethercat implementations is completely 
free but Beckhoff want's to take care that EtherCAT products stay 
compatible so they have their own license you sign if you use the 
technology.
With this type of license the Opensource-Community is not happy I think, 
maybe of conflicts with the GPL.

So maybe they find a solution for this situation in the future.

Peter






