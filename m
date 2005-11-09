Message-ID: <43723BF0.3000207@domain.hid>
Date: Wed, 09 Nov 2005 19:12:00 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] RT pipes
References: <Pine.GSO.4.58.0511091817070.29250@domain.hid>
In-Reply-To: <Pine.GSO.4.58.0511091817070.29250@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Sebastian Smolorz <Sebastian.Smolorz@domain.hid>
Cc: xenomai@xenomai.org

Sebastian Smolorz wrote:
> Hi,
> 
> I've spotted a -- in my view -- strange behaviour of RT pipes in the
> native skin. The scenario is as follows:
> 
> A RT task creates a RT pipe and writes some bytes into it. A NRT
> counterpart reads from this pipe, but not all bytes. Afterwards, the RT
> task deletes the pipe.
> 
> Now the program is re-run: RT task creates the pipe, writes some bytes,
> and the NRT part reads some bytes, but begins with the old ones which
> weren't read during the first run of the program.
> 
> Now my question: Is this behaviour intentional?

Nope.

  If it is then I see the
> following problem: A task which calls rt_pipe_create() cannot be sure that
> the pipe is empty. So it should be able to clear the pipe before use but I
> found no function that allows a RT task to clear the pipe.
> 

ioctl(fd,XNPIPEIOC_FLUSH,0) would do, but still, we should clear the output 
queue when closing the kernel side. In the same vein, closing the user-space 
side does not clear the input queue that feeds the kernel side. Thanks for 
spotting this.

> 
> Sebastian
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core
> 


-- 

Philippe.

