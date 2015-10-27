Date: Tue, 27 Oct 2015 13:30:04 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20151027123003.GA4874@hermes.click-hack.org>
References: <1445948476-7587-1-git-send-email-henning.schild@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1445948476-7587-1-git-send-email-henning.schild@siemens.com>
Subject: Re: [Xenomai] [PATCH] scripts: use mktemp instead of relying on
 TMPDIR beeing in env
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Henning Schild <henning.schild@siemens.com>
Cc: xenomai@xenomai.org

On Tue, Oct 27, 2015 at 01:21:16PM +0100, Henning Schild wrote:
> The environment variable TMPDIR is optional and not always set. We could
> test for it and fall back to /tmp/ or just use the tool mktemp.

I am not sure mktemp is available everywhere. What about setting
TMPDIR to /tmp if not set ?

-- 
					    Gilles.
https://click-hack.org

