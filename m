Date: Mon, 22 Feb 2016 22:31:40 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20160222213140.GI7398@hermes.click-hack.org>
References: <1456176343-13522-1-git-send-email-mwelling@ieee.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1456176343-13522-1-git-send-email-mwelling@ieee.org>
Subject: Re: [Xenomai] [PATCH] demo: cross-link: Properly handle ioctl error
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Michael Welling <mwelling@ieee.org>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@xenomai.org

On Mon, Feb 22, 2016 at 03:25:43PM -0600, Michael Welling wrote:
> Update cross-link demo to properly report ioctl errors.

This fixes only one spot. Are there no other spots with the same issue?

-- 
					    Gilles.
https://click-hack.org

