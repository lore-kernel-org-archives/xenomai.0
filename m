From: Paul <paul_c@domain.hid>
Subject: Re: [Xenomai-core] [PATCH] Adeos support for 2.6.18 merged PowerPC
	architecture.
Date: Thu, 30 Nov 2006 18:06:51 +0000
References: <20061124105346.e442448d.benjamin.zores@domain.hid>
	<20061130133745.272ab4b1.benjamin.zores@domain.hid>
	<456EDA4B.3060809@domain.hid>
In-Reply-To: <456EDA4B.3060809@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611301806.51699.paul_c@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>


On Thursday 30 November 2006 13:19, Jan Kiszka wrote:
> Philippe, I know you are very busy, but shouldn't we make a pre-release
> available already, also to discuss further how to deal best with genirq
> on other platforms beyond x86?

I have an x86_64 box waiting for a Xenomai port - I don't see much point in 
hacking 2.6.17 and earlier when 2.6.19 is going to be a major change in key 
areas.. It also looks like there is a closer integration of x86_64 and plain 
old ix86 code in the 2.6.19 tree, so this may simplify the task of 
maintaining a 64bit patch.


Regards, Paul.


