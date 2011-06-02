Date: Thu, 2 Jun 2011 22:00:12 +0200
From: Alexis Berlemont <alexis.berlemont@domain.hid>
Message-ID: <20110602200012.GB2772@domain.hid>
References: <897759.67778.qm@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <897759.67778.qm@domain.hid>
Subject: Re: [Xenomai-help] Analogy simultaneous read write commands
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jules Warsh <juleswarsh@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,

Once more, sorry for the late reply.

Jules Warsh wrote:
> Hello,
> 
> Is it possible to:
> - Set a command (a4l_snd_command) to read data from an Analogy subdevice,
> - Set a command (a4l_snd_command) to write data to a different Analogy subdevice,
> - Trigger both commands, and

Yes. It is possible

With one file descriptor (an a4l_desc_t to be more precise):
 - you can launch many synchronous acquisitions (instruction) on many
   subdevices.
 - you can launch only one asynchronous acquisition (command) on any
   subdevice (the asynchronous buffer is instanciated with the
   creation of the file descriptor)

So, all you have to do is open as many file descriptor on the same
analogy device (let's say analogy0) as the number of simultaneous
acquisitions you want to trigger.

> 
> - Collect/write data from/to buffers ?

Yes. If you have opened two file descriptors, you will read on one fd
(with a4l_async_read()) and write on the other one (with
a4l_async_write()).

> 
> 
> Or whatever other actions to implement the same functionality above?
> 
> Thank you.

> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help


-- 
Alexis.

