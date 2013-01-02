Message-ID: <50E46C37.9090408@siemens.com>
Date: Wed, 02 Jan 2013 18:19:51 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <3a62cd359d1baaa923985e5438f7b75a.squirrel@www.nta-inc.net>
	<50E2C4C6.60306@xenomai.org> <50E461E2.10502@nta-inc.net>
In-Reply-To: <50E461E2.10502@nta-inc.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] RTDM serial issue
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jeff Webb <jeff.webb@nta-inc.net>
Cc: xenomai@xenomai.org

On 2013-01-02 17:35, Jeff Webb wrote:
> On 01/01/2013 05:13 AM, Gilles Chanteperdrix wrote:
>> On 01/01/2013 05:09 AM, jeff.webb@nta-inc.net wrote:
>>
>>> When I try to open an RTDM serial device under Xenomai-2.6.2/Linux 3.4.6
>>> (Ubuntu 12.04), the call appears to succeed, but I get the following
>>> output in /var/log/kern.log:
>>>
>>> [...]
>>>
>>
>> This is a known issue, for a proposed fix, see:
>> http://www.xenomai.org/pipermail/xenomai/2012-October/026566.html
>>
>> Whether we are merging this patch is still not sure.
> 
> Are there performance issues if the patch is not applied, or does the
> patch essentially just remove the worrisome log messages?  From the
> commit message, it sounds like the latter.

There are no performance issues with that patch, but it turned out to be
incomplete, causing different errors when dumping /proc/xenomai/stat.
I'm working on an update.

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SDP-DE
Corporate Competence Center Embedded Linux

