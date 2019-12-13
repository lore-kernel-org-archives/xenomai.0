Subject: Re: Inspecting heap allocations?
References: <VI1PR05MB59171CA57D6945AB7E64112FF6550@VI1PR05MB5917.eurprd05.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <acfe093b-01e1-1dd3-6125-61f9ac18f7e5@siemens.com>
Date: Fri, 13 Dec 2019 08:41:43 +0100
MIME-Version: 1.0
In-Reply-To: <VI1PR05MB59171CA57D6945AB7E64112FF6550@VI1PR05MB5917.eurprd05.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
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
To: Lange Norbert <norbert.lange@andritz.com>, "Xenomai (xenomai@xenomai.org)" <xenomai@xenomai.org>

On 12.12.19 13:29, Lange Norbert via Xenomai wrote:
> Hello,
> 
> I have some circumstances where I run out of global heap and then simple stull like creating a mutex fails with ENOMEM.
> My suspicion is an IDDP connection between 2 processes, where 1 process might send a lot small packets before the other will pull them (I will try using a local pool).
> 
> In the future, is there a way to dump the owners of heap objects?

I was considering this recently as well when we had a xnmalloc leak in a
driver. But it was possibly via a quick hack.

In fact, I'm wondering why we are using xnmalloc so extensively. Most of
the allocations are non-rt and could perfectly use kmalloc which would
provide tooling. And would not be heap-size constrained.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

