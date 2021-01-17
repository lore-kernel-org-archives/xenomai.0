From: Philippe Gerum <rpm@xenomai.org>
Subject: [RFC] Drop support for x86_32 from Xenomai 3.2
Date: Sun, 17 Jan 2021 18:26:30 +0100
Message-ID: <874kjffpa1.fsf@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org


The I-pipe and Cobalt ports to x86_32 received neither careful
maintenance nor testing for ages. In addition, Dovetail does not support
the 32bit legacy mode, and there is no plan to do so. Therefore I
recommend to stop supporting the x86_32 architecture starting from
Xenomai 3.2, which echoes what Jan has been saying for quite a while
about this issue too.

If you do care about running Xenomai on this architecture and are
willing to maintain such a port in the long run, this is definitely the
right time to make your case, asap.

Thanks,

-- 
Philippe.

