Date: Thu, 4 Feb 2016 12:53:57 +0100
From: Henning Schild <henning.schild@siemens.com>
Message-ID: <20160204125357.7068aaa4@md1em3qc>
In-Reply-To: <20160203142448.GB32138@hermes.click-hack.org>
References: <1453902069-18824-1-git-send-email-henning.schild@siemens.com>
 <1454504365-7015-1-git-send-email-henning.schild@siemens.com>
 <20160203142448.GB32138@hermes.click-hack.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH v3] ipipe x86 mm: handle huge pages in memory
 pinning
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Xenomai <xenomai@xenomai.org>

On Wed, 3 Feb 2016 15:24:48 +0100
Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote:

> On Wed, Feb 03, 2016 at 01:59:25PM +0100, Henning Schild wrote:
> > In 4.1 huge page mapping of io memory was introduced, enable ipipe
> > to handle that when pinning kernel memory.
> > 
> > change that introduced the feature
> > 0f616be120c632c818faaea9adcb8f05a7a8601f  
> 
> Could we have an assessment of whether avoiding the call to
> __ipipe_pin_range_mapping in upper layers makes the patch simpler?

I will have a look at that. Specifically why mainline does not run into
that. With the lazy nature of the mappings, when it comes to other
mm's, i still do not see why the vmalloc_fault path does not deal with
huge pages.

Henning

