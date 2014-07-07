References: <9584EBE8-001C-41E7-88A1-3B4CF07DD567@gatech.edu>
 <oq7g3pvpk0.fsf@merlin.sez.to>
 <CA30A2D0-9D01-4C5C-AD6F-5B5FD75422C9@gatech.edu>
From: Paul Janzen <pcj@xenomai.sez.to>
Date: Sun, 06 Jul 2014 20:50:14 -0700
In-Reply-To: <CA30A2D0-9D01-4C5C-AD6F-5B5FD75422C9@gatech.edu> (Yogi A.
 Patel's message of "Sun, 6 Jul 2014 23:19:37 -0400")
Message-ID: <oq1ttxvnd5.fsf@merlin.sez.to>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: Re: [Xenomai] Analogy Reference Issue with NI PCIMIO
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Yogi A. Patel" <yapatel@gatech.edu>
Cc: xenomai@xenomai.org

"Yogi A. Patel" <yapatel@gatech.edu> writes:

> I am interfacing with the breakout box for the NI card.

This still does not tell me which terminals on the PCI card the
function generator is connected to.

For differential mode, to use channel 2, you'd need to connect the
positive pin to PCI-6259 connector 0 (on the left-hand side) pin 65
and the negative pin to pin 31 (AI 10).

For ground-referenced mode, you'd connect to 65 and any one of the
AI-GND terminals (pin 32 is nearby.)

For common-reference mode, you'd connect to 65 and AI-SENSE (pin 62).

> On a side note - I saw a variable called .calcdac in the analogy
> driver file. What is that variable for?

On E-series and earlier cards, NI used "calibration DAC's" in order to
correct for a few percent of offset and gain error in the AI and AO
circuits.  On M-series cards, these functions are done in software.
".caldac" is just Analogy's way of tracking what cards have what
calibration DAC's.

-- Paul


