Message-ID: <4FFDAC05.6080305@xenomai.org>
Date: Wed, 11 Jul 2012 18:38:29 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4FE6F616.1010900@antcom.de> <4FE70080.6020109@xenomai.org>
In-Reply-To: <4FE70080.6020109@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Debian Bug#678695: Xenomai posix skin : bug with
 pthread_mutex_trylock function
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Roland Stigge <stigge@antcom.de>
Cc: 678695@bugs.debian.org, duch.alexandre@gmail.com, Xenomai@xenomai.org

On 06/24/2012 01:56 PM, Gilles Chanteperdrix wrote:
> On 06/24/2012 01:12 PM, Roland Stigge wrote:
>> Original Report (the report at the above link contains the example file):
>>
>> Package: xenomai
>> Version: 2.6.0
>>
>> Kernel:2.6.38.8 - Xenomai:2.6.0
>> arch:i686 i386 GNU/Linux
>>
>> Hi,
>>
>> The attached code shows a malfunction of the pthread_mutex_trylock function.
>>
>>
>> Description of test.c:
>> The main task takes the mutex during 1second while the 't1' task tries
>> to take this mutex from 0.5sc.
>> We can notice that with the posix skin of xenomai, t1 never succeeded to
>> take the mutex, which is not the case without the posix skin of xenomai.
>>
>>
>>
>> Duchesne Alexandre
>> duch.alexandre@gmail.com
> 
> pthread_mutex_trylock is know to be broken in Xenomai 2.6.0, this has 
> been fixed in xenomai current development branch. See patches:
> http://git.xenomai.org/?p=xenomai-2.6.git;a=commitdiff;h=a0822a77ba383dac832253e6f0ca3431860a5661;hp=b3af76a4dc4cc2282fb83cdfeb9c454a1242a125
> http://git.xenomai.org/?p=xenomai-2.6.git;a=commitdiff;h=de094a9e580511eb2dfdc0cee78bf92c959e2c55;hp=28256f3937c80f25fd6f49394a4ffb5d7b3179c7
> 

This should be fixed in the just released Xenomai 2.6.1.

-- 
					    Gilles.

