Message-ID: <44450CC2.4080505@domain.hid>
Date: Tue, 18 Apr 2006 17:58:58 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [patch] xeno-test email addition
References: <200604171047.51730.niklaus.giger@domain.hid>	<44444AB2.9020305@domain.hid>
	<4445068A.8000008@domain.hid>
In-Reply-To: <4445068A.8000008@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jim Cromie <jim.cromie@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jim Cromie wrote:
> Jim Cromie wrote:
> 
>> Niklaus Giger wrote:
>>
>>> Hi
>>>
>>> Following a suggestion from Philippe Gerum I propose to collect and 
>>> prepare like this:
>>>
>>> a) Make it easy to collect information
>>>
>>> add -s/-c option to xeno-test, help text would look like -s         
>>> send output of xeno-test to xeno-stat@domain.hid
>>> -c <name>  if -s, send also kernel config file to xeno-stat@domain.hid
>>>   
>>
>> attached patch adds new -m -M flags for xeno-test, (-s flag is taken, 
>> for statistics)
>> former for a fixed addy (to be patched later), latter taking any email 
>> as arg.
>>
>> I didnt add -c <name>, since xeno-test already does something similar;
>> if you build with CONFIG_IKCONFIG_PROC=y, xeno-test greps XENO out of 
>> /proc/config.gz
>> (probably needs a few more grep terms, and perhaps a -verbose mode which
>> cats the whole thing.)
>>
>> The -M option works, since I just received an email Id sent earlier,
>> but I also sent one to xenomai-core, and it hasnt shown up yet.
>> I suspect that the mail looks like spam, and has been rejected,
>> since my hostname is not a real FQDN.
>> So Im not so sure that email is the best way here, but it is 
>> conceptually simple.
> 
> 
> 
> 
> Oof.  Now attached.
> 

Applied, thanks.

-- 

Philippe.

