Message-ID: <44508610.8090103@domain.hid>
Date: Thu, 27 Apr 2006 10:51:28 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Xen/Xenomai
References: <FDBBB5CC70676540B3EF7CFE83FD94E0210DD1@domain.hid>
In-Reply-To: <FDBBB5CC70676540B3EF7CFE83FD94E0210DD1@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: ROSSIER Daniel <Daniel.Rossier@domain.hid>
Cc: xenomai@xenomai.org

ROSSIER Daniel wrote:
> Hi All,
> 
>  
> 
> Is there any relationship between Xenomai and the Xen virtualization 
> monitor(http://www.cl.cam.ac.uk/Research/SRG/netos/xen/)?
> 

None, except that both provide virtualization services, but on a 
different scale.

>  
> 
> Would it make sense to port (or to integrate) Xenomai in such virtual 
> environment? (the notion of a Xenomai domain might correspond to a 
> virtual machine).
> 

Running Xenomai in a Xen domain aside of Linux should be possible 
without much trouble by connecting the HAL to the hypervisor, I think. 
Maybe another option would be to keep Xenomai as a Linux sub-system like 
now, but use Xen's paravirtualization to provide what's currently 
obtained from Adeos.

IIRC, people at Sombrio Systems are working on providing RTOS 
virtualization services on top of either Xen or Xenomai for embedded 
systems: http://www.linuxdevices.com/news/NS3509840836.html.

-- 

Philippe.

