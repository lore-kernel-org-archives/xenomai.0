Message-ID: <530D0B10.9000502@xenomai.org>
Date: Tue, 25 Feb 2014 22:28:48 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAEbDrgkifqMcqqEqh5hKA90YzFzcyDxLHFC79F8CWvZi5heyWQ@mail.gmail.com>
 <CAK4EZFRN56pZkzmYwBpyupYkbj+V1mgYUPHk4YfLshSs-zFGGw@mail.gmail.com>
 <CAK4EZFTRhDxJkRdY7epTqQ=f0rpoK570uJckq4aOYnt7z6fzxA@mail.gmail.com>
 <CAEbDrgkAqAGWrap1156fiQnLiuBJ_P6NUdxQQQRBiLkDEKRwGQ@mail.gmail.com>
 <530A8767.4030004@xenomai.org>
 <CAEbDrgmf+RtS5gS5SKO7eq66ge-LHoJ0hTOC=yeRmUgk0MXqog@mail.gmail.com>
 <530BC103.3010809@xenomai.org>
 <CAEbDrgnFr7YvfoMmFQx=PBKSFEWvwJftx0wZx39ySMqRO2X6gQ@mail.gmail.com>
 <530CFB0D.8040001@xenomai.org>
 <CAEbDrgkJCnbWu_J4svoXOU1x2rz=n95A5+3Ee=R_9CpMgx-JmA@mail.gmail.com>
 <530CFC27.5050700@xenomai.org>
 <CAEbDrgnmM_dD3WX42PYawhkW8zTaYczzfozEe1EX7Z5HnERz3g@mail.gmail.com>
 <530D0205.9050406@xenomai.org>
 <CAEbDrgmwch94crHAcrbJDj9MxaiBNaYeLH2U9NtS0tuJKmdDDw@mail.gmail.com>
 <530D0A0C.9040606@xenomai.org>
In-Reply-To: <530D0A0C.9040606@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] RaspberryPi kernel 3.8 issue
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gregory Dymarek <gregd72002@gmail.com>
Cc: xenomai@xenomai.org

On 02/25/2014 10:24 PM, Gilles Chanteperdrix wrote:
> On 02/25/2014 10:09 PM, Gregory Dymarek wrote:
>> So the frame freeze I got on my version is on line 145 in here:
>> https://github.com/raspberrypi/linux/blob/rpi-3.8.y/kernel/irq/handle.c
>>
>> The dwc_otg_hcd_handle_intr is here:
>> https://github.com/raspberrypi/linux/blob/rpi-3.8.y/drivers/usb/host/dwc_otg/dwc_otg_hcd_intr.c
>>
>>
>> Is the line 523 the problem?
>>     local_fiq_enable();
> 
> No, local_fiq_enable is not visible in the trace. I would say the
> problem is after line 546.	

Sorry, yes, the problem is local_fiq_disable / local_fiq_enable.

-- 
                                                                Gilles.

