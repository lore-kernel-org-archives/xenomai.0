Subject: Re: Xenomai arm64 plans?
References: <fb2b5a6b-007e-9f2c-bcac-8df84fbaac84@theobroma-systems.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <96f3c66c-816c-b2d8-071e-198488ad05be@siemens.com>
Date: Fri, 2 Nov 2018 17:25:55 +0100
MIME-Version: 1.0
In-Reply-To: <fb2b5a6b-007e-9f2c-bcac-8df84fbaac84@theobroma-systems.com>
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
To: =?UTF-8?Q?Christoph_M=c3=bcllner?= <christoph.muellner@theobroma-systems.com>
Cc: xenomai@xenomai.org

On 02.11.18 17:19, Christoph Müllner wrote:
> Hi Jan,
> 
> I was wondering if there are any plans for a Xenomai release,
> which includes arm64.

Yes, there are. The exact timeline is not settled yet, but somewhere within the 
next month, I would say.

> 
> I'm familiar with the next branch, but I'd love to work with
> code from a branch, which is not subject to force-pushing.

Actually there was a change: next is still potentially rebasing as I'm 
integrating over it and may - when things go wrong - pull back or reorder in 
that queue. But master is back, and that is forward-only. It's not comparable to 
a release but it could help to bridge the time to v3.1.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

