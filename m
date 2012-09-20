Message-ID: <505AFD85.5090500@siemens.com>
Date: Thu, 20 Sep 2012 13:27:01 +0200
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <505AF205.6010206@siemens.com> <505AF49D.6020905@xenomai.org>
	<505AF641.6030604@siemens.com> <505AF687.9010002@siemens.com>
	<505AFACC.1050802@siemens.com>
In-Reply-To: <505AFACC.1050802@siemens.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH] Revert "ipipe: ipipe_request_irq(),
 ipipe_free_irq() are root-only services"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: "Mauerer, Wolfgang" <wolfgang.mauerer@siemens.com>, Xenomai <xenomai@xenomai.org>

On 2012-09-20 13:15, Jan Kiszka wrote:
>> Sorry, three bugs:
>>  - in the RTDM spec as it always allowed rtdm_irq_request over RT task
>>    contexts
> 
> Changing the spec and adding a runtime check will likely be no issue. No
> sane driver should have made use of that option. I will file a patch.

Naturally, this also affects rtdm_irq_enable/disable, and some use cases
I'm aware off will bail out when we add assertions for non-RT context.

I would prefer to address it more selectively, allowing all those
services for IRQ types that support it (i.e. that can be atomically
enabled/disabled), keeping the freedom to reject or otherwise fail for
types that are in conflict.

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SDP-DE
Corporate Competence Center Embedded Linux

