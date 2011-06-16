Message-ID: <4DF9DCE3.70703@domain.hid>
Date: Thu, 16 Jun 2011 12:37:23 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4DF9CA75.1040903@domain.hid>
In-Reply-To: <4DF9CA75.1040903@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai on i7-870
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jakub Nowacki <j.s.nowacki@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

On 06/16/2011 11:18 AM, Jakub Nowacki wrote:
> On 16 June 2011 08:01, Gilles Chanteperdrix
> <gilles.chanteperdrix@xenomai.org> wrote:
>> On 06/15/2011 10:43 PM, Jakub Nowacki wrote:
>>> On 15/06/2011 17:51, Gilles Chanteperdrix wrote:
>>>> On 06/15/2011 06:21 PM, Jakub Nowacki wrote:
>>>>> I have SMI workaround switched on.
>>>>
>>>> Have you verified that the your chipset is supported by SMI workaround?
>>>> http://www.xenomai.org/index.php/Configuring_x86_kernels#In_case_of_high_latencies
>>>>
>>> Indeed, it's not on, nothing SMI-related shown in Krenel's log. I've
>>> found that my LPC is 'Intel Corporation 5 Series Chipset LPC Interface
>>> Controller (rev 06)' (full lspci log is enclosed for a reference).
>>
>> You should use lspci -n in order to get the numerical ids.
> 
> Yes, I noticed that after I went home and looked into the log. 'lspci
> -nn' gives:
> 
> 00:1f.0 ISA bridge [0601]: Intel Corporation 5 Series Chipset LPC
> Interface Controller [8086:3b0a] (rev 06)
> 
> BTW the above wiki entry is slightly misleading because it suggest
> 'lspci -vv', whereas, if you want the actual numerical IDs you need
> the -n or -nn option.

wiki updated. Thanks.

-- 
                                                                Gilles.

