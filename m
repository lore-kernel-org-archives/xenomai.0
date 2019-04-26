From: Steven Seeger <steven.seeger@flightsystems.net>
Subject: __ipipe_root_sync
Date: Fri, 26 Apr 2019 13:07:38 -0400
Message-ID: <2053542.YF2tJfiQcj@omoikane>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Why was __ipipe_root_sync moved out of kernel/ipipe/core.c? I see it now in 
arch/arm/kernel/ipipe.c. It is the same exact code I had in the PPC branch in 
kernel/ipipe/core.c. I can move it to the arch-specific code, but was wondering 
why.

Steven



