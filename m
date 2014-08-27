Message-ID: <53FDBD43.2000908@mpt-koegel.de>
Date: Wed, 27 Aug 2014 13:13:07 +0200
From: =?UTF-8?B?QWxmcmVkIEvDtmdlbA==?= <alfred@mpt-koegel.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [Xenomai] rtcan driver for c_can (pch_can) underway ?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

hi,
i am in the evaluation phase of a real time project with a Intel® Atom™
E640 processor and Intel® Platform Controller Hub EG20T.
i managed to install a ipipe patched kernel 3.10.23 and run can
communication with socketcan, my question now is, is there somebody who
is porting the existing pch_can or c_can (this two can controllers seem
to be identical...) linux driver to rtcan or is there some kind of
tutorial what has to be done to get a correct port.
i read in the past a mail from wolfgang grandegger who did this port for
flexcan but lost this track again.

with regards

alfred

