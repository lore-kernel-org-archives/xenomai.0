Date: Fri, 8 Jul 2016 22:50:55 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20160708205055.GU9465@hermes.click-hack.org>
References: <CAPXCTbbQ1Lo7voRB1sVOtnZ0yjwhZBgUnzi1YX2rv_CL1z8f0g@mail.gmail.com>
 <20160708194905.GQ9465@hermes.click-hack.org>
 <CAPXCTbYJ_rQnvdU7srw1oGL6R0c7vJmMF+u_T7d-zgkZ1yLCXg@mail.gmail.com>
 <20160708203405.GS9465@hermes.click-hack.org>
 <CAPXCTbai+OJHRkt=x5qxrQNa+dsmN8aNpcgxSmygsqW7rqibXQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPXCTbai+OJHRkt=x5qxrQNa+dsmN8aNpcgxSmygsqW7rqibXQ@mail.gmail.com>
Subject: Re: [Xenomai] Compiling testsuite and utils
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Eder Alves de Moura <edermoura@gmail.com>
Cc: Xenomai <xenomai@xenomai.org>

On Fri, Jul 08, 2016 at 05:47:40PM -0300, Eder Alves de Moura wrote:
> - do you really want to compile a 32 bits version of Xenomai?
> 
> no. I am not want to compile it to a specific 32 bits.

The run configure without a --host or CFLAGS, or LDFLAGS. The
defaults should be fine.

-- 
					    Gilles.
https://click-hack.org

