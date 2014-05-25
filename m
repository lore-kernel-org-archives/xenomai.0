References: <CAJX3k=V+ns3H49G+5HuoMjv6+16yeRLXzr=D6dryyQiuVoQ_dA@mail.gmail.com>
 <oq8uprt339.fsf@merlin.sez.to>
 <CAJX3k=X=SOD3P503WM226Qf9VLzMLrRC_3R91DYsBtkwLY5wVA@mail.gmail.com>
From: Paul Janzen <pcj@xenomai.sez.to>
Date: Sat, 24 May 2014 18:46:22 -0700
In-Reply-To: <CAJX3k=X=SOD3P503WM226Qf9VLzMLrRC_3R91DYsBtkwLY5wVA@mail.gmail.com> (Manu S.
 Madhav's message of "Sat, 24 May 2014 16:22:14 -0400")
Message-ID: <oq38fytytt.fsf@merlin.sez.to>
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

> One more question: Is anyone aware of an analogy implementation for
> using the DAQ counter for quadrature encoding? E.g. by using the
> A4L_INSN_CONFIG_GPCT_QUADRATURE_ENCODER instruction.

I know it works in Comedi, but have not tried it in Analogy.  You may
have to snarf some bit definitions from comedi.

Try INSN_CONFIG, with two data
{ A4L_INSN_CONFIG_SET_COUNTER_MODE, 
  NI_GPCT_COUNTING_MODE_QUADRATURE_X4_BITS |
    NI_GPCT_COUNTING_DIRECTION_HW_UP_DOWN_BITS
}

and then again to arm the counter:
{ A4L_INSN_CONFIG_ARM, NI_GPCT_ARM_IMMEDIATE }

Then you should be able to get the counter value back with
a4l_sync_read. 

A4L_INSN_CONFIG_GPCT_QUADRATURE_ENCODER appears to be a half-baked
sensoray only thing. 

-- Paul

