From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Mon, 19 May 2014 19:09:10 -0400
Message-ID: <20140519230910.GF17765@csclub.uwaterloo.ca>
References: <537A8E29.1070000@zultron.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <537A8E29.1070000@zultron.com>
Subject: Re: [Xenomai] [PATCH] Add armhf arch to Debian packaging
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: John Morris <john@zultron.com>
Cc: xenomai@xenomai.org

On Mon, May 19, 2014 at 06:05:13PM -0500, John Morris wrote:
> A non-text attachment was scrubbed...
> Name: 0001-Add-armhf-arch-to-Debian-packaging.patch
> Type: text/x-patch
> Size: 1388 bytes
> Desc: not available
> URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20140519/afa36b83/attachment.bin>

Pretty sure the xenomai-2.6 git tree already has that (although added
after 2.6.3 was released).

commit b10527ed14399a6485f69b935988d9d5211066d0
Author: Paul Corner <paul_c@tuxcnc.org>
Date:   Sun Feb 2 22:54:42 2014 +0000

    debian: add armhf architecture

    for the benefit of platforms that use this flavour of arm.

-- 
Len Sorensen

