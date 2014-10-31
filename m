Message-ID: <5453A3A1.7010202@xenomai.org>
Date: Fri, 31 Oct 2014 15:58:41 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] [RELEASE] Xenomai 3.0-rc2
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <Xenomai@xenomai.org>


Besides the usual batch of fixes, this release brings in two significant
updates:

- the support for multiple ABI models in Cobalt has been merged
eventually (i.e. 32bit userland running over a 64bit kernel). This
feature is currently enabled for Cobalt/x86_64, which supports the ia32
emulation and x32 ABIs when the host kernel enables them
(CONFIG_IA32_EMULATION and CONFIG_X86_X32 respectively).

- a lot of work on the Analogy framework by Jorge, especially in the
calibration code.

Nothing went in this release on the Mercury side, things look quite
stable there.

http://download.gna.org/xenomai/testing/latest/

-- 
Philippe.

