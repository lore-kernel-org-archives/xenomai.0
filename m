Date: Mon, 10 Jan 2011 23:56:01 +0100
From: Alexis Berlemont <alexis.berlemont@domain.hid>
Message-ID: <20110110225600.GA2830@domain.hid>
References: <5BF14D57-91E2-4365-9965-FDBC8806F754@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5BF14D57-91E2-4365-9965-FDBC8806F754@domain.hid>
Subject: Re: [Xenomai-core] CMD based acquisition with Analogy
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Stefan Schaal <sschaal@domain.hid>
Cc: Peter Pastor Sampedro <pastorsa@domain.hid>, xenomai@xenomai.org

Hi,

Stefan Schaal wrote:
> Hi Alexis,
> 
>   here is an observation with CMD-based acquisition that puzzles
>   me. Just to recall, we use an NI6259 board, using your latest
>   analogy branch of xenomai on a 2.6.29.5 kernel in Ubuntu 9.10. Our
>   computer is a 32bit Dell Precision with 8 core Xeon processors. 
> 
>  A normal CMD based acquisition with internal trigger has the core
>  elements as listed below. What puzzles me that it appears from my
>  tests that the triggering of the acquisition with
>  "a4l_snd_insn(&desc, &insn)" seems to take about 200-300 us to
>  complete. This is a very long time for us, as we need to start and
>  stop a CMD based acquisition multiple times in our code. 
> 
> Thus, my question is simply whether this long latency is normal from
> your experience? I used other a4l_snd_insn commands for INSN based
> data acquisition before (and I believe your "sync" data acquisition
> uses INSN, too), but always had 3-5us duration for these commands. 
> 

Just on testing purpose, if you replace the NI driver with the
analogy_fake driver, I think you will be unable to reproduce such high
latencies... 

The latencies you have noticed are waiting periods during which the CPU
has to wait for DMA buffer to be (half-)filled before triggering the
output acquisition. That's a way to prevent buffer underflow.

As you may know, the NI driver was ported from Comedi; I have noticed
this issue but did not fix it yet. In a nice world, the CPU should be
notified, thanks to an interrupt, when the DMA FIFO is in the suitable
state. Unfortunately, I remember this alternative was not
possible. The best I can do is to use an RTDM task so as to
asynchronously wait for the event. 

> Best wishes,
> 
> -Stefan
> 
> //====================================================================================
> 
> // fill out data structures
>   a4l_cmd_t cmd = {
>     .idx_subd = ID_SUBDEV_DIGITAL,
>     .flags = 0,
>     .start_src = TRIG_INT,    // internal trigger
>     .start_arg = 0,
>     .scan_begin_src = TRIG_EXT,   
>     .scan_begin_arg = NI_CDIO_SCAN_BEGIN_SRC_G0_OUT, // channel used to trigger the scans
>     .convert_src = TRIG_NOW,
>     .convert_arg = 0, /* in ns */
>     .scan_end_src = TRIG_COUNT,
>     .scan_end_arg = 32,
>     .stop_src = TRIG_NONE,
>     .stop_arg = 0,
>     .nb_chan = 32,
>     .chan_descs = chans,
>   };
> 
>   a4l_insn_t insn = {
>     .type = A4L_INSN_INTTRIG,
>     .idx_subd = ID_SUBDEV_DIGITAL,
>     .data_size = 0,
>   };
> 
> // send command
>  rc = a4l_snd_command(&desc, &cmd);
> if (rc < 0) 
>     printf("ni_test: a4l_snd_command failed (ret=%d)\n", rc);
>  }
> 
> // add some date to FIFO buffer 
> ....
> 
> // trigger acquisition
> rc = a4l_snd_insn(&desc, &insn);
> if (rc < 0)
>     printf("ni_test: triggering failed (rc=%d)\n",rc);
> 
> //====================================================================================

-- 
Alexis.

