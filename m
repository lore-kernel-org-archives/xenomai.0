Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Stefan Schaal <sschaal@domain.hid>
In-Reply-To: <20110512225203.GB2904@domain.hid>
Date: Thu, 12 May 2011 21:20:26 -0700
Content-Transfer-Encoding: quoted-printable
Message-Id: <0C04C0BD-6E34-405C-855C-871CCFF23E02@domain.hid>
References: <20110512225203.GB2904@domain.hid>
Subject: Re: [Xenomai-core] analogy: wake-up threshold
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Alexis Berlemont <alexis.berlemont@domain.hid>
Cc: xenomai@xenomai.org

Hi Alexis,

  thanks so much for the new feature! I will try it and report back.=20

In the last months, I actually did run some comparisons between Comedi =
and Analogy, and in all cases found that your Analogy implementation =
performs exactly the same as Comedi, actually, for CMD-based streaming, =
I noticed shorter latencies in Analogy. I also couldn't find any Comedi =
functionality (for our problems) that was missing in Analogy. Thus, for =
our work, there may simply be an issue that the communication protocol =
we are porting from vxWorks may not easily be implemented with our =
NI6259 board using either Comedi or Analogy, and we are considering to =
change the protocol with the help of some intermediate electronics. =
After all is working, I will email the method of solution to the =
xenomai-core list.

But I am eager to check your new functions.=20

Best wishes,

-Stefan


On May 12, 2011, at 15:52, Alexis Berlemont wrote:

> Hi Stefan,=20
>=20
> A few months ago, you asked me whether it was possible to prevent the
> OS from waking up your process each time a few bytes were
> acquired. You came with the idea to implement a wake-up threshold =
below
> which the user space process is kept in sleep state.
>=20
> A few days ago, I updated my experimental branch: two new user-space
> functions were added: a4l_set_wakesize() and
> a4l_get_wakesize(). Thanks to them, you will be able to configure the
> wished behaviour.
>=20
> I hope this will help you.
>=20
> --=20
> Alexis.


