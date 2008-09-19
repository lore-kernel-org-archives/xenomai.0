Message-ID: <48D3A7BA.5080505@domain.hid>
Date: Fri, 19 Sep 2008 15:23:06 +0200
From: Claudio Scordino <claudio@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Scilab/Scicos code generator for Xenomai
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
Cc: simone.mannori@domain.hid, Roberto Bucher <roberto.bucher@domain.hid>, paolo gai <pj@domain.hid>, bruno@domain.hid

Dear all,

My name is Claudio Scordino from Evidence
(http://www.evidence.eu.com). In collaboration with the Scilab Group
Digiteo (previously INRIA Roquencourt), and SUPSI Lugano, we developed
a software integration between the following software packages:

- the Xenomai environment with the POSIX skin
- the Scilab/Scicos code generator
- a modified version of CANFestival

The result is now that we can use the Scilab/Scicos code generator to
automatically generate application code for Xenomai!

We believe that this opens new possibilities for the usage of Xenomai
in industrial applications, especially when these tools are used to
implement control algorithms, fast prototyping systems and hardware in
the loop simulations... all made using free open source tools!

We also developed a set of custom Scicos blocks that integrates with
CANFestival for sending CANopen commands to control remote I/Os
peripherals. These blocks can be inserted inside Scicos designs, and
the generated code will control directly the remote peripheral.

In addition, we implemented a set of blocks which make available a UDP
connection to exchange data between the Xenomai target and a Scilab
simulation running on the PC. This allows, for example, remote display
of data, as well as communication and data exhange for hardware in the
loop, monitoring and remote control.

If interested, the following links contain some description of the
project, as well as source code to download, and a wiki page with
installing instructions.

- http://www.evidence.eu.com/content/view/301/388/ - Xenomai and
Scilab/Scicos for Industrial COTS PC and remote CANopen I/O

- http://www.evidence.eu.com/content/view/175/216 - Scilab/Scicos code
generator for FLEX and Xenomai

We added these links to our Wiki too in the "Embedded Linux" section.

Best regards,

             Claudio Scordino

-- 
Ing. Claudio Scordino		
Software Engineer, PhD
Tel. +39-050-5492050
http://retis.sssup.it/~scordino/

Evidence Srl
Embedded Real-Time Solutions
http://www.evidence.eu.com


