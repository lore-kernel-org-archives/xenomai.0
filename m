Message-ID: <4976027D.2090905@domain.hid>
Date: Tue, 20 Jan 2009 17:57:33 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <4975FF9F.1050503@domain.hid> <4976001B.5050105@domain.hid>
In-Reply-To: <4976001B.5050105@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] switchtest fails with pthread_create:
 Cannot	allocate memory
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
Cc: xenomai-help <xenomai@xenomai.org>

Gilles Chanteperdrix wrote:
> Wolfgang Grandegger wrote:
>> Hello,
>>
>> when I try to run "switchtest" from the test-suite, I get the error
>>
>>   "pthread_create: Cannot allocate memory"
>>
>> on my MPC5200 PowerPC board. Some resource is exhausted and likely it's
>> system memory. I already realized heavy memory usage by threads using
>> the Xenomai POSIX skin. 
>>
>> -bash-3.2# free      
>>              total       used       free     shared    buffers     cached
>> Mem:         61280      12044      49236          0          0       5796
>>
>> -bash-3.2# ./switchtest rtk0 rtk0 rtup0 rtup0 rtus0 rtus0 rtuo0
>>
>> -bash-3.2# free
>>              total       used       free     shared    buffers     cached
>> Mem:         61280      59700       1580          0          0       3932
>>
>> Any idea what could cause the exhaustive use of memory? Is it the same on
>> x86? This test was  done with Linux 2.6.26 i-Pipe 2.2-07 and Xenomai 2.4.x
>> but it's the same with trunk.
> 
> It not is the stack size problem described in TROUBLESHOOTING ?

Well, RTFM, it seems to be exactly the problem described in there.
Setting "ulimit -s 2048" before starting "switchtest" helps.

Thanks.

Wolfgang.





