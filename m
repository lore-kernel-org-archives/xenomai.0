Date: Wed, 29 Apr 2015 13:53:38 +0200
From: Henning Schild <henning.schild@siemens.com>
Message-ID: <20150429135338.0aa92a70@md1em3qc>
In-Reply-To: <20150429093943.GL1993@hermes.click-hack.org>
References: <5c789beff3ff2c2ef88fbe1a53342cb7ebc714b8.1430299655.git.henning.schild@siemens.com>
 <20150429093943.GL1993@hermes.click-hack.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH 1/2] debian: add autoreconf to build rules
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On Wed, 29 Apr 2015 11:39:43 +0200
Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote:

> is dh-autoreconf available on wheezy ?

Sure.
 
> If people work from a release, autoreconf is useless and has chances
> to do more harm than good.

So releases will contain the Makefiles and configure-scripts again?

> If people do not work from a release, can we not expect them to run
> autoreconf by themselves ?

You are right, that is another way of looking at it. I was assuming
that the rules should contain all necessary build steps, but i am not
sure what the best practice is for debian-directories.

Henning

