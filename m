Message-ID: <4C1F2AE4.6030304@domain.hid>
Date: Mon, 21 Jun 2010 11:03:32 +0200
From: Daniele Nicolodi <daniele@domain.hid>
MIME-Version: 1.0
References: <4C093C93.4000907@domain.hid>
	<4C0CEC7E.6080408@domain.hid>	<4C0CF99F.1090700@domain.hid>
	<4C19E5C8.8070802@domain.hid>
In-Reply-To: <4C19E5C8.8070802@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] [comedi] NI 6251 "wrong" samples
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: comedi_list@domain.hid
Cc: xenomai@xenomai.org

On 17/06/10 11:07, Daniele Nicolodi wrote:
> No. I'm running a continuous memory mapped acquisition. The only maybe
> uncommon thing I'm doing is that I'm reading the mmapped buffer in fixed
> chunks, rather than reading all the samples available each time. The
> number of samples I read each time is larger than the 4095 samples after
> which the hardware sends the FIFO half full trigger event.

I modified my code from a loop like:

unsigned int required = <compute required number of bytes>;
unsigned int read = 0;
void * buffer = a4l_mmap(dsc, ...);
while (1) {
  while (read < required) {
    read = a4l_pool(...);
    clock_nanosleep(...);
  }
  process(buffer, ...);
  a4l_buff_markrw(dsc, subdevice, required, ...);
}

to something like:

unsigned int required = <compute required number of bytes>;
unsigned int read = 0;
void *buffer = malloc(required);
while (1) {
  while (read < required) {
    a4l_sys_read(dsc, buffer + read, required - read);
  }
  process(buffer, ...);
}

I tested this setup over the weekend and the wrong samples went away!

Therefore i suspect that the problem is not related to FIFO
synchronization but to kernel space buffer handling.

I have tried to look at Analogy buffer handling, but the lack of any
comment in the source code makes understanding how it is supposed to
work a complex task.

Alexis, can you see any case where there may be a synchronization issue
like the one I'm seeing in your code? Any suggestion in where to look
for the bug?

Thanks. Cheers,
-- 
Daniele

