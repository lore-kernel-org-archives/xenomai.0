Message-ID: <4EE20EA4.6080305@domain.hid>
Date: Fri, 09 Dec 2011 14:35:32 +0100
From: Anders Blomdell <anders.blomdell@domain.hid>
MIME-Version: 1.0
References: <4ED66FD7.4010403@domain.hid>
In-Reply-To: <4ED66FD7.4010403@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Analogy/mite
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 11/30/2011 07:03 PM, Anders Blomdell wrote:
> Hi, just found that
>
> echo 0000:06:01.0 > /sys/bus/pci/drivers/analogy_mite/unbind
>
> does not do the same thing as
>
> analogy_config -r analogyN
>
> in fact it leaves the system in a state where using the driver results
> in a kernel OOPS.
>
> Will try to look into it further tomorrow...
Well, took quite some time to track down the 'analogy_config -r' bug 
(which was responsible for the kernel OOPS [i.e. after fixing it I have 
not got any OOPSes]).

So back to the original problem, does anybody foresee that a call to 
a4l_ioctl_devcfg(cxt, NULL) from the mite driver would give any problems 
(apart from getting the context pointer from the data structures the 
mite driver has handy)? It is probably not kosher to do ioctl on a 
driver that is not open, but...

/Anders

-- 
Anders Blomdell                  Email: anders.blomdell@domain.hid
Department of Automatic Control
Lund University                  Phone:    +46 46 222 4625
P.O. Box 118                     Fax:      +46 46 138118
SE-221 00 Lund, Sweden


