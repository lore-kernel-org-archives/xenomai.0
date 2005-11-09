Date: Wed, 9 Nov 2005 18:51:30 +0100 (MET)
From: Sebastian Smolorz <Sebastian.Smolorz@domain.hid>
Message-ID: <Pine.GSO.4.58.0511091817070.29250@domain.hid>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [Xenomai-core] RT pipes
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

Hi,

I've spotted a -- in my view -- strange behaviour of RT pipes in the
native skin. The scenario is as follows:

A RT task creates a RT pipe and writes some bytes into it. A NRT
counterpart reads from this pipe, but not all bytes. Afterwards, the RT
task deletes the pipe.

Now the program is re-run: RT task creates the pipe, writes some bytes,
and the NRT part reads some bytes, but begins with the old ones which
weren't read during the first run of the program.

Now my question: Is this behaviour intentional? If it is then I see the
following problem: A task which calls rt_pipe_create() cannot be sure that
the pipe is empty. So it should be able to clear the pipe before use but I
found no function that allows a RT task to clear the pipe.


Sebastian

