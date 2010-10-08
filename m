Message-ID: <4CAF9F47.3030400@domain.hid>
Date: Sat, 09 Oct 2010 00:46:31 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <201010082121.43128.lux-integ@domain.hid>
	<4CAF88D2.1040103@domain.hid>
In-Reply-To: <4CAF88D2.1040103@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] a xenomai qustion
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: luxInteg <lux-integ@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Gilles Chanteperdrix wrote:
> luxInteg wrote:
>> Greetings,
>>
>> I am about to restart dabbling with xenomai on a cblfs x86_64/64-bit machine .  
>> I have a question. Could one have multiple instances of kernels  
>> patched/compiled/installed  thus  multiple instances of /lib/modules-xyz  AND 
>> a single instance of xenomai in userspace  that works with all of them?
>>
>> Advice would be appreciated.
> 
> The answer to your question is that the ABI is compatible between the
should read "is that the kernel and user ABIs MUST BE compatible"

-- 
                                                                Gilles.

