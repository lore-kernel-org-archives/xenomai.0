Message-ID: <50E60647.5090309@xenomai.org>
Date: Thu, 03 Jan 2013 23:29:27 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAD1EtoiVOD7KdOD7ZyqtxQ3AttD=Ca0bbsOsKOiMQtyNxm47EA@mail.gmail.com>
In-Reply-To: <CAD1EtoiVOD7KdOD7ZyqtxQ3AttD=Ca0bbsOsKOiMQtyNxm47EA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] make devices not run from deb
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Daniel M. Drucker, Ph.D." <dmd@interactive-motion.com>
Cc: xenomai@xenomai.org

On 01/03/2013 11:22 PM, Daniel M. Drucker, Ph.D. wrote:

> In the latest from git, when I create a .deb using debuild, the resulting
> deb, when installed, doesn't seem to create /dev/rtheap.
> 
> Under 2.6.1, the same debuild process created a deb which when installed
> did create /dev/rtheap.


Strange. The debian packages I use, temporarily available here:
http://xenomai.org/~gch/pub/deb/

Get /dev/rtheap created. It is created by an udev AFAIK.

-- 
                                                                Gilles.

