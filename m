MIME-Version: 1.0
From: George Broz <brozgeo@gmail.com>
Date: Tue, 11 Apr 2017 16:44:13 -0700
Message-ID: <CAMcKmiG4M5gW_bcYLM0Zg57k2ySSbs5skkf32EFchwYkUNvMDQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] 0-priority task in Cobalt
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello,

In the native skin for Xenomai 2.6.x, it was possible to create a
0-priority task - a Xenomai task that spends its life in secondary
mode except when calling/interacting with Xenomai services that would
temporarily promote it to primary mode.

Is it possible to create a 0-priority task through the Cobalt skin?
What are the calls/arguments needed?


Thanks in advance!

--George Broz
Moog Industrial Group

