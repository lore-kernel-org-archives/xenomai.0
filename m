Message-ID: <bc4264770703060706x5dafb942weec4d4c2c5756427@domain.hid>
Date: Tue, 6 Mar 2007 15:06:47 +0000
From: "roland Tollenaar" <rolandtollenaar@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Subject: [Xenomai-help] RTCAN and tsc
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hi,

One thought did occur to me wrt to the problem of rtcan breaking RT
behaviour. I am not using TSC support (IPC's we have are all 486
processor family). I was told that this will give slightly worse
latency but at a 1ms period time this should not be a problem.

Just want to confirm at this stage that this is still correct?

Roland

