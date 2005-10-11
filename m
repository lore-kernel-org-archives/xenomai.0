From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17227.27763.201941.114412@domain.hid>
Date: Tue, 11 Oct 2005 09:40:35 +0200
Subject: Re: [Xenomai-core] Generated docs
In-Reply-To: <434B6BC6.4030401@domain.hid>
References: <434B6BC6.4030401@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Heikki Lindholm <holindho@domain.hid>
Cc: xenomai@xenomai.org

Heikki Lindholm wrote:
 > Hi,
 > 
 > One thing that always bothered my in fusion cvs: why do the generated 
 > docs have to be in the cvs/svn? Why not just let them be... well... 
 > generated?

Because it allows the releases to be done taking the docs from the
generated dir instead of generating them.

IOW: separate maintenance of documentation and code.

What I do not understand is what is so bothering ?

-- 


					    Gilles Chanteperdrix.

