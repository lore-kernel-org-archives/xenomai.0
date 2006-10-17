From: Philippe Gerum <rpm@xenomai.org>
Content-Type: text/plain
Date: Tue, 17 Oct 2006 19:50:02 +0200
Message-Id: <1161107402.4981.37.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Xenomai Roadmap
Reply-To: rpm@xenomai.org
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


Thanks to Bruno, we now have a Wiki, to better organize information
and keep interesting/useful ideas in a central place, and the beast
sleeps there: http://www.xenomai.org/wiki.

Hopefully, this place is going to be populated with more and more
information over time, but you can already find interesting bits
there, and particularly, the project's general r_o_a_d_m_a_p.  Yes, a
roadmap, really, no kidding. Jan, Gilles, Dmitry and a few others
threatened to bury me under tons of patches until we publically explain
where we came from, and where we are heading. Given their firepower in
this matter, I promptly surrendered, even if I know that this won't slow
down their productivity for more than a week, because they are
basically relentless, merciless and sleepless people.

The gist of it is that we are heading to Xenomai 3, which should allow
us to support the Xenomai interfaces indifferently over both the
co-kernel (i.e. Adeos) and native preemption (i.e. PREEMPT_RT)
technologies, in order to keep everyone's options open, and always be
able to use the best tool for the job, depending on which job we are
talking about.
[Ok, those who did not fall off their chair are likely to have carefully
read my various posts on related matters for the past two years, which I
thank them for]
The other big thing should be a significant extension of the support
for industrial drivers, available over an enhanced RTDM layer, and
hosted by the Xenomai project.

In any case, we tried to explain these issues and more, here:
http://www.xenomai.org/wiki/index.php/Xenomai:Roadmap

As mentioned, this is a general roadmap, and we don't provide any
precise timeframe yet. Xenomai 3 is going to be a significant effort,
which must not impede the stabilization of the current development
branch aiming at the 2.3.x series.

-- 
Philippe.



