Date: Mon, 3 Jan 2011 23:39:09 +0100
From: Alexis Berlemont <alexis.berlemont@domain.hid>
Message-ID: <20110103223909.GA2862@domain.hid>
References: <A54FA449-A0A8-4DCF-96C0-078ED6729C4C@usc.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A54FA449-A0A8-4DCF-96C0-078ED6729C4C@usc.edu>
Subject: Re: [Xenomai-core] Analogy DIO data acquisition
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Stefan Schaal <sschaal@domain.hid>
Cc: xenomai@xenomai.org

Hi,

Sorry for the late reply.

Happy new Year!!!

Stefan Schaal wrote:
> Hi Alexis,
> 
>    I was wondering whether you could help me with some information about CMD based data acquisition in analogy.
> You might recall from previous emails with you, we are trying to implement high speed data DIO communication with a NI6259 board. We use the CMD structure to create a periodic task, that is clocked by a timer, to achieve the required communication speed. As we need to change the R/W polarity on some channels every 20-30 scans, we need essentially to find out when the data in the communication buffer are consumed, such that we change polarity and trigger the next set of acquisitions. Currently, working with the MMAP options seems to be the best way of handling this.
> 
>    I just had some questions concerning how to detect when the data are consumed. It appears that the periodic task is automatically canceled when a "DMA underun" is discovered (as can be checked with dmesg). Is this automatic canceling behavior the officially correct behavior?
> 
>   I can use a4l_poll to find out how much data is left in the
>   communication buffer --- I noticed that it returns -EPIPE when the
>   data buffer has been consumed, which also seems to indicate that
>   the periodic task has been canceled. (So for, the -EPIPE return
>   code is not documented in Analogy).

In my TODO list, there is something which might satisfy your
needs. Once, someone asked for getting awoken only when a specific
amount of data has been made available by an input subdevice. 

Gilles proposed the use of a specific ioctl to configure a wake-up
threshold. I kept his idea and put it in my list. I just have not
found the time to implement it yet.

I think this ioctl could suit your needs because it could work for
both input and output asynchronous subdevices.

If you want to implement it, you are more than welcome. Or else, I am
currently finishing something D. Nicolodi proposed a few month ago and
I will implement just after (the counting subdevices will wait a
little bit more).

At first sight, I think this task should be feasible quite quickly;
the poll ioctl handler just has to be rewritten.

> 
>   I am running your latest Analogy branch.
Be careful, the wf_* tools are not complete.

> 
>   I was just wondering whether my observations are correct, and that it makes sense to develop more communication code by using this behavior of Analogy.
> 
> Best wishes, and Happy Holidays!
> 
> -Stefan
> 
> 
> 
>    

-- 
Alexis.

