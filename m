Message-ID: <50057E9C.8080508@siemens.com>
Date: Tue, 17 Jul 2012 17:02:52 +0200
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <4F534D1A615F544D95E57BFD8460658301CBE3D1@GEO-HCLT-UKEVS1.GEO.CORP.HCL.IN>
	<50057E14.3080904@grandegger.com>
In-Reply-To: <50057E14.3080904@grandegger.com>
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
To: Wolfgang Grandegger <wg@grandegger.com>, "Jorge Ramirez Ortiz, HCL Europe" <Jorge.Ramirez-Ortiz@hcl.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 2012-07-17 17:00, Wolfgang Grandegger wrote:
> On 07/17/2012 04:57 PM, Jorge Ramirez Ortiz, HCL Europe wrote:
>> Typical PCI devices have many sources of interrupts (some level, some edge triggered) normally all routed through PIN A.
> 
> AFAIC, PCI interrupts are *always* level sensitive.

More precisely, legacy INTx are level triggered, MSI/MSI-X interrupts
are edge. About which type are we talking here?

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SDP-DE
Corporate Competence Center Embedded Linux



