From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [ANNOUNCE] Xenomai 3.0.11 released
Message-ID: <0a10dd0b-5aee-272f-f1b4-8539121470c8@siemens.com>
Date: Mon, 9 Nov 2020 18:40:38 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>


Changes since 3.0.10:

Henning Schild via Xenomai (1):
      testsuite/xeno-test: do not swallow exit status anymore

Jan Kiszka (12):
      cobalt: Fix uclibc build
      cobalt: sched-quota: Fix live-updating if quotas, once more
      cobalt/intr: Move IRQ exit trace point in non-shared case
      Uninstall udev files
      lib/alchemy/testsuite: Add event test case for EV_ALL bug
      kernel/cobalt/posix: Fix cobalt_event_wait for COBALT_EVENT_ALL case
      lib/copperplate: Fix eventobj_wait for COBALT_EVENT_ALL case
      doc: Look for asciidoc images also in /etc
      cobalt/process: Fix incomplete backport of __handle_taskexit_event change
      smokey: Close tmp file at end of sigdebug test
      cobalt/posix/sem: Fix invalid parameter in tracepoint
      config: Bump version number

Laurentiu-Cristian Duca (1):
      spi: fix read() return code checking in spi_master_read_rt()

Philippe Gerum (8):
      doc: fix assorted Doxygen warnings
      doc: do not discard pdflatex output
      doc: fix asciidoc generation
      cobalt/registry: fix export/unexport race on object deletion
      cobalt/registry: prevent use-after-free triggered by object removal
      drivers/ipc: bufp: fix rd/rd and wr/wr races
      boilerplate: setup: fix infinite loop in CPU list parser
      cobalt/kernel: vfile_snapshot: fix seq_file leakage on race detection

Stephen Freyder (1):
      Restore proper operation of ioctl(SET_CONFIG)

Thanks to all the contributors!

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

