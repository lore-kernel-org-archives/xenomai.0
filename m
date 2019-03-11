Subject: Re: Question about real-time networking
References: <5c85fb333fe3_@_imoxion.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <bf1566f3-8dc2-9cf5-751f-ce5e9c7ba3c3@siemens.com>
Date: Mon, 11 Mar 2019 20:42:36 +0100
MIME-Version: 1.0
In-Reply-To: <5c85fb333fe3_@_imoxion.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?B?6rmA67OR7KeE?= <geniuskpj@kaist.ac.kr>, xenomai@xenomai.org

On 11.03.19 06:59, 김병진 wrote:
>  >On 08.03.19 10:05, 김병진 via Xenomai wrote:
> 
>  >> Hello<br>I wanna use tcp or udp for real-time network.<br>i found an example from /home/kraptor/xenomai-v3.0.8/demo/posix/cobalt/eth_p_all<br>But it seems like not using rtnet.<br>https://gitlab.denx.de/Xenomai/xenomai/wikis/RTnet<br>Wiki says that i need to install Rtnet separately.<br>Is it right? I am trying to build rtnet tcp example without install.<br>Cause all function I need is in /xenomai/kernel/drivers/net/stack/<br>But what should I include or link?(cflags or ldflags)<br><br>Is there anyone who can help me?<br><br>Thank you.
> 
>  >Something is mangling your emails...
> 
> Sorry for messy html. I think My mail editor has a problem:(
> 
>  >RTnet is part of Xenomai, no need for a separate installation anymore. Where exactly is our wiki suggesting something different?
> 
> Several paths in 'Rtnet programming' are based on installing Rtnet.
> 
> https://gitlab.denx.de/Xenomai/xenomai/wikis/RTnet
> 
> "The second folder of interest is the folder where RTnet was installed into. The default location for this would be /usr/local/rtnet."
> 
> https://gitlab.denx.de/Xenomai/xenomai/wikis/RTnet_Setup
> 
> "Change to directory /usr/local/rtnet/sbin"

Well, that is talking about installing it from the Xenomai sources onto the 
target. That still applies.

> 
>  >For rttcp, you need to use the development branch (master).
> 
> So if i use master branch xenomai, can i add tcp in "RT_PROTOCOLS" from 'rtnet.conf'?
> 
> I can't add tcp flags on 3.0.8 branch because there is no tcp/rtnet option in kernel config.
> 

As I said: use git, master branch.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

