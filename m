From: Wolfgang Denk <wd@domain.hid>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 8bit
In-reply-to: Your message of "Wed, 26 Mar 2008 09:28:05 -0400."
	<47EA4F65.7050600@domain.hid>
Date: Wed, 26 Mar 2008 17:20:10 +0100
Sender: wd@domain.hid
Message-Id: <20080326162011.0040C243A7@domain.hid>
Subject: Re: [Xenomai-core] Xenomai/SOLO - RTOS emulation for standard Linux
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: "Steven A. Falco" <sfalco@domain.hid>
Cc: xenomai@xenomai.org

In message <47EA4F65.7050600@domain.hid> you wrote:
> I'll of course have to make my own tests, but I am curious - do folks
> expect that Xenomai/SOLO will be able to equal the interrupt performance
> of Xenomai/IPIPE?  I guess my intuition says that the IPIPE approach
> would guarantee better interrupt response, but maybe my intuition is
> completely wrong.  I'll try to post some results in a few weeks...

Well, interrupt performance is just one thing.  The  whole  real-time
behaviour  depends on the underlying OS. And frankly, what we've seen
so far means that PREEMPT_RT can deliver "probabilistic" real-time at
best. Take a test case that has been running fine  and  just  put  it
into  a  new environment (like attach it to a different network), and
it will behave differently. Just plug in a new USB device that hasn't
been tested before, and nobody can tell what will happen.

If it comes to  hard,  reliable  real-time  behaviour,  we  recommend
Xenomai/ipipe to all our customers. However, there are some who think
it  is  important  to have an "original, unpatched" kernel.org source
tree. These obviously run for PREEMPT_RT, and SOLO.

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@domain.hid
"You know, after a woman's raised a family and so on,  she  wants  to
start living her own life."   "Whose life she's _been_ living, then?"
                                  - Terry Pratchett, _Witches Abroad_

