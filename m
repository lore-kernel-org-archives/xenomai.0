References: <CA+CJOCzk4p0RmpCsYoCQ71Tbckb5Ztj88ORnD2i-sU2jTg115Q@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <55B8A5A3.5040000@xenomai.org>
Date: Wed, 29 Jul 2015 12:06:27 +0200
MIME-Version: 1.0
In-Reply-To: <CA+CJOCzk4p0RmpCsYoCQ71Tbckb5Ztj88ORnD2i-sU2jTg115Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Task killed by watchdog after exception #7
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Nicolas SCHURANDO <schurann@ext.essilor.com>, xenomai@xenomai.org

On 07/29/2015 10:49 AM, Nicolas SCHURANDO wrote:
> Hello everybody,
> 
> I am running a real-time application using the VxWorks skin, on a Raspberry
> Pi 1, with Xenomai 2.6.4. The application also makes use of the native API
> to spawn an additional and periodic task. I have witnessed that, at random,
> the product will stop working. Taking a look at the syslog indicates that
> one of the VxWorks tasks (here CDL, but not always the same) gets killed by
> the watchdog shortly after having been switched to second mode.
> 
> Jul 27 09:09:26 raspberrypi kernel: [ 1600.407883] Xenomai: Switching CDL
>> to secondary mode after exception #7 from user-space at 0x37d1b0 (pid 2539)
>> Jul 27 09:09:35 raspberrypi kernel: [ 1605.135965] Xenomai: watchdog
>> triggered -- signaling runaway thread 'CDL'
>

[snip]

Please also mention the kernel and I-pipe releases in reports, those may
be involved in issues.

> Doing a symbol search on the address 0x37d1b0 points to the following
> function, and in particular, to the vmov instruction.
> 

Exception #7 in the pipeline means undefined instruction trap. It looks
like your code is getting a VFP bounce on the vmov instruction, which
IIRC, can happen with the type of VFP unit on that ARM11 CPU (assuming
RPI 1). Checking the ARM TRM for information about IEEE754 compliance
may help in this case.

[snip]

> Is the hard-float operation the reason why the task gets switched to
> secondary mode ?

Yes, due to the bounce.

 And if so, why wouldn't I be able to make use of the FPU
> in primary mode ?

You are, but your code may have triggered a situation where it had to
trap to kernel space for running some helper code, and this trap caused
the pipeline to switch that task away from primary mode for re-entering
the regular VFP trap handler safely.

 Would I be right to assume that, when the task gets
> switched to secondary mode, and because the other tasks are already
> requiring a lot of cpu time, there is not enough free cpu time to run the
> newly switched task which gets then killed by the watchdog ?

Unlikely, but possible, if the CDL task takes ages to run the mode
switching code, and gets caught by the watchdog tick before it had a
chance to eventually suspend from primary mode.

-- 
Philippe.

