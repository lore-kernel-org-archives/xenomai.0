Message-ID: <444E8E99.2050805@domain.hid>
Date: Tue, 25 Apr 2006 23:03:21 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Profiling software
References: <hlb2i3-ur5.ln1@domain.hid>
In-Reply-To: <hlb2i3-ur5.ln1@domain.hid>
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
To: Bernhard Walle <bernhard.walle@domain.hid>
Cc: xenomai@xenomai.org

Bernhard Walle wrote:
> Hello,
> 
> is it possible to run LTTng together with Xenomai? Or is there any
> other profiling software that works with Xenomai? Thanks.
> 
> 

Xenomai supports LTT oldgen on x86 for now, over 2.6.9 IIRC, since it's 
the latest kernel LTT did support.

For performance profiling, oprofile over a Xenomai-enabled kernel works.

-- 

Philippe.

