Date: Wed, 29 Apr 2015 14:06:41 +0200
From: Henning Schild <henning.schild@siemens.com>
Message-ID: <20150429140641.0da43fb1@md1em3qc>
In-Reply-To: <20150429115938.GN1993@hermes.click-hack.org>
References: <5c789beff3ff2c2ef88fbe1a53342cb7ebc714b8.1430299655.git.henning.schild@siemens.com>
 <20150429093943.GL1993@hermes.click-hack.org>
 <20150429135338.0aa92a70@md1em3qc>
 <20150429115938.GN1993@hermes.click-hack.org>
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

On Wed, 29 Apr 2015 13:59:38 +0200
Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote:

> > You are right, that is another way of looking at it. I was assuming
> > that the rules should contain all necessary build steps, but i am
> > not sure what the best practice is for debian-directories.
> 
> The thing is that debian allows to install very old versions of the
> autotools. I would not want the default rule, to simply wreck the
> autotools file because the user made the mistake of having old
> versions of the autotools used by default, whereas the shipped ones
> are fine.

Ok, thats a valid argument. So people working against git have to
autoreconf manually before being able to use the debian-stuff.

Henning

