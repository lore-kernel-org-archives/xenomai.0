References: <9584EBE8-001C-41E7-88A1-3B4CF07DD567@gatech.edu>
 <oq7g3pvpk0.fsf@merlin.sez.to>
 <CA30A2D0-9D01-4C5C-AD6F-5B5FD75422C9@gatech.edu>
 <oq1ttxvnd5.fsf@merlin.sez.to>
 <9008C96C-A4AD-4B89-9610-F60DAF4CA0E5@gatech.edu>
From: Paul Janzen <pcj@xenomai.sez.to>
Date: Sun, 06 Jul 2014 21:41:48 -0700
In-Reply-To: <9008C96C-A4AD-4B89-9610-F60DAF4CA0E5@gatech.edu> (Yogi A.
 Patel's message of "Mon, 7 Jul 2014 00:08:59 -0400")
Message-ID: <oqvbr9u6er.fsf@merlin.sez.to>
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

> Thus, when I plug into AI 2 using a BNC and use Ground mode in
> software and switch being set to Ground source, it is automatically
> being ground referenced since the data sheet for that box says the
> AI sense pin is tied to the internal GND.

No, this breakout box only supports configuring the PCI-6259 input mux
in differential mode.  The switch just selects whether or not to tie
the BNC shell (e.g., pin 31) to AI-GND through 5 kohm || 0.1 uf.  In
your case, since the FG is already ground-referenced, you should set
the switch to GS, but it should not make a huge difference in either
case.

I am not sure why you see flatline data in this case.

> In terms of the calibration, does Analogy automagically calibrate
> the DAQs when loaded or is there a utility or code for a user to
> calibrate their card?

AFAIK, Analogy does not have soft-calibrate support.  You can either
root around in the EEPROM device for the most recent saved cal tables
or use Comedi soft-calibrate to do a run-time calibration.

-- Paul

