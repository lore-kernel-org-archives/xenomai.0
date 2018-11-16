Subject: Re: Xenomai 3.0.6 - libgnat problem
References: <2e3cb0dd41b04de1a4916c990befb543@ocnapvsw3301.ocr.priv>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <fd6fb58f-b934-cddf-8282-6dab373555c7@siemens.com>
Date: Fri, 16 Nov 2018 07:36:20 +0100
MIME-Version: 1.0
In-Reply-To: <2e3cb0dd41b04de1a4916c990befb543@ocnapvsw3301.ocr.priv>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Fazio Maurizio <maurizio.fazio@leonardocompany.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 08.11.18 12:08, Fazio Maurizio via Xenomai wrote:
> Hello,
> i'm trying to integrate some software written in ADA language.  I compiled it using gnatmake and i created an archive using ar. The archive is linked in my xenomai application.
> 
> Is there some problems in using the libgnat with xenomai?
> After a while the system goes in kernel panic...

I've never used gnat before, not to speak of the combination with Xenomai. But 
even if combining it with Xenomai userland may not work, that should not crash 
the kernel.

Could you specify in more details what you did, what setup you used and which 
crash you got?

Thanks,
Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

