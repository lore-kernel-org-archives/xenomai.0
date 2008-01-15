Message-ID: <db67beef0801151413sc078e51k1e14f76b3cdf6319@domain.hid>
Date: Tue, 15 Jan 2008 23:13:21 +0100
From: bite <anonimo.passante@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_8746_6651790.1200435201859"
Subject: [Xenomai-help] rtpipe problem not solved by 2.4.1
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai-help <xenomai@xenomai.org>

------=_Part_8746_6651790.1200435201859
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

working with 2.3.4 I have an occasional problem with rtpipe.

Writing several integers from the rt side with rt_pipe_write (..., P_NORMAL)
sometimes it happens that only the first integer can be read from non-rt.

The problem seems to be triggered by (moderately) heavy socket traffic, not
clear why.

Reading from the 2.4.1 log: "Close SMP race window in message pipe's
read-side", I decided to give it a try even if I'm not working with SMP, but
my problem persists.

It is not urgent for me, I found my way out by polling ring buffers instead
of using rtps, but I think it is worth raising the suspect that there _is_
even a non-SMP race condition.

Best regards,

Bite

------=_Part_8746_6651790.1200435201859
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,<br><br>working with 2.3.4 I have an occasional problem with rtpipe.<br><br>Writing several integers from the rt side with rt_pipe_write (..., P_NORMAL) sometimes it happens that only the first integer can be read from non-rt.
<br><br>The problem seems to be triggered by (moderately) heavy socket traffic, not clear why.<br><br>Reading from the 2.4.1 log: &quot;Close SMP race window in message pipe&#39;s read-side&quot;, I decided to give it a try even if I&#39;m not working with SMP, but my problem persists.
<br><br>It is not urgent for me, I found my way out by polling ring buffers instead of using rtps, but I think it is worth raising the suspect that there _is_ even a non-SMP race condition.<br><br>Best regards,<br><br>Bite
<br>

------=_Part_8746_6651790.1200435201859--

