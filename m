Message-ID: <4C97106E.7060602@domain.hid>
Date: Mon, 20 Sep 2010 09:42:38 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTi=5RZVyUPvThyLDRPsmD9U0=A8_UPPm3bUi1E_q@domain.hid>
	<1284960227.4114.11.camel@domain.hid>
In-Reply-To: <1284960227.4114.11.camel@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] pSOS+ simple example returns error code -14
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

Philippe Gerum wrote:
> On Sun, 2010-09-19 at 16:04 +0100, ronny meeus wrote:
>> Hello
>>
>> I'm using xenomai in a qemu setup.
>> My final goal is to use xenomai to port extisting pSOS application to
>> the linux platform.
>>
>> The first step I did was building a kernel with the pSOS skin enabled.
>> These traces are generated at kernel startup:
>> [    0.212363] I-pipe: Domain Xenomai registered.
>> [    0.212363] Xenomai: hal/i386 started.
>> [    0.212363] Xenomai: scheduling class idle registered.
>> [    0.212363] Xenomai: scheduling class rt registered.
>> [    0.246987] Xenomai: real-time nucleus v2.5.4 (Sleep Walk) loaded.
>> [    0.246987] Xenomai: debug mode enabled.
>> [    0.274658] Xenomai: starting native API services.
>> [    0.274658] Xenomai: starting POSIX services.
>> [    0.296357] Xenomai: starting RTDM services.
>> [    0.296357] Xenomai: registered exported object RN#0 (regions)
>> [    0.296357] Xenomai: starting pSOS+ services.
>> [    0.305601] HugeTLB registered 4 MB page size, pre-allocated 0
>> pages
>>
>> This is the example application:
>>
>> #include <psos+/psos.h>
>>
>> void task2_func(u_long a,u_long b,u_long c,u_long d)
>> {
>>         while (1) {
>>                 tm_wkafter(1000);
>>         }
>> }
>>
>> int main(int argc, char **argv)
>> {
>>         unsigned long tid;
>>         unsigned long args[4] = {0,0,0,0};
>>
>>         t_create("TEST",10,160000,160000,0,&tid);
>>         t_start(tid,0,task2_func,args);
>>         while (1) {
>>                 sleep(100);
>>         }
>> }
> 
> I'm unsure whether the code above is actually the one which issues the
> output mentioned below. I see no t_shadow call, and no status printout
> there.

Maybe the auto-shadowing of the main thread?

-- 
                                                                Gilles.

