Message-ID: <50E9951E.4030809@xenomai.org>
Date: Sun, 06 Jan 2013 16:15:42 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <50E47751.1070005@siemens.com>
	<50E59112.6080005@siemens.com>	<50E94E72.5050309@xenomai.org>
	<50E95812.8050503@web.de> <50E959EC.8030306@web.de>
	<50E98242.30104@xenomai.org> <50E98849.5050903@web.de>
	<50E9897E.2000106@xenomai.org> <50E98E62.7090907@web.de>
	<50E993B7.9070201@xenomai.org> <50E99430.5000700@web.de>
In-Reply-To: <50E99430.5000700@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH v3] nucleus: Convert intrlock to a sleeping
 Linux lock
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@web.de>
Cc: "Mauerer, Wolfgang" <wolfgang.mauerer@siemens.com>, Xenomai <xenomai@xenomai.org>

On 01/06/2013 04:11 PM, Jan Kiszka wrote:

> On 2013-01-06 16:09, Gilles Chanteperdrix wrote:
>>> If you prefer to skip the warning in ipipe, then I will send a
>>> corresponding patch. The lock conversion is still necessary for forge,
>>> though.
>>
>>
>> There are other ways around, ipipe_virtualize_irq is already a wrapper
>> used only by 2.6, so we can add some code here. So, we can only check
>> ipipe_root_p here, and disable the warning in ipipe_request_irq.
> 
> Err, we rather need unchecked __ipipe_request_irq, called by
> ipipe_request_irq after testing the context and by ipipe_virtualize_irq
> without that test.


ipipe_root_only does two tests, it tests whether the current domain is
root, and whether root is stalled. The problem, as far as I understood,
come from the second test, what I mean is that we can arrange to keep
the first test for ipipe_virtualize_irq.


-- 
                                                                Gilles.

