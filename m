Message-ID: <516BFB28.9050409@xenomai.org>
Date: Mon, 15 Apr 2013 15:05:44 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <CAPpP=rPQa-Fa+1j7Lb11dUX8srkinCQQ2yS2gR5y9f9Pqf1jdg@mail.gmail.com>
	<516998B7.9090901@xenomai.org>
	<CAPpP=rOEjuy8w0x-_zRv_7vHDOmjU6n1Hi=jrE6UNEULL=zYcQ@mail.gmail.com>
	<5169C63B.1070406@xenomai.org>
	<CAPpP=rMOmOkd2Gwswu685zsPhxJDMj7GnRWA0yU+gRHmz=V2bw@mail.gmail.com>
	<5169EC2C.4000101@xenomai.org>
	<CAPpP=rNCBdcussSRzHN_Vpjj0afWZRGKRqPXxh7ps2-_GP7nBQ@mail.gmail.com>
	<516BC4DF.3030302@xenomai.org>
	<CAPpP=rMRx5CKj2uJv3wBSu=UUb88W2nXy73z1B6ewBgXEQNYiQ@mail.gmail.com>
	<516BF43D.7070708@xenomai.org>
In-Reply-To: <516BF43D.7070708@xenomai.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [QUESTION] thread creation and hook function
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: alex alex <duch.alexandre@gmail.com>
Cc: Xenomai <xenomai@xenomai.org>

On 04/15/2013 02:36 PM, Philippe Gerum wrote:
> On 04/15/2013 12:25 PM, alex alex wrote:
>> linux kernel : 3.2.21
>> xenomai version : 2.6.2.1
>> arch: x86
>>
>> Thank, I add your code and now I have :
>>
>> case 1 : ( without nanosleep(0) )
>>
>>   6138.151187] TRD: 394830ns - NOM "ROOT/0" - CPU 0 - RT:1 - linux
>> [ 6138.159924] TRD: 9127501ns - NOM "hook" - CPU 0 - RT:0 - shadow
>> [ 6138.159953] TRD: 9163835ns - NOM "ROOT/0" - CPU 0 - RT:1 - linux
>> [ 6138.160014] TRD: 370242723ns - NOM "ROOT/0" - CPU 0 - RT:1 - linux
>> [ 6138.520008] TRD: 370429306ns - NOM "ROOT/0" - CPU 0 - RT:1 - linux
>> [ 6139.521009] TRD: 1370433173ns - NOM "hook" - CPU 0 - RT:1 - user-space
>> shadow in real-time mode
>> [ 6139.521014] TRD: 1370446122ns - NOM "ROOT/0" - CPU 0 - RT:1 - linux
>> [ 6139.521705] TRD: 1371147808ns - NOM "ROOT/0" - CPU 0 - RT:1 - linux
>> [ 6139.521723] TRD: 1371168314ns - NOM "ROOT/0" - CPU 0 - RT:1 - linux
>>
>> case 2 : ( with nanosleep(0) before the loop )
>>
>> [ 6144.996779] TRD: 382277ns - NOM "ROOT/0" - CPU 0 - RT:1 - linux
>> [ 6145.005024] TRD: 8625148ns - NOM "hook" - CPU 0 - RT:0 - shadow
>> [ 6145.005054] TRD: 8659990ns - NOM "ROOT/0" - CPU 0 - RT:1 - linux
>> [ 6145.008013] TRD: 8730535ns - NOM "ROOT/0" - CPU 0 - RT:1 - linux
>> [ 6145.008013] TRD: 8734846ns - NOM "hook" - CPU 0 - RT:1 - user-space
>> shadow in real-time mode
>> [ 6145.008013] TRD: 367409427ns - NOM "ROOT/0" - CPU 0 - RT:1 - linux
>> [ 6145.363763] TRD: 367634768ns - NOM "ROOT/0" - CPU 0 - RT:1 - linux
>> [ 6146.363810] TRD: 1367637465ns - NOM "hook" - CPU 0 - RT:1 - user-space
>> shadow in real-time mode
>> [ 6146.363815] TRD: 1367646922ns - NOM "ROOT/0" - CPU 0 - RT:1 - linux
>> [ 6146.365055] TRD: 1368896836ns - NOM "ROOT/0" - CPU 0 - RT:1 - linux
>> [ 6146.365073] TRD: 1368916343ns - NOM "ROOT/0" - CPU 0 - RT:1 - linux
>>
>> If I follow these outputs, this means that the loop is made by a linux
>> task
>> and if I add a nanosleep just before, the loop is done by the xenomai
>> task.
>> Moreover, "hook " switch in primary mode only when it is destroyed
>> unless we
>> force a primary switch with nanosleep(0) before the loop.
>>
>> Is a xenomai thread shouldn't start in primary mode
>
> It certainly does.
>
>   or maybe it wait for a
>> rt service to switch in primary mode?
>>
>
> I can't give you any information. I downloaded your code and can't see
> any "hook" task. There is a "hook" driver, a "tr_sleep" task, but
> nothing else. Besides, your Makefile should use xeno-config for getting
> the proper build flags. Handcrafting this is the fastest path to hell
> with the POSIX skin.
>
> Until I can make sense of the output you mention looking at the actual
> code, I won't be able to help.
>
> /proc/xenomai/sched and /proc/xenomai/stat may help to determine who is
> running, in which mode.
>

Note: the _get_time() routine in your driver looks broken. In addition, 
calling rtdm_printk services from the hook is strongly discouraged 
unless you don't care for timings.

-- 
Philippe.

