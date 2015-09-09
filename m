Date: Wed, 9 Sep 2015 15:37:23 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150909133723.GC24499@hermes.click-hack.org>
References: <55ED7A9E.1080209@gmail.com> <55ED8875.10504@xenomai.org>
 <55F03436.5040202@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55F03436.5040202@gmail.com>
Subject: Re: [Xenomai] timer_create( ) example in Xenomai-3
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Konstantinos Chalas <konchalas@gmail.com>
Cc: Xenomai <xenomai@xenomai.org>

On Wed, Sep 09, 2015 at 03:29:26PM +0200, Konstantinos Chalas wrote:
> For future reference, this is what a working POSIX timer in Xenomai looks

Unfortunately, this code is a very bad reference
- you ignore some function potential errors
- and even in the case you do not ignore them, you do not take
apropriate action.

For instance, if sigwait returns an error, this program will create
instant lockup.

-- 
					    Gilles.
https://click-hack.org

