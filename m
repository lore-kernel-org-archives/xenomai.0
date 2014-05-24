MIME-Version: 1.0
In-Reply-To: <oq8uprt339.fsf@merlin.sez.to>
References: <CAJX3k=V+ns3H49G+5HuoMjv6+16yeRLXzr=D6dryyQiuVoQ_dA@mail.gmail.com>
 <oq8uprt339.fsf@merlin.sez.to>
From: Manu S Madhav <manusmad@gmail.com>
Date: Sat, 24 May 2014 16:22:14 -0400
Message-ID: <CAJX3k=X=SOD3P503WM226Qf9VLzMLrRC_3R91DYsBtkwLY5wVA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] Troubleshooting Analogy DIO
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Paul Janzen <pcj@xenomai.sez.to>
Cc: xenomai@xenomai.org

Thank you, Paul,

I was under the impression that a4l_config_subd was used for asynchronous
instructions only. DIO is up and running now - thank you!

One more question: Is anyone aware of an analogy implementation for using
the DAQ counter for quadrature encoding? E.g. by using the
A4L_INSN_CONFIG_GPCT_QUADRATURE_ENCODER
instruction. I saw a couple of threads where someone successfully armed the
counter, but was unable to read information from it. I am going to try and
implement it this weekend, just wondering if there is already a working
solution.

Gilles: I will upgrade to the newest version of Xenomai. Thank you for your
suggestion.

---
Manu Madhav


On Sat, May 24, 2014 at 2:59 PM, Paul Janzen <pcj@xenomai.sez.to> wrote:

> Manu S Madhav <manusmad@gmail.com> writes:
>
> > Using Analogy, and with a bit of reading, I was able to get analog input
> > and output up and running without too much trouble, but digital I/O is
> > completely evading me. I am just trying to turn on all digital outputs
> to 1
> > using synchronous instruction to the DIO subdevice (#2, in my case). Size
> > of the subdevice is 4 (32 bits).
>
> Before writing to the DIO device, you have to configure each line that
> you want to be a digital output as an output, otherwise it stays a
> digital input:
>
> for (i=0; i<num_channels; i++) {
>     err = a4l_config_subd(dsc, subd_DIO, A4L_INSN_CONFIG_DIO_OUTPUT, i);
>     if (err < 0) [...]
> }
>
> -- Paul
>
>
>
>
>
