Message-ID: <45B7D0A7.3070904@domain.hid>
Date: Wed, 24 Jan 2007 22:33:27 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Patching latest Denx 2.4.25-devel kernel with
	xenomai-2.3.0 fails
References: <DD39B5C3F4963040ADC9768BE7E430CB0198DD4D@is-hdq-exchange.marel.net>
In-Reply-To: <DD39B5C3F4963040ADC9768BE7E430CB0198DD4D@is-hdq-exchange.marel.net>
Content-Type: multipart/mixed; boundary="------------010808000605050004040108"
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Daniel Schnell <daniel.schnell@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

This is a multi-part message in MIME format.
--------------010808000605050004040108
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Daniel Schnell wrote:
> Wolfgang Grandegger wrote:
> 
>> I unable to reproduce your problem with a fresh linuxppc_2_4_devel
>> tree and xenomai-2.3.0. Could you please use the "--verbose" option
>> with prepare_kernel.sh and post the result.  
> 
> 
> Hmm, I used
> 
> make mrproper; git pull
> 
> to get the latest deltas from the repository. But maybe there is a saner
> way to do it ? I am pulling a fresh tree at the moment, but this will
> take quite a while according to the progress bar.
> 
> The output from the skript is
> 
> Preparing kernel 2.4.25 in
> /home/daniel/projects/mach4/linuxppc_2_4_devel-git-xenomai-2.3.0...
> Adeos found - bypassing patch.
> Adeos/ppc 1.2-01 installed.
> 
> And ? Is printed out on stderr.
> 
> 
> In the meanwhile I got the fresh linux kernel, the same happensn here.
> 
> I pulled it via
> 
> git clone git://www.denx.de/git/linuxppc_2_4_devel.git
> linuxppc_2_4_devel-git-xenomai-2.3.0

The problem is with the attached code snippet. It works under FC4 but 
not under FC6, as I just realized. Still puzzled...

Wolfgang.


--------------010808000605050004040108
Content-Type: text/plain;
 name="test_ed"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="test_ed"

#!/bin/bash
ed -s Makefile <<EOF
/DRIVERS := \$(DRIVERS-y)
^r Modules.frag

.
wq
EOF

--------------010808000605050004040108--

