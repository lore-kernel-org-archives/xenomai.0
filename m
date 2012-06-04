Message-ID: <4FCD0C4D.6000004@xenomai.org>
Date: Mon, 04 Jun 2012 21:28:13 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4FCD0BD8.70103@laposte.net>
In-Reply-To: <4FCD0BD8.70103@laposte.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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
To: Marc Le Douarain <marc.le-douarain@laposte.net>
Cc: xenomai@xenomai.org

On 06/04/2012 09:26 PM, Marc Le Douarain wrote:
> Hello,
> 
> I've some difficulties to run Xenomai with a little 'hello' example 
> (that create/start a task)
> on a target 486 processor (without fpu).
> 
> I successfully compiled the Linux kernel 2.6.38.8 with 
> adeos-ipipe-2.6.38.8-x86-2.11-02.patch (Xenomai version is 2.5.6)
> (modify file xenomai-2.5.6/include/asm-x86/calibration.h 
> "current_cpu_data"->"cpu_info" were required)
> 
> dmesg extract:
> [    0.000000] I-pipe 2.11-02: pipeline enabled.
> ...
> [    0.140008] CPU: Cyrix Cx486SLC
> ...
> [    1.440804] Xenomai: hal/i386 started.
> [    1.448804] Xenomai: scheduling class idle registered.
> [    1.452804] Xenomai: scheduling class rt registered.
> [    1.488806] Xenomai: real-time nucleus v2.5.6 (Wormhole Wizards) loaded.
> [    1.496807] Xenomai: starting native API services.
> [    1.500807] Xenomai: starting POSIX services.
> [    1.504807] Xenomai: starting RTDM services.
> 
> After compiling user-space Xenomai part with
> ./configure --disable-x86-sep --disable-x86-tsc / make / sudo make install
> and copy /usr/xenomai/lib on the target
> I've got "illegal instruction" with my little 'hello test' example that 
> create/start a task.
> 
> Then I've tried to add flag to set 486 instruction set to gcc...
> For that, to compile user-space this time I used :
> ./configure CFLAGS="-march=i486" LDFLAGS="-march=i486" --disable-x86-sep 
> --disable-x86-tsc / make / sudo make install
> Now, at rt_task_start, I've got an error code -38 !
> 
> Any one have an idea on the trouble ?
> (at start thinking on the fpu missing, but seems not to be used !? no 
> libm dependance)

It may be due to the omit-frame-pointer option, please try adding
-fno-omit-frame-pointer to the CFLAGS


-- 
                                                                Gilles.

