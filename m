MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18508.1979.979971.360938@domain.hid>
Date: Sun, 8 Jun 2008 18:24:27 +0200
In-Reply-To: <51B669A8A7D2914E9AB2B3F40AC6553E64700A@afsexc01.aurora.aero>
References: <51B669A8A7D2914E9AB2B3F40AC6553E646FC3@domain.hid>
	<2ff1a98a0805290621r361ceb3dh601e41768983fb27@domain.hid>
	<51B669A8A7D2914E9AB2B3F40AC6553E646FC5@domain.hid>
	<2ff1a98a0805290654w33623528yf34c610f11015220@domain.hid>
	<51B669A8A7D2914E9AB2B3F40AC6553E646FC7@domain.hid>
	<2ff1a98a0805290730m2fb0aa02o50c4b317f83aaa00@domain.hid>
	<51B669A8A7D2914E9AB2B3F40AC6553E646FD6@domain.hid>
	<18495.46374.740367.243739@domain.hid>
	<51B669A8A7D2914E9AB2B3F40AC6553E64700A@afsexc01.aurora.aero>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-help] Xenomai and SDL NET sockets 1.2
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Karch, Joshua" <jkarch@domain.hid>
Cc: xenomai@xenomai.org

Karch, Joshua wrote:
 > 
 > Gilles,
 > 
 > by the way, I resolved the program by declaring the SDL net sockets on the heap.  The socketsets were too big for Xenomai to handle in a task, so I declared them in the main and passed them in as parameters and everything worked.

There should be no stack size too big for Xenomai. What do you observe
when you ask for a large enough stack size ?

-- 


					    Gilles.

