Message-ID: <49E3A865.2060207@domain.hid>
Date: Mon, 13 Apr 2009 23:02:29 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <063026E85C8B4F94A0F79B8B8CC30778@domain.hid>
	<49E3A293.6030709@domain.hid>
In-Reply-To: <49E3A293.6030709@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Arm Processors
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Newburn <Mail@domain.hid>
Cc: xenomai@xenomai.org

Gilles Chanteperdrix wrote:
> Newburn wrote:
>> Hi,
>>   Is xenomai available for the Cirrus Arm EP9302 (9301) processor ?
> 
> There exist a pach, which was never completed so never included.
> Besides, the cirrus status in mainline is incertain, since people at
> cirrus have decided they would continue to maintain their own fork of
> the Linux kernel, with a supreme disdain for the Linux kernel coding
> rules. See the linux-arm-kernel mailing list for details.

There seem to be a recent interest in mainline support for cirrus
processors. Anyway, in case you wonder why we focus on mainline support
only: because maintaining support for patched kernel is a major PITA and
becomes obsolete fast. So, our current active development branch is
Linux mainline, exclusively. We make an exception for the AT91 patch,
because it is an "antichambre" of the mainline support for AT91, not a
fork, and even then, we try hard to make an adeos I-pipe patch which
applies with or without the AT91 patch.

-- 
					    Gilles.

