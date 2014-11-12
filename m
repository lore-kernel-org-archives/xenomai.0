From: Paul <paul_c@tuxcnc.org>
Date: Wed, 12 Nov 2014 12:25:22 +0000
References: <CAKKWdtdaDJkSOhS7WaiRo5t0+NnCSV4-DQJcFB3iYOPGZ=z-Gg@mail.gmail.com>
In-Reply-To: <CAKKWdtdaDJkSOhS7WaiRo5t0+NnCSV4-DQJcFB3iYOPGZ=z-Gg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <201411121225.22847.paul_c@tuxcnc.org>
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

On Wednesday 12 November 2014, ali hagigat wrote:
> I am trying to setup a real time system by a x86-32bits-intel-core 2
> quad computer and Xenomai. I need a DAC card (data acquisition card
> for making analog/digital signals/pulses) probably plugged into PCI
> bus and also a CAN controller, again plugged into PCI bus to send
> some reports to another. (is there any other way besides PCI bus?) I
> wonder if anybody can direct me what hardware i can buy to work
> probably. I need the name of the boards and their distributors and
> their related links.

What conversion speeds do you need for ADC/DAC ?
How many channels ?
Are you willing/able to write drivers for unsupported hardware ?
Do you have a sizable budget ?

A starting point for a moderately slow PCI analogue/digital acquisition 
card that has support under the Xenomai analogy framework is 
http://www.sensoray.com/products/626.htm




