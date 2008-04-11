MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18431.21208.811180.380341@domain.hid>
Date: Fri, 11 Apr 2008 14:00:24 +0200
In-Reply-To: <a7575bba0804102028s19588823s7970e7e33bd38d44@domain.hid>
References: <a7575bba0804102028s19588823s7970e7e33bd38d44@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-core] How I communicate between Xenomai rt task and
	linux	task ?
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Josh Zhao <joshsystem@domain.hid>
Cc: xenomai@xenomai.org

Josh Zhao wrote:
 > Hi all,
 >        I know Xenomai has integrated  IPC, but is it suitable for linux
 > task?

There are two answers:
- you can use Xenomai native skin rt pipes, they allow communication
  between real-time and non real-time tasks;
- you can make your linux task a Xenomai task with priority 0, and use
  Xenomai other IPCs, your linux task will oscillate between primary
  (that is real-time) when using IPC services and secondary (non
  real-time) mode when doing its non real-time duties.

-- 


					    Gilles.

