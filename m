Message-ID: <48D3D3A9.5030504@domain.hid>
Date: Fri, 19 Sep 2008 18:30:33 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <48D3A531.6090302@domain.hid>
In-Reply-To: <48D3A531.6090302@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Scilab/Scicos code generator for Xenomai
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Claudio Scordino <claudio@domain.hid>
Cc: simone.mannori@domain.hid, xenomai@xenomai.org, Roberto Bucher <roberto.bucher@domain.hid>, paolo gai <pj@domain.hid>, bruno@domain.hid

Claudio Scordino wrote:
> Dear all,
> 
> My name is Claudio Scordino from Evidence 
> (http://www.evidence.eu.com). In collaboration with the Scilab Group 
> Digiteo (previously INRIA Roquencourt), and SUPSI Lugano, we developed 
> a software integration between the following software packages:
> 
> - the Xenomai environment with the POSIX skin
> - the Scilab/Scicos code generator
> - a modified version of CANFestival
> 
> The result is now that we can use the Scilab/Scicos code generator to 
> automatically generate application code for Xenomai!

Cool.

> 
> We believe that this opens new possibilities for the usage of Xenomai 
> in industrial applications, especially when these tools are used to 
> implement control algorithms, fast prototyping systems and hardware in 
> the loop simulations... all made using free open source tools!

Even cooler. ;)

> 
> We also developed a set of custom Scicos blocks that integrates with 
> CANFestival for sending CANopen commands to control remote I/Os 
> peripherals. These blocks can be inserted inside Scicos designs, and 
> the generated code will control directly the remote peripheral.

I browsed your pages a few days ago and found some CAN driver patch.
Maybe you want to submit a polished :) version for inclusion into
mainline - so that your users don't have to patch Xenomai for this.

> 
> In addition, we implemented a set of blocks which make available a UDP 
> connection to exchange data between the Xenomai target and a Scilab 
> simulation running on the PC. This allows, for example, remote display 
> of data, as well as communication and data exhange for hardware in the 
> loop, monitoring and remote control.
> 
> If interested, the following links contain some description of the 
> project, as well as source code to download, and a wiki page with 
> installing instructions.
> 
> - http://www.evidence.eu.com/content/view/301/388/ - Xenomai and 
> Scilab/Scicos for Industrial COTS PC and remote CANopen I/O
> 
> - http://www.evidence.eu.com/content/view/175/216 - Scilab/Scicos code 
> generator for FLEX and Xenomai
> 
> We added these links to our Wiki too in the "Embedded Linux" section.

I think a link from the Xenomai wiki to your project would be
appropriate as well.

BTW, did you already have a look at the recently merged COMEDI-over-RTDM
framework (2.5-SVN)? Do you plan to add support for it as well?

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

