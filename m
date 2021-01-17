From: Philippe Gerum <rpm@xenomai.org>
Subject: [RFC] Drop support for ARM OABI from Xenomai 3.2
Date: Sun, 17 Jan 2021 18:32:46 +0100
Message-ID: <87wnwbeaf5.fsf@xenomai.org>
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


The old ARM ABI format is dead, however we still have the support bits
to handle it in both the I-pipe and Cobalt, which - I believe - does not
make sense anymore. In addition, Dovetail only supports the new EABI
format, and there is definitely no plan to care about OABI.

Given the burden of maintaining this obsolete code which nobody should
be using these days, I recommend to drop support for the OABI format
starting from Xenomai 3.2.

Please comment.

Thanks,

-- 
Philippe.

