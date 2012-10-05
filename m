From: Wayne Warren <wwarren@emacinc.com>
In-Reply-To: <506E9510.7090105@xenomai.org>
References: <1349212116.21898.108.camel@ENG-09-LX.emacinc.com>
	<506B5D6B.80005@xenomai.org> <506B5E0E.5050900@xenomai.org>
	<1349369822.3775.107.camel@ENG-09-LX.emacinc.com>
	<506DC2DA.5000105@xenomai.org>  <506E9510.7090105@xenomai.org>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 05 Oct 2012 13:47:38 -0500
Message-ID: <1349462858.26881.43.camel@ENG-09-LX.emacinc.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Adeos I-Pipe patch problem on vendor-specific kernel
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Cool,

First off, thanks again for the help and...my wiki account does not seem
to have edit privileges on the page I was referring to in my previous
e-mail.

Second, I have confirmed that the TI code we originally modified for our
product does boot. However! Whenever I pass in
"earlyprink=ttyO2,115200n8" the kernel seems to hang. Adding this
parameter seems to be the only difference between the kernel that boots
properly and the one that does not in this branch. 

I am fairly certain the kernel is not booting because if it was booting
I would see communication with the network filesystem I am booting into
when I run "tcpdump -n -i <interface> | grep <dhcp_ip_address>" on my
development PC which is connected to the same subnet. I know the IP
address assigned will be the same as what it acquires in U-boot because
the IP address lease time on our server is set to 10 minutes and
whenever it boots correctly without the earlyprintk parameter, it
retains this ip address.

I read Documentation/kernel-parameters.txt and saw that only ttyS0 and
ttyS1 are supported, but these names do not correspond to the device
names normally assigned by whatever serial driver is in use. Plus, the
documentation seems to suggest that earlyprintk is not supported for ARM
processors.

I also tried just using printascii() as described in the older version
of the ArmPorting page--no luck there.

Wayne Warren

On Fri, 2012-10-05 at 10:06 +0200, Gilles Chanteperdrix wrote:
> On 10/04/2012 07:09 PM, Gilles Chanteperdrix wrote:
> >> Also, if I could get an account on the Xenomai wiki, there are some simple
> >> changes I would make to the ArmPorting page to improve its readability a
> >> little (for example, create indented paragraphs for the description of
> >> the "struct ipipe_timer" members). I guess I don't really have anything
> >> concrete or technical to add to it so if you don't want to add me, I
> >> understand.
> > 
> > Done, you should have received a mail with your password.
> 
> By the way, if you feel like correcting my frenglish, I will not be vexed.
> 


