From: Sebastian Smolorz <smolorz@domain.hid>
Date: Wed, 10 Nov 2010 13:43:18 +0100
References: <169292FFF5F27141906C787A21B56C402E4320953C@RD01.rd.local>
In-Reply-To: <169292FFF5F27141906C787A21B56C402E4320953C@RD01.rd.local>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201011101343.19148.smolorz@domain.hid>
Subject: Re: [Xenomai-help] Socket can devices?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Anders Bach Madsen <abm@domain.hid>
Cc: xenomai@xenomai.org

Anders Bach Madsen wrote:
> We have installed a Xenomai system on a Atom based computer, which runs
> fine. We have connected a CAN card, which should be supported by the
> RT-Socket-CAN drivers in Xenomai. The card is also identified during
> boot and the proper kernel modules are loaded. We are however unable to
> create device nodes for this card, as we cannot find it in the list of
> devices!
> 
> Any suggestions on how to create the device files /dev/rtcan0 and
> /dev/rtcan1 ?

There are no device nodes for RT-Socket-CAN devices. You are supposed to use 
the RTDM socket API. See the Xenomai examples and utils for usage examples:

http://www.rts.uni-hannover.de/xenomai/lxr/source/src/utils/can/rtcansend.c

-- 
Sebastian

