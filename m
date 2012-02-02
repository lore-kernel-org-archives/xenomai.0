Message-ID: <4F2ACF96.2080503@domain.hid>
Date: Thu, 02 Feb 2012 19:01:58 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <4F2AC801.3040503@domain.hid>
In-Reply-To: <4F2AC801.3040503@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai 3 documentation
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Daniele Nicolodi <daniele@domain.hid>
Cc: xenomai@xenomai.org

On 02/02/2012 06:29 PM, Daniele Nicolodi wrote:
> Hello,
>
> I'm looking with curiosity to the development of Xenomai 3 skimming
> through the GIT commits. I'm a physicist writing data acquisition code,
> looking at how experienced programmers solve problems is very
> instructional. However, I have observed that most of the code that has
> been added do not have documentation in the form of comment blocks.
>
> There is some other place where I can learn about Xenomai 3 ?

A general roadmap explaining high level issues:
http://www.xenomai.org/index.php/Xenomai:Roadmap#Toward_Xenomai_3

For the rest, the Cobalt kernel is fully documented in the sources, 
since it directly derives from v2.x's nucleus, check kernel/cobalt.

The really missing part is a documentation of the lib/copperplate API, 
providing the building blocks for the userland-based RTOS skins. That 
one is still wandering somewhere in my brain. But for sure, it will land 
in the sources at some point as well.

>
> Thank you. Cheers,


-- 
Philippe.

