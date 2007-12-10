Message-ID: <475D76FE.4090100@domain.hid>
Date: Mon, 10 Dec 2007 18:27:26 +0100
From: Theo Veenker <Theo.Veenker@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] multiple tasks calling rt_pipe_write() on same pipe
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Xenomai <xenomai@xenomai.org>

Hi,

I have multiple tasks all calling rt_pipe_write() to send some data
through the same pipe. Is my assumption that rt_pipe_write() won't be
interupted when a higher priority thread becomes ready correct?

Theo


