From: Sebastian Smolorz <Sebastian.Smolorz@gmx.de>
Date: Wed, 17 Oct 2018 18:09:33 +0200
Message-ID: <6420434.4R09zZnBme@lenni>
In-Reply-To: <efacce14-b2b0-4961-1694-06d5f4041d22@siemens.com>
References: <1539775907-5124-1-git-send-email-sebastian.smolorz@gmx.de>
 <efacce14-b2b0-4961-1694-06d5f4041d22@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Subject: Re: [Xenomai] [PATCH 0/4] net/tcp: Fix several bugs and allow rttcp
 to be built
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai@xenomai.org

On 17.10.18 13:44, Jan Kiszka wrote:
> On 17.10.18 13:31, Sebastian Smolorz wrote:
> > This patch series makes RTnet's tcp module usable again. It was not
> > selectable in Kconfig for a long time. Now it is supposed to work in
> > the way it worked when RTnet was a separate project for Xenomai 2.
> 
> Despite the "supposed", can I assume you tested it already
> successfully with some real workload?

Tested it under QEMU with the rttcp example (rttcp-server and rttcp-
client) over rtlo. Tests on real hardware are pending and planned in the 
next few days. No problem if you want to postpone the patches until I 
report the successful outcome of those tests.

-- 
Sebastian



