Message-ID: <4E145EAE.6000006@domain.hid>
Date: Wed, 06 Jul 2011 15:10:06 +0200
From: zenati <omar.zenati@domain.hid>
MIME-Version: 1.0
References: <4E00B9BA.2050306@domain.hid> <4E145376.8000402@domain.hid>
	<4E145A2E.2080406@domain.hid>
In-Reply-To: <4E145A2E.2080406@domain.hid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Implementation of skin Arinc653,
 process don't return
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai-core@domain.hid

No I don't implement any handler, but there isn't a handler by default? 
I don't see any handler of signals in the sources of others skins. it 
means that I have to implement a handler in source of the test?

On 07/06/2011 02:50 PM, Gilles Chanteperdrix wrote:
> On 07/06/2011 02:22 PM, zenati wrote:
>> Dear,
>>
>> I have implement a first version of the skin Arinc 653. However, I match
>> one bug. Each time I execute a test I have implemented (Hello world
>> test). The process display "Hello world!" but don't return and even if I
>> do control-z or control-c the process don't terminate.
>>
>> have and idea to fix this problem??
> It is hard to say anything witout seeing any code, but, when you hit
> ctrl-C or ctrl-Z, the process receives a signal SIGINT or SIGTSTP. So,
> in the implementation of this skin, did you handle the interruption of
> blocking system calls by a signal correctly ?
>


