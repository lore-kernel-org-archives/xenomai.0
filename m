Message-ID: <4A3CF77F.8060705@domain.hid>
Date: Sat, 20 Jun 2009 16:51:43 +0200
From: Stefan Kisdaroczi <kisda@domain.hid>
MIME-Version: 1.0
References: <4A3CC746.3040605@domain.hid> <4A3CF399.3010000@domain.hid>
In-Reply-To: <4A3CF399.3010000@domain.hid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] debian specific kernel patching/unpatching
 problems with 2.6.29
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Gilles Chanteperdrix schrieb:
> Stefan Kisdaroczi wrote:
>   
>>  config LOCALVERSION
>>      string "Local version - append to kernel release"
>> +    default "-ipipe"
>>      help
>>     
>
> Hi, why is this hunk needed ?
>   
this hunk is in the adeos patch, see adeos-ipipe-2.6.29.5-x86-2.4-01.patch


