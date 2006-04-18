From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17477.9296.484358.469533@domain.hid>
Date: Tue, 18 Apr 2006 19:39:28 +0200
Subject: Re: [Xenomai-core] [RFC] collecting xenomai statistics
In-Reply-To: <200604171047.51730.niklaus.giger@domain.hid>
References: <200604171047.51730.niklaus.giger@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: niklaus.giger@domain.hid
Cc: xenomai-core <xenomai@xenomai.org>

Niklaus Giger wrote:
 > But I would be very interested in knowing exactly which kind of information 
 > the core developers are interested in. How should it be presented? In tabular 
 > form? Graphs, which ones? And kind of feedback will be evaluated and 
 > integrated.

I did some similar work once, so I have some ideas. What I
would like to have is, given a configuration (.config) build all
versions of Adeos+Xenomai for a given set of compilers. Then, present
the result in a tabular form. Each cell would give the number of
warnings and errors for the corresponding build, with links to
browseable build logs. Maybe the cell could have different colors
(green, orange, red) depending on the number of warnings and errors.

What would also be interesting, is to test the "distcheck" target. The
interesting result being a comparison between the source directory
contents and the generated tarball contents (if distcheck is
successful).

-- 


					    Gilles Chanteperdrix.

