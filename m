Message-ID: <45CC7F72.5020706@domain.hid>
Date: Fri, 09 Feb 2007 15:04:34 +0100
From: Stephan Zimmermann <s.zimmermann@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] fata: removing non-linked element...
References: <45CC651C.6060402@domain.hid> <45CC68F3.1000003@domain.hid>
In-Reply-To: <45CC68F3.1000003@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
Cc: xenomai@xenomai.org

Jan Kiszka schrieb:
> Stephan Zimmermann wrote:
>> Hi,
>> I just saw the following errormessages while running some tests with my
>> application.
>>
>> "Xenoami: fatal: removing non-linked element, holder=ef9a5794
>> qslot=f96f70d0 at include/xenoami/nucleus/queue.h:422"
>> "Xenomai: Stuck on nucleus lock f96f6380"
> 
> I guess you had to hand-copy the message. There should be some back
> trace following that is annoying to type.  Maybe you can capture it with
> a serial console (if your machine still has "legacy" interfaces). Or,
> even better, you try to derive a demo code for triggering the bug.

Sorry, no Backtrace available, the machine crashes so abrupt, that I 
just saw the console stop in the middle of a line (letters cut throgh 
from left to right...). I am trying to work out some demo code.

By the way, same app on my Pentium M (same softwareversions),  won't
crash but tells me " Xenomai: Switching MAINTASK to secondary mode after
exception #14 from user-space at 0xb7f5b352 (pid 9600)"

>> Followed by pressing the reset-button...
>>
>> I Run Xenomai 2.3 rev 2139 on AMD X2, kernel 2.6.17.14, debian sarge.
>>
>> May this be due to an misbehaviour in my app, or does it look like
>> something xenomai related? I am not sure how to interpret these messages.
> 
> This is nothing your application should be allowed to cause.
> 
> Jan
> 



