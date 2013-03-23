MIME-Version: 1.0
In-Reply-To: 
References: 
From: mfornero@aanddtech.com
Message-ID: <OFFC519FEC.3D6ECA30-ON85257B37.00588608-85257B37.0058860B@aanddtech.com>
Date: Sat, 23 Mar 2013 12:06:54 -0400
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=ISO-8859-1
Subject: [Xenomai] (no subject)
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

>> Is there a new ADEOS patch for ARM in the works ? I am interested to know
>> what kernel version is targeted if that decision has been made.

>3.8. It currently works on at91s, but not yet on omap. We will probably
>need to run tests on the imxs, as a lot of things have changed between
>3.5 and 3.8.

Hi Gilles,

Is there a public git tree with this work-in-progress? I couldn't pinpoint =
a=20
specific one on git.xenomai.org or git.denx.de that was ARM/3.8 based

The Xilinx -next tree for Zynq looks like it's based on 3.8, so a 3.8 ipipe=
 would
likely be much easier for me than attempting to back port all of the import=
ant patches.

On a related note, is there something I can do to help prevent the Zynq ipi=
pe port from
bit-rotting? Even in 3.8, mainline is still missing a lot of the necessary =
code for Zynq,
so I assume I'd need a pre- and post- patch. Could you elaborate on what th=
ese would entail?

Best Regards,

Matt


