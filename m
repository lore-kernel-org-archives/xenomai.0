MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18433.65.910459.873472@domain.hid>
Date: Sat, 12 Apr 2008 20:32:33 +0200
In-Reply-To: <001f01c89cc6$f269b250$0202a8c0@domain.hid>
References: <001f01c89cc6$f269b250$0202a8c0@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-help] Communication between Xenomai and Linux domains
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: van der Linden <ejvanderlinden@domain.hid>
Cc: xenomai@xenomai.org

van der Linden wrote:
 > Hello,
 > 
 > I'm quite new to Xenomai. 
 > 
 > Before further exploring Xenomai, I like to know if it is possible to communicate between a Xenomai process and a standard Linux process.
 > 
 > Is there some reading on this subject?

I answered a similar question yesterday:
https://mail.gna.org/public/xenomai-core/2008-04/msg00082.html

It was about communicating between threads, whereas you ask about
communicating between processes. But the answer is pretty much the same;
native skin pipes and other Xenomai IPCs may be used to communicate
between different processes.

-- 


					    Gilles.

