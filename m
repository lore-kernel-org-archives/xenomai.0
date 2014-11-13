Message-ID: <54650689.8020005@xenomai.org>
Date: Thu, 13 Nov 2014 14:29:13 -0500
From: Jorge Ramirez Ortiz <jro@xenomai.org>
MIME-Version: 1.0
References: <CAKKWdtdaDJkSOhS7WaiRo5t0+NnCSV4-DQJcFB3iYOPGZ=z-Gg@mail.gmail.com>
 <201411121225.22847.paul_c@tuxcnc.org>
In-Reply-To: <201411121225.22847.paul_c@tuxcnc.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] DAC and CAN
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 11/12/2014 07:25 AM, Paul wrote:
> On Wednesday 12 November 2014, ali hagigat wrote:
>> I am trying to setup a real time system by a x86-32bits-intel-core 2
>> quad computer and Xenomai. I need a DAC card (data acquisition card
>> for making analog/digital signals/pulses) probably plugged into PCI
>> bus and also a CAN controller, again plugged into PCI bus to send
>> some reports to another. (is there any other way besides PCI bus?) I
>> wonder if anybody can direct me what hardware i can buy to work
>> probably. I need the name of the boards and their distributors and
>> their related links.
> 
> What conversion speeds do you need for ADC/DAC ?
> How many channels ?
> Are you willing/able to write drivers for unsupported hardware ?
> Do you have a sizable budget ?
> 
> A starting point for a moderately slow PCI analogue/digital acquisition 
> card that has support under the Xenomai analogy framework is 
> http://www.sensoray.com/products/626.htm

Support for 626 has not been delivered yet (will be done soon) - there is support for
s526.
If you need software calibration support on Xenomai you could use NI M-6221

http://sine.ni.com/nips/cds/view/p/lang/en/nid/14132

I have seen some of these cards on ebay reasonably priced.

> 
> 
> 
> 
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> http://www.xenomai.org/mailman/listinfo/xenomai
> 

- -- 
jro
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAEBAgAGBQJUZQaJAAoJECDcy2IJkagRssUH/iUlRDbnC+zp0+DrYfIh5yes
rW2BVYBJULJu/a0ZC1plqsp+C9THoSlRcFbzYOComm1r1zQM50vlsi623ad7G0G9
kAUFyp964y0x3EqCQLv6xLrvFmhRBMrI5u6joDXOuZZ1Z5hJHsK21HeVjGnbnT+7
adzNZ5XrlqmBrGH5HukqvlNge2rf2hk7dw7tdp+c1rW09DxviT1PFFM5t52lEm2s
xZYP4tNvMl4QpRhavFvkHRcCi3vQ+SOKI774LuCPDPmBUkD16aJMH9C7Bf75cq2u
IbAArp6cYYYIJLlpt1aGPx2Y2G/lRDdZSPHDfVdjWGfGHYn0Quz+wcCrC8ZgrTs=
=JwVV
-----END PGP SIGNATURE-----

