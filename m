Message-ID: <4F2C54E4.1090204@domain.hid>
Date: Fri, 03 Feb 2012 22:43:00 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Arm922T -  Micrel KSZ8695P
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Glen Wernersbach <glen@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>, rtai@domain.hid

On 02/03/2012 09:19 PM, Glen Wernersbach wrote:
> Hi All,
> 
> Just wondering if anyone has ever successfully use RTAI on a Arm922T type
> chip?
> 
> Or have an idea on how hard to port.

Well, the xenomai mailing list is not the best place to ask for an RTAI
port. However, we can answer the question for a xenomai port.

First, the arm core is irrelevant, what matters is what SOC exactly you
want to port to (that is because except starting with cortex a9, the arm
core does not contain a hardware timer, the timer is specific to the
SOC). Second, the port involved is more a port of adeos than a port of
xenomai, there is nothing SOC specific in xenomai. The adeos patch for
ARM already supports several SOC families, so we have some experience
doing this, it usually takes a few days to port adeos to a new ARM SOC.
If you are ready to do it yourself, we even propose an howto:

http://www.xenomai.org/index.php/I-pipe:ArmPorting

but it is starting to be seriously outdated, so, you probably have
better chances looking at how it is done for supported SOCs in an
existing patch. adeos patches for arm are available here:

http://download.gna.org/adeos/patches/v2.6/arm/
or here
http://download.gna.org/adeos/patches/v3.x/arm/

The list of SOCs currently supported:
http://www.xenomai.org/index.php/Embedded_Device_Support#ARM

-- 
                                                                Gilles.

