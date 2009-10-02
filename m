Message-ID: <4AC5F8ED.7020500@domain.hid>
Date: Fri, 02 Oct 2009 14:58:21 +0200
From: Roman Pisl <rpisl@domain.hid>
MIME-Version: 1.0
References: <4AC5E895.8010107@domain.hid>
	<634c78ce0910020545i432ac3e4m405d58746eb262f3@domain.hid>
In-Reply-To: <634c78ce0910020545i432ac3e4m405d58746eb262f3@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Freeze on SMP x86-64
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Peter Soetens <peter@domain.hid>
Cc: xenomai@xenomai.org

On 2.10.2009 14:45, Peter Soetens wrote:
> On Fri, Oct 2, 2009 at 13:48, Roman Pisl<rpisl@domain.hid>  wrote:
>> Hello,
>> I just tried x86-64 SMP Linux/Xenomai on my workstation (Intel Core2
>> Quad) but it freezes immediately after latency test or clocktest is
>> started. It freezes even during the boot, when Xenomai debbuging is
>> enabled.
>
> Xenomai/adeos version ?
>
> Peter

I tried git xenomai-head with Linux 2.6.31, 2.4.9.1 and Xenomai 2.5-rc3 
with Linux 2.6.28 and 2.6.30 with latest adeos patch. It is always the 
same, x86-64 freezes.

Roman

