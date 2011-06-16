Message-ID: <4DF9AA39.5050007@domain.hid>
Date: Thu, 16 Jun 2011 09:01:13 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4DF5EA11.5010006@domain.hid> <4DF64C3A.6080407@domain.hid>
	<4DF65FC8.1000703@domain.hid> <4DF6F87E.7000500@domain.hid>
	<4DF7436D.6040706@domain.hid> <4DF74640.5070802@domain.hid>
	<4DF8DC11.9000102@domain.hid> <4DF8E322.1090901@domain.hid>
	<4DF9196E.1000503@domain.hid>
In-Reply-To: <4DF9196E.1000503@domain.hid>
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
Cc: Jan Kiszka <jan.kiszka@domain.hid>, Xenomai help <xenomai@xenomai.org>

On 06/15/2011 10:43 PM, Jakub Nowacki wrote:
> On 15/06/2011 17:51, Gilles Chanteperdrix wrote:
>> On 06/15/2011 06:21 PM, Jakub Nowacki wrote:
>>> I have SMI workaround switched on.
>>
>> Have you verified that the your chipset is supported by SMI workaround?
>> http://www.xenomai.org/index.php/Configuring_x86_kernels#In_case_of_high_latencies
>>
> Indeed, it's not on, nothing SMI-related shown in Krenel's log. I've 
> found that my LPC is 'Intel Corporation 5 Series Chipset LPC Interface 
> Controller (rev 06)' (full lspci log is enclosed for a reference).

You should use lspci -n in order to get the numerical ids.

-- 
                                                                Gilles.

