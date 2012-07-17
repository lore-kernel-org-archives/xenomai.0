Message-ID: <50057E14.3080904@grandegger.com>
Date: Tue, 17 Jul 2012 17:00:36 +0200
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
References: <4F534D1A615F544D95E57BFD8460658301CBE3D1@GEO-HCLT-UKEVS1.GEO.CORP.HCL.IN>
In-Reply-To: <4F534D1A615F544D95E57BFD8460658301CBE3D1@GEO-HCLT-UKEVS1.GEO.CORP.HCL.IN>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Edge interrupts on PCI drivers
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Jorge Ramirez Ortiz, HCL Europe" <Jorge.Ramirez-Ortiz@hcl.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 07/17/2012 04:57 PM, Jorge Ramirez Ortiz, HCL Europe wrote:
> Typical PCI devices have many sources of interrupts (some level, some edge triggered) normally all routed through PIN A.

AFAIC, PCI interrupts are *always* level sensitive.

> When writing an RTDM pci driver for one of these devices, how does the microkernel manage the edge interrupts? 
> 
> I am looking at some traces where the CPU seems to be interrupted continuously by an edge interrupt until the actual condition that causes it is cleared.

That's normal for level sensitive interrupt sources.

Wolfgang.

