References: <CAJX3k=V+ns3H49G+5HuoMjv6+16yeRLXzr=D6dryyQiuVoQ_dA@mail.gmail.com>
From: Paul Janzen <pcj@xenomai.sez.to>
Date: Sat, 24 May 2014 11:59:38 -0700
In-Reply-To: <CAJX3k=V+ns3H49G+5HuoMjv6+16yeRLXzr=D6dryyQiuVoQ_dA@mail.gmail.com> (Manu S.
 Madhav's message of "Fri, 23 May 2014 17:43:51 -0400")
Message-ID: <oq8uprt339.fsf@merlin.sez.to>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: Re: [Xenomai] Troubleshooting Analogy DIO
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Manu S Madhav <manusmad@gmail.com>
Cc: xenomai@xenomai.org

Manu S Madhav <manusmad@gmail.com> writes:

> Using Analogy, and with a bit of reading, I was able to get analog input
> and output up and running without too much trouble, but digital I/O is
> completely evading me. I am just trying to turn on all digital outputs to 1
> using synchronous instruction to the DIO subdevice (#2, in my case). Size
> of the subdevice is 4 (32 bits).

Before writing to the DIO device, you have to configure each line that
you want to be a digital output as an output, otherwise it stays a
digital input:

for (i=0; i<num_channels; i++) {
    err = a4l_config_subd(dsc, subd_DIO, A4L_INSN_CONFIG_DIO_OUTPUT, i);
    if (err < 0) [...]
}

-- Paul





