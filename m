Message-ID: <4788E9ED.5060306@domain.hid>
Date: Sat, 12 Jan 2008 17:25:17 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <d3623eab0801110744y63764ba2sb122db96a85bde80@domain.hid>	
	<d3623eab0801110806y75b51c1kc31efe7d357de522@domain.hid>	
	<4787B3DB.5010507@domain.hid>
	<2ff1a98a0801111029g3d3312ads532b6ec0ca5bcaf7@domain.hid>
	<4788BE8C.5020000@domain.hid>
In-Reply-To: <4788BE8C.5020000@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] cannot make system() calls anymore
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>, jay@domain.hid

Jan Kiszka wrote:
> Gilles Chanteperdrix wrote:
>> On Jan 11, 2008 7:22 PM, Jan Kiszka <jan.kiszka@domain.hid> wrote:
>>> Jerome Pasquero wrote:
>>>> Hi,
>>>>
>>>> I recently upgraded from xenomai 2.3.0 under linux 2.6.17.14 to the latest
>>>> stable version of xenomai 2.4.1 under linux 2.6.23.12.
>>>> Everything seems to be working just fine, except that I seem to  no longer
>>>> be able to make system calls inside a real-time task. It simply freezes
>>>> everything and I need to restart my computer.
>>>> I don't know if it was just a fluke that it was working with 2.3.0 and that
>>>> I am not supposed to do that at all. Could it be that I forgot to include an
>>>> option when recompiling the kernel?
>>> A system freeze is not a valid reaction of Xenomai on invalid user
>>> activity - unless that freeze just means one of your high-prio tasks
>>> decided to enter an endless loop. Have you already tried to enable the
>>> Xenomai watchdog?
>> A freeze on fork (system calls fork) is typical of the "nocow" stuff
>> not working correctly.
> 
> Yep, you are most probably right: The page table walks in
> ipipe_disable_ondemand_mappings and below is not safe /wrt unused and
> bad entries. A test for p?d_none_or_clear_bad is missing, see attached
> patch. Jerome, could you try this one and report if it helps? Please
> also watch out for kernel messages that might pop up with this patch.
> 
> I'm not %100 sure if we should use clear_bad here or better just ignore
> bad pages. Once and only once during the last tests, I had a warning
> about a bad page in my syslog after running Jerome's test. On the other
> hand, most other code in mm/memory.c does it like that. Opinions?
> 

It seems that anyone detecting bad entries during walks should clear
them since this code very looks like a safety belt to trap unexpected
situations. The only minor issue for us to do more than ignoring, would
be to have the error message point the finger at the non-vanilla nocow
code, albeit it would not be responsible for this situation.

> Jerome's test triggered another, less critical I-pipe bug (SMP-related)
> I'm going to report separately.
> 
> Jan
> 


-- 
Philippe.

