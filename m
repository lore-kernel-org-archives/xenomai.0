MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Mon, 28 Nov 2016 14:34:03 -0500
From: andrija@stupar.com
In-Reply-To: <b049cec3-3df5-d18d-a50e-9a9654f9094f@xenomai.org>
References: <e91afecfce4b074fe8e8bcce5d868237@stupar.com>
 <b049cec3-3df5-d18d-a50e-9a9654f9094f@xenomai.org>
Message-ID: <d990539f06316a5a249ea6dcbb0caf77@stupar.com>
Sender: andrija@stupar.com
Subject: Re: [Xenomai] Migrating device drivers from RTLinux to
	Xenomai/Analogy
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jorge Ramirez <jro@xenomai.org>
Cc: xenomai@xenomai.org

Hi Jorge,

Thanks for your reply. I have posted the driver on github:
https://github.com/AndrijaPFC/RTDAQDriver/blob/master/acromag.c

That's the only .c file. Here is the full repo., with all the header 
files:
https://github.com/AndrijaPFC/RTDAQDriver

I don't know if I can run it on a vanilla kernel, I haven't tried. I am 
looking at the system header files, and they don't seem to point to 
anything unusual in the .c file itself, except possibly for rtl_debug.h 
(which from searching for it online, I cannot determine whether it is 
something which comes with a vanilla kernel or not).

Another clue may be in the header file
https://github.com/AndrijaPFC/RTDAQDriver/blob/master/rtce_module.h

which itself invokes system header files rtl.h, rtl_sched.h and 
rtl_time.h which seem to like RT-Linux specific things...or no?

Thanks a lot again,

Andrija Stupar

On 2016-11-28 08:46, Jorge Ramirez wrote:
> On 11/25/2016 11:03 PM, andrija@stupar.com wrote:
>> How much of an effort would it be to port said drivers to 
>> Xenomai/Analogy, approximately? Is this relatively straightforward, or 
>> does it require writing from scratch?
> 
> Hi Andrija
> 
> It really depends on the quality of the linux driver that you are
> trying to port and the RTLinux services that you depend on. Can your
> driver run on a vanilla kernel?
> Maybe you could post your driver to github and we can then try to give
> you a ballpark estimate.
> 
> jorge
> 
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> https://xenomai.org/mailman/listinfo/xenomai

