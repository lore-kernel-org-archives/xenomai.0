Message-ID: <5084F364.20404@grandegger.com>
Date: Mon, 22 Oct 2012 09:19:00 +0200
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
References: <50843CB3.6040406@uqconnect.edu.au>
In-Reply-To: <50843CB3.6040406@uqconnect.edu.au>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Drivers for 4-channel CAN or EtherCAT
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: david.butterworth@uqconnect.edu.au
Cc: xenomai@xenomai.org

On 10/21/2012 08:19 PM, David Butterworth wrote:
> Hi all,
> 
> Is anyone working on drivers for a 4-channel CAN card?  and what
> EtherCAT drivers are currently available?

I never heard of EtherCAT with CAN? It normally uses Ethernet network
devices. Or have I missed something?

> We're talking about using such hardware, so I might need to have a go
> myself...
> 
> I am assuming that Peak's Linux driver (non real-time) works with their
> 4 channel card.

Me too.

> Is there some problem that has prevented all 4 channels being supported
> in the current Xenomai peak-pci driver?

Not that I know of, apart from the missing code (so far the RTcan
"peak_pci" driver only supports up to 2 channels).

Wolfgang.

