Date: Thu, 5 Nov 2015 22:33:37 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20151105213337.GD31487@hermes.click-hack.org>
References: <2396B4D2166B62479FBBE370D4A7C1F30A705D34@mb2010-3.intra.tut.fi>
 <20151103114717.GA26720@hermes.click-hack.org>
 <2396B4D2166B62479FBBE370D4A7C1F30A705DA6@mb2010-3.intra.tut.fi>
 <20151103144651.GC26720@hermes.click-hack.org>
 <2396B4D2166B62479FBBE370D4A7C1F30A705E86@mb2010-3.intra.tut.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2396B4D2166B62479FBBE370D4A7C1F30A705E86@mb2010-3.intra.tut.fi>
Subject: Re: [Xenomai] Pcap replay tool for xenomai
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Umair Ali <ali.umair@tut.fi>
Cc: Xenomai <xenomai@xenomai.org>

On Thu, Nov 05, 2015 at 03:17:45PM +0000, Umair Ali wrote:
> Hello Gilles, 
> 
> I have managed to install the xenomai on Ubuntu 13.04 (kernel
> 3.08).

Not sure what you mean with kernel 3.08 here, since you talk about
3.10 later on.

> The version of the xenomai is 3.0.1 and kernel version is
> 3.10.32. The following is the output after the reboot

RTnet requires I-pipe patch for kernel 3.14 or later.


> I have also observed that module 8139too is also running. As i am
> new to the linux so i want to make sure if i have installed the
> xenomai with rtnet correctly. Can you tell me is there a way i
> stop the 8139too module and make rt_8139too module as default
> driver for NIC.

Yes, you can unbind the device from the 8139too driver, then bind it
to rt_8139too, or start the rt_8139too module after unbinding from
8139too. To know how to manual bind/unbind devices from drivers,
see:
https://lwn.net/Articles/143397/


> And then use TCPreplay command such as "tcpreplayy
> --pps=4000 --intf1=eth0 stream.pcap" to play back the pcap file as
> we can do in the non real kernel.

As I already told you, the code is identical to send raw packets
with Linux and Xenomai, but the compilation is different. So, if
tcpreplay is not compiled for Xenomai, it will not use Xenomai APIs.
I suggest you start reading a bit about Xenomai to understand what
it does and how it works, starting from here:
http://xenomai.org/start-here/

-- 
					    Gilles.
https://click-hack.org

