References: <62dc8113710f4b23a7b90c9d6cae68a2@stpinfexc2vp.corporate.storopack.net>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <ea41b9c0-9fed-d4db-d017-7f962c721db9@siemens.com>
Date: Fri, 26 Jan 2018 10:41:40 +0100
MIME-Version: 1.0
In-Reply-To: <62dc8113710f4b23a7b90c9d6cae68a2@stpinfexc2vp.corporate.storopack.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [RFC] dropping ppc64 support
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Wadepohl, Wolfram" <wolfram.wadepohl@storopack.com>, Philippe Gerum <rpm@xenomai.org>, "xenomai@xenomai.org" <xenomai@xenomai.org>
Cc: Jailhouse <jailhouse-dev@googlegroups.com>

On 2018-01-26 07:38, Wadepohl, Wolfram wrote:
> Hi all,
> 
> dropping the ppc64 support are bad news for me.
> 
> Watchting the xenomai project for several years, I'm now in the situation for the need of a stable hard rt solution in combination with gnu/linux for a project.
> So xenomai is no longer on the list, due to the missing future support for ppc64.

We are happy to support anyone who is willing to take over the
maintenance. Maybe there are more parties interested so that efforts can
be shared.

> 
> Any suggestions which way to go? The PREMEPT_RT  is definitly no way to go.
> My last idea is to go for Jailhouse with GNU/Linux and RTEMS.

We do not yet have ported Jailhouse to any Power variant, and I'm still
unsure if that is going to happen due to the uncertain future of that
architecture, but also because it is a bit different compared to ARM and
x86. On the other hand, I recently heard about a safety-certified
Power64 CPU which could increase the interest again - provided the
certification material covers the virtualization extensions as well.

However, the same applies to that OSS project: contributions welcome,
and you will receive support in return.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

