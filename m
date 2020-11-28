From: Philippe Gerum <rpm@xenomai.org>
Subject: Xenomai 4 and the Common Xenomai Platform
Date: Sat, 28 Nov 2020 18:43:24 +0100
Message-ID: <87r1od8jib.fsf@xenomai.org>
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


All,

In a recent series of discussions, the core Xenomai contributors
agreed that time has come to start a common effort towards Xenomai 4,
the next generation dual kernel system for Linux, based on the work of
the EVL project [1].

We also acknowledged the requirement for keeping Xenomai 3.x relevant
for new application designs, with a well-marked upgrade path to
Xenomai 4. We believe that we can achieve this by specifying a set of
common features and interfaces the future Xenomai 3.x releases and
Xenomai 4 would share.

We are formally starting such specification process, codenamed the
"Common Xenomai Platform" (CXP for short). Xenomai 3.3 and beyond will
implement the common platform, so that application designers who
follow the CXP guidelines may expect portability across these
releases. Xenomai 3.2 is going to be a transitional step towards this
common platform, switching from the I-pipe to Dovetail [2].

Please see [3] for details about the motivations behind the CXP, and
its goals. As we discuss the various topics within the scope of this
work and converge to set the CXP guidelines, this document will be
updated accordingly.
  
Anyone is welcome to participate in this specification effort, which
will take place publicly on this mailing list. Stating what you need
today, and what you might need tomorrow from a real-time
infrastructure like Xenomai would be a good way to get involved.  For
convenience, please make sure to mark related postings with the
"[CXP]" tag in the "Subject:" line.

March 31, 2021 is our deadline for completing the specification
process. Please make sure to have your say in time.

Thanks,

[1] https://evlproject.org/
[2] https://evlproject.org/dovetail/
[3] https://xenomai.org/wiki/Common_Xenomai_Platform

-- 
Philippe.

