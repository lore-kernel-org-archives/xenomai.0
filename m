Message-ID: <4C2F24CF.7090309@domain.hid>
Date: Sat, 03 Jul 2010 13:53:51 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTimOQfrs56FSp2JQUWtD7wDACYRmCrX6AF-pU3RC@mail.gmail.com>
In-Reply-To: <AANLkTimOQfrs56FSp2JQUWtD7wDACYRmCrX6AF-pU3RC@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] kernel warnings and oopses calling gpiolib
 functions from xenomai kernel space
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jeremy Brown <jhbrown@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

Jeremy Brown wrote:
> Thanks in advance for any and all help!

Hi,

from your post, we can conclude that gpio_set_value is a Linux kernel
function which can yet not be used in Xenomai context (you could
probably even get more explicit messages by enabling I-pipe debugging).
I am going to try and propose a fix for this issue, will send you a
patch ASAP.

Note that the issue is more an Adeos I-pipe issue than a Xenomai issue,
so I am more interested in knowing what version of adeos than what
version of Xenomai you are using. But chances that the problem exists
with all versions anyway.

Regards.

-- 
					    Gilles.

