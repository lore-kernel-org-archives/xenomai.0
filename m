Date: Mon, 31 Aug 2015 13:10:46 +0200
From: Bukuli Norbert <bukuli.norbert@protecta.hu>
Message-ID: <20150831111046.GD8044@bukuli-linux.Protecta.local>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] Current state of Freescale LS1021A Xenomai support
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello, Everyone!

I have a few questions about the current state of Freescale LS1021A
SoC and TWR-LS1021A evaluation board support.

I saw on the website, that the `QorIQ LS1: LS1021' SoC is supported,
but I could not figure out, what line of Xenomai supports it. The
stable one (2.6) or the upcoming release (3)?

I prefer the dual-kernel architecture, because of our application
strict realtime needs, so I need a Xenomai supported version.

The linux kernel found in Freescale BSP is derived from v3.12.37,
which is currently not supported by Xenomai. On the other hand,
xenomai supported linux kernel versions (3.8.13, 3.10.32, 3.14.17)
don't have LS1021 support.

Newer vanilla kernels support LS1021A, but there are no i-pipe patches
for those versions.

Any documentation, git trees, and corresponding information would
be highly appreciated.

Thank you in advance!

--
Best regards
Norbert Bukuli
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://xenomai.org/pipermail/xenomai/attachments/20150831/6c9570b8/attachment.sig>
