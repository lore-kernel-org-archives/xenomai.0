From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17864.63903.244809.994959@domain.hid>
Date: Tue, 6 Feb 2007 22:56:47 +0100
Subject: Re: [Xenomai-help] Multiple NIC trouble
In-Reply-To: <cbe23c50702061337yc411319l881b9402e4677d6d@domain.hid>
References: <cbe23c50702061337yc411319l881b9402e4677d6d@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Eric Noulard <eric.noulard@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

Eric Noulard wrote:
 > How would you suggest me to investigate that problem?

You should tell us what driver use your eth0 board, in order to see if
other people are able to reproduce the problem you have. Try enabling
kernel debugging and NMI watchdog. If it does not help, then add printks
in your ethernet driver code to try and see where exactly it hangs. Then
show here the result of your investigations, maybe people will have an
idea of why it hangs.

-- 


					    Gilles Chanteperdrix.

