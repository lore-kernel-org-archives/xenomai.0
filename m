Message-ID: <4350BD80.60100@domain.hid>
Date: Sat, 15 Oct 2005 10:27:44 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] remove_proc_entry problem semi-tracked down
References: <BF727E02.1806%steve@domain.hid>
In-Reply-To: <BF727E02.1806%steve@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
To: Steven Seeger <steve@domain.hid>
Cc: xenomai@xenomai.org

Steven Seeger wrote:
> It doesn't break when all my app does is this. This issue requires more
> investigation. Still, nothing I do in userspace should make it kernel panic.
> :)

Dmitry found a serious flaw in the recent I-pipe patches that I've just fixed. 
You might want to try this one out:
http://download.gna.org/adeos/patches/v2.6/adeos/i386/adeos-ipipe-2.6.13-i386-1.0-07.patch

> 
> Steven
> 
> On 10/12/05 7:54 AM, "Philippe Gerum" <rpm@xenomai.org> wrote:
> 
> 
>>Steven Seeger wrote:
>>
>>>I only seem to get this problem if I start and stop my app a few times
>>>without unloading the xenomai modules and reloading them, btw.
>>>
>>
>>Ok, this might be a useful hint. Please try crafting a simple test case
>>creating 
>>a hundred mutexes then destroying them in a row, restarting this app a few
>>times 
>>without unloading the xeno_native module. It would help to know if it breaks
>>too.
> 
> 
> 


-- 

Philippe.

