References: <1413460213.12609.YahooMailNeo@web121502.mail.ne1.yahoo.com>
 <20141016173200.GC30661@sisyphus.hd.free.fr>
Message-ID: <1413567684.37999.YahooMailNeo@web121505.mail.ne1.yahoo.com>
Date: Fri, 17 Oct 2014 10:41:24 -0700
From: Arsalan Shahid <arsalan_shahid116@yahoo.com>
In-Reply-To: <20141016173200.GC30661@sisyphus.hd.free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: Re: [Xenomai] undefined reference of rt_timer_read()
Reply-To: Arsalan Shahid <arsalan_shahid116@yahoo.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Thanks for your prompt response. 

Gilles, I compiled my code with OpenMP + Xenomai as 

> xeno-config --skin=--xeno-cflags
> xeno-config --skin=--xeno-ldflags
> export CFLAGS=`xeno-config --xeno-cflags`
> export LDFLAGS=`xeno-config --xeno-ldflags`
> gcc -fopenmp $CFLAGS $LDFLAGS  -lnative -lrtdk  code.c -o code

For -lrtdk I understood the point. But I think I am compiling the code correctly. What do you say ? 

Also, I am doing all this in my virtual machine using VmWare. Do you think this can be an issue to access rt_ functions of NATIVE skin due to their RT design ? 

Thanks & Regards 
Arsalan Shahid 



On Thursday, October 16, 2014 10:32 PM, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote:
 


On Thu, Oct 16, 2014 at 04:50:13AM -0700, Arsalan Shahid wrote:
> Hi 

Hi,

> 
> I pray that this message finds you in the Best of Health & Happiness

Thanks, but you do not need to be so formal, a simple "hi" will do.

> I am using NATIVE skin of Xenomai along with OpenMP. Xenomai works
> perfectly fine with NATIVE skin when we use it along OpenMP. But
> In my codes when ever I tried to access any Function of Native
> skin I get an error in compilation. I used rt_timer_read() as
> shown below.
> 
> RTIME now;
> now = rt_timer_read();
> 
> code.c:(.text+0x33): undefined reference to `rt_timer_read'
> code.c:(.text+0x49): undefined reference to `rt_timer_ticks2ns'

I believe the problem to be in the way you compile your program. You
should obtain the correct flag with the "xeno-config" program,
documented here:
http://www.xenomai.org/documentation/xenomai-2.6/html/xeno-config/

Also beware of gcc link order beginners trap: the order of arguments
on gcc command line matters:
https://gcc.gnu.org/onlinedocs/gcc/Link-Options.html

> 
> Same is the case when I call used rt_printf. Another thing which
> comes while compiling Xenomai application occurs when I give
> command line option (-lrtdk). Without this code is compiled but
> with this it gives error.

For -lrtdk, see:
http://www.xenomai.org/pipermail/xenomai/2012-January/025149.html


Regards.

-- 
                        Gilles.
