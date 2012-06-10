Message-ID: <4FD4EB23.7080203@laposte.net>
Date: Sun, 10 Jun 2012 20:44:51 +0200
From: Marc Le Douarain <marc.le-douarain@laposte.net>
MIME-Version: 1.0
References: <4FCD0BD8.70103@laposte.net> <4FCD0C4D.6000004@xenomai.org>
In-Reply-To: <4FCD0C4D.6000004@xenomai.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] "illegal instruction",
 then "rt_task_start()" error -38 (on a 486/no fpu)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Le 04/06/2012 21:28, Gilles Chanteperdrix a écrit :
> On 06/04/2012 09:26 PM, Marc Le Douarain wrote:
>> Hello,
>>
>> I've some difficulties to run Xenomai with a little 'hello' example
>> (that create/start a task)
>> on a target 486 processor (without fpu).
>>
>> I successfully compiled the Linux kernel 2.6.38.8 with
>> adeos-ipipe-2.6.38.8-x86-2.11-02.patch (Xenomai version is 2.5.6)
>> (modify file xenomai-2.5.6/include/asm-x86/calibration.h
>> "current_cpu_data"->"cpu_info" were required)
>>
>> dmesg extract:
>> [    0.000000] I-pipe 2.11-02: pipeline enabled.
>> ...
>> [    0.140008] CPU: Cyrix Cx486SLC
>> ...
>> [    1.440804] Xenomai: hal/i386 started.
>> [    1.448804] Xenomai: scheduling class idle registered.
>> [    1.452804] Xenomai: scheduling class rt registered.
>> [    1.488806] Xenomai: real-time nucleus v2.5.6 (Wormhole Wizards) loaded.
>> [    1.496807] Xenomai: starting native API services.
>> [    1.500807] Xenomai: starting POSIX services.
>> [    1.504807] Xenomai: starting RTDM services.
> It may be due to the omit-frame-pointer option, please try adding
> -fno-omit-frame-pointer to the CFLAGS
Thanks for the tip,
now it seems to work correctly !
I've used the following command line to configure Xenomai user-part :
"./configure CFLAGS="-march=i486 -fno-omit-frame-pointer" 
LDFLAGS="-march=i486" --disable-x86-sep --disable-x86-tsc"

I've savagely modified latency.c, to avoid libm and double variables in 
the code,
and now when launching a 10millisecs period,
without load I've at worst about 170 microsecs, and best 90 microsecs.
and with load (dd if=/dev/zero of=/dev/null & telnet session while ls;do 
ls;done & ping -f) :
worst 200 microsecs, and best 110 microsecs.
For you, seems to be correct for an embedded equivalent 486 at 300 mhz ?
(Linux bogomips gives : 96.51)

Again, many thanks for the gcc optimize flag to avoid on it ! ;-)

Bye.


