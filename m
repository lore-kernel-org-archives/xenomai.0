Message-ID: <517684C3.2090607@siemens.com>
Date: Tue, 23 Apr 2013 14:55:31 +0200
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <201304191346.38739.leo@alaxarxa.net>
	<517195B6.8020209@xenomai.org>
	<12ABCC03-FADF-4C5A-9CAE-CD9E5CA63A19@mah.priv.at>
	<51724F82.2000809@web.de> <5172B0E5.7090806@xenomai.org>
	<5172B1B5.10804@web.de> <5172B28C.6070503@xenomai.org>
	<5172B3CD.20007@web.de> <5172B4AA.1060704@xenomai.org>
	<5174E2A0.1040906@siemens.com> <51752114.7040903@xenomai.org>
	<51753E59.4090609@siemens.com> <51758816.4050100@xenomai.org>
	<51764485.9020403@siemens.com> <51766E65.1010304@xenomai.org>
	<5176813B.9030404@xenomai.org>
In-Reply-To: <5176813B.9030404@xenomai.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Default options in the debian package
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 2013-04-23 14:40, Philippe Gerum wrote:
>> Well, we have --enable-posix-auto-mlockall for that. But you are right,
>> we get rid of all this and enable automatic mlockall for all skins. I do
>> not see any drawbacks.
>>
>>
> 
>  From the dept of Xenomai archive: the original intent of controlling 
> when and how memory locking is done was to address this bug with very 
> old kernels:
> 
> http://lkml.indiana.edu/hypermail/linux/kernel/0310.0/0649.html
> 
> Back then, apps mmapping I/O space would then mlock(MCL_CURRENT), 
> mmap(I/O space), then mlock(MCL_FUTURE) to work around this bug manually.
> 

Interesting - but luckily no longer relevant. :)

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SDP-DE
Corporate Competence Center Embedded Linux

