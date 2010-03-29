Message-ID: <4BB111C0.9050502@domain.hid>
Date: Mon, 29 Mar 2010 22:46:56 +0200
From: Daniele Nicolodi <daniele@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Analogy: A4L_CHAN_AREF_* and AREF_* and other macros
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>, Alexis Berlemont <alexis.berlemont@domain.hid>

Hello Alexis,

I have noticed that in Analogy headers there are two sets of macros to
define channels references, one with prefix A4L_CHAN_AREF_ and the other
with prefix AREF_. I think keeping both is confusing and dangerous,
because similar symbols are defined with different numerical values!

The later form is the one used in comedi API and drivers, but i think it
is better to prefix all exported symbols and constants with a namespace
like string. I would be for keeping only the former form.

If you agree, I can provide a patch for you to review.

Similarly, I would rename TRIG_ constants to something like A4L_TRIG_,
and while at it I think TRIG_WAKE_EOS should become A4L_CMD_WAKE_EOS, as
it is a command flag and not a trigger source.

Similarly, it would be nice also to rename other macros defined in
command.h, adding at least a common A4L_ prefix. While at it I think
that, maybe after a rename to make their purpose more clear, CR_* macros
should be exposed to user space too.

If you think API breakage should be avoided, even in a so early stage of
development and diffusion, we can keep the old definitions for a while,
issuing deprecation warning (in this case those symbols would have to be
exposed as constant variables where to apply the __deprecated__ gcc
attribute).

Let me know what you think about this proposal.

Cheers,
-- 
Daniele


