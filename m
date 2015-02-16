Date: Mon, 16 Feb 2015 14:44:11 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150216134411.GE1914@hermes.click-hack.org>
References: <OFBD514703.37474029-ONC1257DEE.0048DE4B-C1257DEE.004A4BE3@leica-geosystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OFBD514703.37474029-ONC1257DEE.0048DE4B-C1257DEE.004A4BE3@leica-geosystems.com>
Subject: Re: [Xenomai] Event handling, Xenomai: watchdog triggered
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Camera.Geomatics@leica-geosystems.com
Cc: xenomai@xenomai.org

On Mon, Feb 16, 2015 at 02:31:30PM +0100, Camera.Geomatics@leica-geosystems.com wrote:
> Hi,
> 
> I am testing HW interrupt latencies with an Altera Development board using 
> the 3.10 Kernel and 2.6 xenomai toggling a FPGA Pin. I have a RTDM Modul 
> handling the interrupt generated from a FPGA timer and a user Space real 
> time program.
> 
> To synchronize Interrupt handler and IOCTL function rt_event_wait and 
> rt_event_signal are used. 
> 
> When I run the program with 10kHz I get the message Xenomai: watchdog 
> triggered -- signaling runaway thread after several seconds. I get the 
> right signals for several seconds on my oszilloscope.
> 
> Is there a better way to synchronize irq and ioctl in a RTDM Modul?
> 
> When I disable the irq function and toggle the FPGA Pins via IOCTL 
> controlled from the user space task (rt_task_wait_period) a 10kHz 
> frequency is working.

Are you sure this is not an level vs edge irq issue ? For instance,
if the FPGA generates a square signal and the irq type is set to
level, the signal will remain asserted for as long as the FPGA keeps
the same level and the kernel will call the handler during all that
time.

-- 
					    Gilles.

