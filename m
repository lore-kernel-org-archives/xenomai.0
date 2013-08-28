Message-ID: <521DDA0C.9040204@siemens.com>
Date: Wed, 28 Aug 2013 13:07:56 +0200
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <521DD3DD.6010300@siemens.com> <521DD7D9.6040108@siemens.com>
	<521DD92F.7010509@xenomai.org>
In-Reply-To: <521DD92F.7010509@xenomai.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] IPIPE_KEVT_SETAFFINITY
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

On 2013-08-28 13:04, Philippe Gerum wrote:
> On 08/28/2013 12:58 PM, Jan Kiszka wrote:
>> On 2013-08-28 12:41, Jan Kiszka wrote:
>>> Hi Philippe,
>>>
>>> please push to ipipe.git what introduces IPIPE_KEVT_SETAFFINITY. I'm
>>> riding on the tip of all trees and cannot build forge anymore.
>>
>> Ah, oversaw it. It's in stable ipipe-3.8 only. Will pick it up for my
>> master queue.
>>
>>> Or does
>>> this event rather require some feature detection in forge?
>>
>> I suppose the policy for forge is still to require latest, full-featured
>> I-pipe patches, right?
>>
> 
> Yes, so that we start playing with wrappers as late as possible, at
> least not before the first official release is out.

But wrappers for older kernel version (3.x) are fine? Asking as I will
introduce one for the procfs stuff of 3.10. See [1].

Jan

[1]
http://git.xenomai.org/?p=xenomai-jki.git;a=commitdiff;h=e94d8b0b53b7309d640a97309f65056accbb2ec7

-- 
Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux

