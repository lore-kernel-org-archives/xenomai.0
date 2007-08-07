Message-ID: <46B88566.5090106@domain.hid>
Date: Tue, 07 Aug 2007 16:44:54 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <op.twotezngt06gyn@domain.hid>
In-Reply-To: <op.twotezngt06gyn@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Serial realtime communikation with an PPC and PSC
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Axel Beierlein <belatronix@domain.hid>
Cc: "Xenomai-help@domain.hid" <Xenomai-help@domain.hid>

Axel Beierlein wrote:
> Hello,
> 
> has anybody any experiences about realtime kommunikation with the  
> programmable serial controller(PSC) on an PPC 5200 chip?
> I have the apprehension that i have to spend much time in porting the  
> psc.c Driver to an RTDM one, cause i need deterministic communication over  
> an uart device.
> And writing device driver is an red rag for me.

Yes, the Linux PSC driver needs to be ported to RTDM-RTserial.

Wolfgang,


