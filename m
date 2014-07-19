Message-ID: <53CA82C0.8060907@xenomai.org>
Date: Sat, 19 Jul 2014 10:37:52 -0400
From: Jorge Ramirez Ortiz <jro@xenomai.org>
MIME-Version: 1.0
References: <83E500F4-2D9E-4853-B6FD-FCFBDC0050E8@gatech.edu>
In-Reply-To: <83E500F4-2D9E-4853-B6FD-FCFBDC0050E8@gatech.edu>
Content-Type: text/plain; charset="windows-1252"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] NI PCIe-1433
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

On 07/18/2014 01:06 PM, Yogi A. Patel wrote:
> Hi -
>
> We=92re interested in using the NI PCIe-1433 to capture data from a camer=
a and pull into our software.
>
> Has anyone used Analogy to control one of these cards?
>
> Yogi

Hi Yogi

wouldnt this hardware fit better under a V4L2 driver? I am not familiar wit=
h this=20
particular model but I'd assume you'll be capturing video frames at some gi=
ven fps so=20
you'll need to queue a number of dma'able buffers to handle those transfers=
? I wonder=20
if this device has an MMU to map the buffer pages so transfers happen under=
 the hood.=20
I couldnt find any documents about the device's internals anywhere so I am =
not sure=20
how could we drive this development.


> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> http://www.xenomai.org/mailman/listinfo/xenomai
>


--=20
jro


