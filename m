Message-ID: <454EF06A.8070207@domain.hid>
Date: Mon, 06 Nov 2006 09:20:58 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Virtual CAN driver and RT Socket CAN
References: <54b161f50611060005w3f65a255qa98da9259cecee0b@domain.hid>
In-Reply-To: <54b161f50611060005w3f65a255qa98da9259cecee0b@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Frits de Klark <mailing.xenomai@domain.hid>
Cc: xenomai@xenomai.org

Frits de Klark wrote:
> Hello everyone,
> 
> I'm not sure this is the right place to ask about it, but is the virtual 
> CAN driver mentioned in [1] of any use if I want to develop an 
> application using RT Socket CAN? If so, how do I set it up (just patch 
> the xenomai-root I guess) and how do I use it?

The virtual CAN driver is already integrated in recent versions of 
Xenomai 2.3-devel, e.g. 2.3-rc1. Just install Xenomai as usual and 
enable RT-Socket-CAN and the driver virtual CAN driver in the kernel 
configuration.

Wolfgang.

