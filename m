Subject: Re: __ipipe_root_sync
References: <2053542.YF2tJfiQcj@omoikane>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <15e4c98a-533e-9a58-d7b7-27d9a9631af8@siemens.com>
Date: Fri, 26 Apr 2019 19:42:19 +0200
MIME-Version: 1.0
In-Reply-To: <2053542.YF2tJfiQcj@omoikane>
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
To: Steven Seeger <steven.seeger@flightsystems.net>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 26.04.19 19:07, Steven Seeger via Xenomai wrote:
> Why was __ipipe_root_sync moved out of kernel/ipipe/core.c? I see it now in
> arch/arm/kernel/ipipe.c. It is the same exact code I had in the PPC branch in
> kernel/ipipe/core.c. I can move it to the arch-specific code, but was wondering
> why.

I think you should make sync_root_irqs __ipipe_root_sync (or whatever) again. 
That is already a duplication for ARM.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

