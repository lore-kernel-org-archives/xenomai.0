Message-ID: <512BC4E2.4020605@control.lth.se>
Date: Mon, 25 Feb 2013 21:09:06 +0100
From: Anders Blomdell <anders.blomdell@control.lth.se>
MIME-Version: 1.0
References: <511CD2FB.7010502@gmail.com> <511DDBD5.4060505@web.de>
	<51236088.1030402@gmail.com> <51236A75.5090400@siemens.com>
	<5123C910.7090107@siemens.com> <5123DDBE.8060105@web.de>
	<512778A0.6090300@gmail.com> <51277B66.60505@siemens.com>
	<512B9A86.4060900@siemens.com> <512BB672.7080900@control.lth.se>
	<512BB714.6080707@siemens.com>
In-Reply-To: <512BB714.6080707@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] (Boot)-problems with (current) ipipe patch on AMD FX
 61000 - 2.6.38.8 & 3.5.7
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Manuel Huber <manuel.h87@gmail.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 2013-02-25 20:10, Jan Kiszka wrote:
> On 2013-02-25 20:07, Anders Blomdell wrote:
>> On 2013-02-25 18:08, Jan Kiszka wrote:
>>> As 3.5 is dead, this fix will never make it there unless we back-port.
>>> While I'm doing this, could you try if
>>>
>>>       git://git.xenomai.org/ipipe-jki.git for-upstream/master
>> I'm probably more stupid than normal (i.e I can't find any ipipe for
>> x86_64):
>>
>> # git clone git://git.xenomai.org/ipipe-jki.git for-upstream/master
>
> git clone git://git.xenomai.org/ipipe-jki.git
> git checkout -b for-upstream/master origin/for-upstream/master
OK, thanks. Do I need to setup xenomai in order to gain any useful 
information, or is:

CONFIG_IPIPE=y
CONFIG_IPIPE_LEGACY=y
CONFIG_IPIPE_CORE=y
CONFIG_IPIPE_CORE_APIREV=2
CONFIG_IPIPE_TARGET_APIREV=1
CONFIG_IPIPE_HAVE_HOSTRT=y
CONFIG_IPIPE_DELAYED_ATOMICSW=y
# CONFIG_IPIPE_DEBUG is not set

sufficient?

Regards

Anders

-- 
Anders Blomdell                  Email: anders.blomdell@control.lth.se
Department of Automatic Control
Lund University                  Phone:    +46 46 222 4625
P.O. Box 118                     Fax:      +46 46 138118
SE-221 00 Lund, Sweden


