Message-ID: <4FE03797.7000408@grandegger.com>
Date: Tue, 19 Jun 2012 10:25:59 +0200
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] Sharing memory between rt-posix and standard-posix apps
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai@xenomai.org

Hello,

the shared memory support of Xenomai's POSIX skin currently only support
shared memory between rt processes. I mean, all apps must be linked
against Xenomai's POSIX library. Shared memory created by apps linked
against the standard POSIX library will not be found. Is/was there a
good reason for that limitation?

Wolfgang.

