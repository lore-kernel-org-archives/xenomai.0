Subject: Re: Kconfig errors in stable branch
References: <CALLqZ8Rxxass-jFgRSPm4NoGNs4MBw3M8bezJvFJNkbTR68eiQ@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <924f63e1-fd41-2ca1-8a23-4208c547b904@siemens.com>
Date: Tue, 28 Jan 2020 10:17:33 +0100
MIME-Version: 1.0
In-Reply-To: <CALLqZ8Rxxass-jFgRSPm4NoGNs4MBw3M8bezJvFJNkbTR68eiQ@mail.gmail.com>
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
To: Greg Gallagher <greg@embeddedgreg.com>, "Xenomai@xenomai.org" <xenomai@xenomai.org>

On 25.01.20 03:34, Greg Gallagher via Xenomai wrote:
> Hi,
> Is the stable branch of Xenomai meant to run over the 4.19 kernels? I
> found the following error when you do so:
>                     init/Kconfig:2056: can't open file
> "arch/$SRCARCH/xenomai/Kconfig"
> Looks like we are missing these two commits from the stable branch:
> https://gitlab.denx.de/Xenomai/xenomai/commit/c9810f0a7a1ae5e83f69e4224b69811f1f21f1cc
> https://gitlab.denx.de/Xenomai/xenomai/commit/60aa08c98a2602919d89d28b5641965c092dccf0
> 
> This may not be an issue but I thought I would bring it up just in case.
> 

Stable only supports up to 4.14. You want 3.1(-rc).

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

