Message-ID: <45F7D8BF.90409@domain.hid>
Date: Wed, 14 Mar 2007 12:13:03 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Subject: Re: =?ISO-8859-1?Q?R=E9p=2E_=3A_=5BXenomai-help=5D_RT_sa?=
	=?ISO-8859-1?Q?mples?=
References: <s5f66cc3.068@domain.hid> <20070313204835.118140@domain.hid>
In-Reply-To: <20070313204835.118140@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: karre@domain.hid
Cc: xenomai@xenomai.org

karre@domain.hid wrote:
>>> I want to measure and evalutate different parameters of system load in
>> Xenomai. Therefore, I am in need of RT samples that simply >provide a
>> variety of ressource usage (semaphores, threads, timers, ...).
>>  
>> Have a look on http://svn.gna.org/svn/xenomai/trunk/examples/ 
> 
> Thanks. I already knew these. Also, I tried rtcan_rtt.c, which didn`t compile yet (CAN_RAW and serveral mq_... - functions undefined).

The following works for me:

$ cd /temp/xeno/test
$ svn co http://svn.gna.org/svn/xenomai/trunk xenomai
$ cd xenomai/
$ ./configure --prefix=/temp/xeno/test/xenoinst
$ make
$ make install
$ cd examples/rtdm/profiles/can
$ make XENO=/temp/xeno/test/xenoinst

Can you confirm that?

> Does anyone know other open source real time applications?
> 
> 
>>> Btw, the type of skin (Native, POSIX, RTAI, ...) is not important. If
>> it is software that is platform-dependant, than the architecture of
>>> choice would be x86. If there was not needed additional hardware, that
>> would be ideal.
>>  
>> You could run linux+xenomai on your PC ...
> 
> Of course I am doing that.
> 
> What I need now is some sample programs. Thanks in advance for any hint!

See http://www.xenomai.org/documentation/trunk/html/api/examples.html. 
Also the test programs in "src/testsuite" are useful.

Wolfgang.


