Message-ID: <507E9605.5070305@siemens.com>
Date: Wed, 17 Oct 2012 13:27:01 +0200
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <507E946A.5020105@siemens.com> <507E94ED.9060401@xenomai.org>
In-Reply-To: <507E94ED.9060401@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH] can: Let Flexcan driver depend on platform
 support
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Wolfgang Grandegger <wg@denx.de>, Xenomai <xenomai@xenomai.org>

On 2012-10-17 13:22, Gilles Chanteperdrix wrote:
> On 10/17/2012 01:20 PM, Jan Kiszka wrote:
> 
>> Just like the Linux version does, let our RT Flexcan driver depend on
>> CONFIG_HAVE_CAN_FLEXCAN so that it can only be selected on platforms
>> that actually support it.
> 
> 
> Do all old kernels for CPUs which have a flexcan controller have this
> symbol defined?

That's a question for Wolfgang. We briefly discussed this yesterday, and
that dependency appeared reasonable on first glance.

The platform has to provide at least CONFIG_OF. So that could be plan B
in case HAVE_CAN_FLEXCAN is too strict.

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SDP-DE
Corporate Competence Center Embedded Linux

