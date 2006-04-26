From: Romain Lenglet <rlenglet@domain.hid>
Subject: Re: [Xenomai-core] Xen/Xenomai
Date: Wed, 26 Apr 2006 18:57:03 +0900
References: <FDBBB5CC70676540B3EF7CFE83FD94E0210DD1@domain.hid>
In-Reply-To: <FDBBB5CC70676540B3EF7CFE83FD94E0210DD1@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604261857.03441.rlenglet@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org
Cc: ROSSIER Daniel <Daniel.Rossier@domain.hid>

> Is there any relationship between Xenomai and the Xen
> virtualization
> monitor(http://www.cl.cam.ac.uk/Research/SRG/netos/xen/)?
>
> Would it make sense to port (or to integrate) Xenomai in such
> virtual environment? (the notion of a Xenomai domain might
> correspond to a virtual machine).

I would rather say that both are means to create domains (in the 
general sense of the term, cf. ISO RM-ODP), but of a different 
nature. In Xenomai objects in domains are tasks, in Xen objects 
are operating systems / virtual machines. IMHO, I don't see how 
they could fit together.

-- 
Romain LENGLET

