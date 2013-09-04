MIME-Version: 1.0
Date: Wed, 4 Sep 2013 06:04:53 -0400
Message-ID: <CAC3AHrLQiZxgSrDxKhVa_171Ve7unw__ZjpA22z27mDDqVpmcQ@mail.gmail.com>
From: Adam Jacobvitz <jacobvi123@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Xenomai] unmapping and remapping /dev/rtheap
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi, I need to take a checkpoint using criu of an application compiled using
xenomai's posix skin. The problem is that criu doesn't know what to do with
the /dev/rtheap mapping. Is there a way to either manually unmap
/dev/rtheap from the process and then remap it when restored, or is there a
way to compile my xenomai application without using rtheap?

Thanks!

Adam
