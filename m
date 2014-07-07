Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
From: "Yogi A. Patel" <yapatel@gatech.edu>
In-Reply-To: <oq7g3pvpk0.fsf@merlin.sez.to>
Date: Sun, 6 Jul 2014 23:19:37 -0400
Message-Id: <CA30A2D0-9D01-4C5C-AD6F-5B5FD75422C9@gatech.edu>
References: <9584EBE8-001C-41E7-88A1-3B4CF07DD567@gatech.edu>
 <oq7g3pvpk0.fsf@merlin.sez.to>
Content-Type: text/plain;
	charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Analogy Reference Issue with NI PCIMIO
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Paul Janzen <pcj@xenomai.sez.to>
Cc: xenomai@xenomai.org

I am interfacing with the breakout box for the NI card.

The function generator output is ground referenced (there=92s a =
continuous path from the output BNC terminal to the ground pin of the =
EIC connector on the back).

The output of the function generator is connected to AI 2 (I=92ve tried =
others) and AI 2 is set as a ground source on the breakout board.

I have used this setup to test all of the configuration mentions =
previously. I am using a PCI6259 DAQ card.

On a side note - I saw a variable called .calcdac in the analogy driver =
file. What is that variable for?

Thank you.

Yogi

On Jul 6, 2014, at 11:02 PM, Paul Janzen <pcj@xenomai.sez.to> wrote:

> "Yogi A. Patel" <yapatel@gatech.edu> writes:
>=20
>> When I set the reference to COMMON, I get the signal that I am
>> feeding in (sine wave from function generator using BNC) at the
>> right frequency and amplitude.
>=20
> Can you describe the connections you have made between the function
> generator and the NI card terminals in each case?=20
>=20
> Also, is the function generator output ground-referenced or floating?
>=20
> -- Paul

