References: <79A9E4882C44D44FA53B5AB15E619801260C7E3E@ADEERL01SMS001.cznet.zeiss.org>
From: Jorge Ramirez Ortiz <jro@xenomai.org>
Message-ID: <569E2DAF.4010203@xenomai.org>
Date: Tue, 19 Jan 2016 07:35:59 -0500
MIME-Version: 1.0
In-Reply-To: <79A9E4882C44D44FA53B5AB15E619801260C7E3E@ADEERL01SMS001.cznet.zeiss.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Analogy and PCI-6289 issue
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org, alexandre.lopes.ext@zeiss.com

On 01/15/2016 06:30 AM, Lopes, Alexandre wrote:
> analogy_config: a4l_attach(analogy_ni_pcimio) failed err=-1
> analogy_config: check the procfs information:
>  - analogy devices: /proc/analogy/devices
>  - analogy drivers: /proc/analogy/drivers
>  
> and in dmesg
>  
> [1792.306659] Analogy: a4l_assign_driver: call(drv->attach) failed (ret=-2)
> 
> I have already tried to swap pci slots, to use only one card, to omit the driver parameters
> etc. and the end result is always the same: I can attach the driver to the 6713 but not to
> the 6289.
> 
> Could anyone help me shed some light on the issue?


please check

http://git.xenomai.org/xenomai-3.git/tree/kernel/drivers/analogy/national_instruments/pcimio.c#n1055

support for the 6289 (ie 0x70ac) is in the todo list - disabled by the
conditional compilation statement.
since you have the hw, you could enable it and try to get it to work: it
shouldnt be too hard (I dislocated my shoulder last week so Icant provide much
coding support at the moment..maybe in a couple of weeks)


-- 
jro

