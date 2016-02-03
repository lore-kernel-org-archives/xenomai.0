Date: Wed, 3 Feb 2016 15:24:48 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20160203142448.GB32138@hermes.click-hack.org>
References: <1453902069-18824-1-git-send-email-henning.schild@siemens.com>
 <1454504365-7015-1-git-send-email-henning.schild@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1454504365-7015-1-git-send-email-henning.schild@siemens.com>
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
To: Henning Schild <henning.schild@siemens.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Xenomai <xenomai@xenomai.org>

On Wed, Feb 03, 2016 at 01:59:25PM +0100, Henning Schild wrote:
> In 4.1 huge page mapping of io memory was introduced, enable ipipe to
> handle that when pinning kernel memory.
> 
> change that introduced the feature
> 0f616be120c632c818faaea9adcb8f05a7a8601f

Could we have an assessment of whether avoiding the call to
__ipipe_pin_range_mapping in upper layers makes the patch simpler?

-- 
					    Gilles.
https://click-hack.org

