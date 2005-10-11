From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17227.29524.617826.736277@domain.hid>
Date: Tue, 11 Oct 2005 10:09:56 +0200
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

The real answer is that if you do not "svn checkout" the "doc" directory,
Xenomai build system should continue working properly. The same goes for
the "sim" directory.

-- 


					    Gilles Chanteperdrix.

